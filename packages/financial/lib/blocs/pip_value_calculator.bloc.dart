// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

// Initialize default state for the Pip Value Calculator
final _kDefaultPipValueBlocState = MatexPipValueCalculatorBlocState(
  fields: MatexPipValueCalculatorBlocFields(),
  results: const MatexPipValueCalculatorBlocResults(),
);

class MatexPipValueCalculatorBloc extends MatexFinancialCalculatorBloc<
        MatexPipValueCalculator,
        FastCalculatorBlocEvent,
        MatexPipValueCalculatorBlocState,
        MatexPipValueCalculatorDocument,
        MatexPipValueCalculatorBlocResults>
    with MatexFinancialCalculatorFormatterMixin {
  final MatexFinancialInstrumentExchangeService exchangeProvider;

  MatexPipValueCalculatorBloc({
    MatexPipValueCalculatorBlocState? initialState,
    MatexPipValueCalculatorDataProvider? dataProvider,
    required this.exchangeProvider,
    super.debouceComputeEvents = true,
    super.isAutoRefreshEnabled = false,
    super.showExportPdfDialog,
    super.autoRefreshPeriod,
    super.delegate,
  }) : super(
          initialState: initialState ?? _kDefaultPipValueBlocState,
          dataProvider: dataProvider ?? MatexPipValueCalculatorDataProvider(),
          debugLabel: 'MatexPipValueCalculatorBloc',
        ) {
    calculator = MatexPipValueCalculator();

    // FIXME:
    // Add listeners for default value changes if needed

    _listenToPrimaryCurrencyCodeChanges();
  }

  @override
  void close() {
    if (!isClosed && canClose()) {
      exchangeProvider.dispose();
      super.close();
    }
  }

  void _listenToPrimaryCurrencyCodeChanges() {
    subxList.add(appSettingsBloc.onData
        .where((event) => isInitialized)
        .distinct((previous, next) {
      final previousValue = previous.primaryCurrencyCode;
      final nextValue = next.primaryCurrencyCode;

      return previousValue == nextValue;
    }).listen(handlePrimaryCurrencyCodeChanges));
  }

  void handlePrimaryCurrencyCodeChanges(FastAppSettingsBlocState state) {
    if (isInitialized) {
      addEvent(FastCalculatorBlocEvent.retrieveDefaultValues());

      addEvent(FastCalculatorBlocEvent.patchValue(
        key: MatexPipValueCalculatorBlocKey.accountCurrency,
        value: getUserCurrencyCode(),
      ));
    }
  }

  @override
  Future<bool> isMandatoryFieldValid() async {
    return currentState.fields.accountCurrency != null &&
        currentState.fields.baseCurrency != null &&
        currentState.fields.counterCurrency != null;
  }

  @override
  @protected
  Stream<MatexPipValueCalculatorBlocState> willCompute() async* {
    yield* super.willCompute();

    MatexQuote? quote;
    String? updatedOn;

    if (await isMandatoryFieldValid()) {
      quote = await patchExchangeRates();

      if (quote != null) {
        updatedOn = await localizeTimestampInMilliseconds(quote.timestamp);
      }
    }

    yield currentState.copyWith(
      metadata: {
        ...await loadMetadata(),
        'updatedOn': updatedOn,
      },
    );
  }

  /// Loads the metadata of the calculator.
  @override
  @mustCallSuper
  Future<Map<String, dynamic>> loadMetadata() async {
    final metadata = await super.loadMetadata();
    final standardLotSize = await getStandardLotValue();
    final miniLotSize = await getMiniLotValue();
    final microLotSize = await getMicroLotValue();
    final instrumentMetadata = await getInstrumentMetadata();
    final instrumentPairRate = calculator.instrumentPairRate ?? 0;

    if (instrumentPairRate > 0 && await isMandatoryFieldValid()) {
      metadata.putIfAbsent('formattedInstrumentExchangeRate', () {
        final formatted = localizeQuote(
          rate: calculator.instrumentPairRate,
          metadata: instrumentMetadata,
        );

        return superscriptLastCharacter(formatted);
      });
    }

    return {
      ...metadata,
      'instrumentMetadata': instrumentMetadata,
      'standardLotSize': standardLotSize,
      'miniLotSize': miniLotSize,
      'microLotSize': microLotSize,
    };
  }

  @override
  Future<MatexPipValueCalculatorBlocResults> compute() async {
    if (await isCalculatorStateValid()) {
      final results = calculator.value();
      final fields = currentState.fields;
      final accountCurrency = fields.accountCurrency;
      final dPipValue = toDecimal(results.pipValue) ?? dZero;
      final dNumberOfPips = toDecimal(fields.numberOfPips) ?? dZero;
      final dCustomPipValue = dPipValue * dNumberOfPips;

      final customPipValue = dCustomPipValue.toDouble();
      final pipValue = dPipValue.toDouble();
      final positionSize = fields.positionSize;

      final standard = await getStandardLotValue();
      final mini = await getMiniLotValue();
      final micro = await getMicroLotValue();

      final standardLotValue = computePipValueForLotSize(
        standard,
        pipValue,
        parseStringToDouble(positionSize),
      );

      final miniLotValue = computePipValueForLotSize(
        mini,
        pipValue,
        parseStringToDouble(positionSize),
      );

      final microLotValue = computePipValueForLotSize(
        micro,
        pipValue,
        parseStringToDouble(positionSize),
      );

      return MatexPipValueCalculatorBlocResults(
        formattedPipValue: localizeCurrency(
          minimumFractionDigits: 3,
          symbol: accountCurrency,
          value: pipValue,
        ),
        formattedCustomPipValue: localizeCurrency(
          minimumFractionDigits: 3,
          symbol: accountCurrency,
          value: customPipValue,
        ),
        formattedStandardLotValue: localizeCurrency(
          symbol: accountCurrency,
          minimumFractionDigits: 3,
          value: computePipValueForLotSize(
            standard,
            pipValue,
            parseStringToDouble(positionSize),
          ),
        ),
        formattedMiniLotValue: localizeCurrency(
          symbol: accountCurrency,
          minimumFractionDigits: 3,
          value: computePipValueForLotSize(
            mini,
            pipValue,
            parseStringToDouble(positionSize),
          ),
        ),
        formattedMicroLotValue: localizeCurrency(
          symbol: accountCurrency,
          minimumFractionDigits: 3,
          value: computePipValueForLotSize(
            micro,
            pipValue,
            parseStringToDouble(positionSize),
          ),
        ),
        standardLotValue: standardLotValue.toDouble(),
        microLotValue: microLotValue.toDouble(),
        miniLotValue: miniLotValue.toDouble(),
        customPipValue: customPipValue,
        pipValue: pipValue,
      );
    }

    return retrieveDefaultResult();
  }

  @override
  Future<MatexPipValueCalculatorDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      switch (key) {
        case MatexPipValueCalculatorBlocKey.accountCurrency:
          return document.copyWith(accountCurrency: value);

        case MatexPipValueCalculatorBlocKey.positionSize:
          return document.copyWith(positionSize: value);

        case MatexPipValueCalculatorBlocKey.numberOfPips:
          return document.copyWith(numberOfPips: value);

        case MatexPipValueCalculatorBlocKey.pipDecimalPlaces:
          return document.copyWith(pipDecimalPlaces: value);
      }
    } else if (value is Enum) {
      value = describeEnum(value);

      switch (key) {
        case MatexPipValueCalculatorBlocKey.positionSizeFieldType:
          return document.copyWith(
            positionSizeFieldType: value,
            positionSize: '',
          );
      }
    } else if (value is MatexFinancialInstrument) {
      switch (key) {
        case MatexPipValueCalculatorBlocKey.instrument:
          final pipDecimalPlaces = await getPipPrecision(
            baseCurrency: value.baseCode,
            counterCurrency: value.counterCode,
          );

          return document.copyWith(
            baseCurrency: value.baseCode,
            counterCurrency: value.counterCode,
            pipDecimalPlaces: pipDecimalPlaces.toString(),
          );
      }
    }

    return null;
  }

  @override
  Future<MatexPipValueCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      switch (key) {
        case MatexPipValueCalculatorBlocKey.accountCurrency:
          return patchAccountCurrency(value);

        case MatexPipValueCalculatorBlocKey.positionSize:
          return patchPositionSize(value);

        case MatexPipValueCalculatorBlocKey.numberOfPips:
          return patchNumberOfPips(value);

        case MatexPipValueCalculatorBlocKey.pipDecimalPlaces:
          return patchPipDecimalPlaces(value);
      }
    } else if (value is Enum) {
      value = describeEnum(value);

      switch (key) {
        case MatexPipValueCalculatorBlocKey.positionSizeFieldType:
          return patchPositionSizeFieldType(value);

        default:
          debugLog('Invalid key: $key', debugLabel: debugLabel);
          break;
      }
    } else if (value is MatexFinancialInstrument) {
      switch (key) {
        case MatexPipValueCalculatorBlocKey.instrument:
          return patchInstrument(value);
      }
    }

    return null;
  }

  Future<MatexQuote?> patchExchangeRates() async {
    final accountCurrency = currentState.fields.accountCurrency!;
    final counterCurrency = currentState.fields.counterCurrency!;
    final baseCurrency = currentState.fields.baseCurrency!;
    final pipDecimalPlaces = currentState.fields.pipDecimalPlaces;
    final symbol = baseCurrency + counterCurrency;
    final instrumentQuoteFuture = exchangeProvider.rate(symbol);

    if (pipDecimalPlaces == null) {
      final pairMetadata = await getInstrumentMetadata();

      if (pairMetadata != null) {
        calculator.pipDecimalPlaces = pairMetadata.pip.precision;
      } else {
        calculator.pipDecimalPlaces = defaultPipDecimalPlaces;
      }
    }

    final instrumentQuote = await instrumentQuoteFuture;

    if (instrumentQuote == null) {
      // FIXME: display an error message
      return null;
    }

    calculator
      ..instrumentPairRate = instrumentQuote.price
      ..counterToAccountCurrencyRate = 0
      ..isAccountCurrencyCounterCurrency = false;

    if (accountCurrency == counterCurrency) {
      calculator.isAccountCurrencyCounterCurrency = true;
    } else {
      final symbol = counterCurrency + accountCurrency;
      final accountBaseQuote = await exchangeProvider.rate(symbol);

      if (accountBaseQuote == null) {
        // FIXME: display an error message
        return null;
      }

      calculator.counterToAccountCurrencyRate = accountBaseQuote.price;
    }

    return instrumentQuote;
  }

  @override
  Future<MatexPipValueCalculatorDocument?> resetCalculatorDocument(
    String key,
  ) async {
    switch (key) {
      case MatexPipValueCalculatorBlocKey.accountCurrency:
        return document.copyWithDefaults(accountCurrency: true);

      case MatexPipValueCalculatorBlocKey.instrument:
        return document.copyWithDefaults(
          counterCurrency: true,
          baseCurrency: true,
        );
    }

    return null;
  }

  @override
  Future<MatexPipValueCalculatorBlocState?> resetCalculatorState(
    String key,
  ) async {
    switch (key) {
      case MatexPipValueCalculatorBlocKey.accountCurrency:
        return patchAccountCurrency(null);

      case MatexPipValueCalculatorBlocKey.instrument:
        return patchInstrument(null);
    }

    return null;
  }

  @override
  Future<void> resetCalculator(
    MatexPipValueCalculatorDocument document,
  ) async {
    calculator.setState(MatexPipValueCalculatorState(
      pipDecimalPlaces: parseStringToInt(document.pipDecimalPlaces),
      positionSize: parseStringToDouble(document.positionSize),
    ));
  }

  @override
  Future<MatexPipValueCalculatorBlocState> resetCalculatorBlocState(
    MatexPipValueCalculatorDocument document,
  ) async {
    final pipDecimalPlaces = await getPipPrecision(
      baseCurrency: document.baseCurrency,
      counterCurrency: document.counterCurrency,
    );

    return _kDefaultPipValueBlocState.copyWith(
      fields: MatexPipValueCalculatorBlocFields(
        // FIXME: add default values here
        pipDecimalPlaces: pipDecimalPlaces.toString(),
        accountCurrency: document.accountCurrency,
      ),
    );
  }

  @override
  Future<MatexPipValueCalculatorDocument>
      retrieveDefaultCalculatorDocument() async {
    // final bloc = FastAppDictBloc.instance;

    // FIXME: get default instrument from the settings
    // final pipDecimalPlaces = await getPipPrecision(
    //   baseCurrency: document.baseCurrency,
    //   counterCurrency: document.counterCurrency,
    // );

    return MatexPipValueCalculatorDocument(
      // FIXME: add default values here
      accountCurrency: getUserCurrencyCode(),
    );
  }

  @override
  Future<MatexPipValueCalculatorBlocResults> retrieveDefaultResult() async {
    return MatexPipValueCalculatorBlocResults(
      formattedPipValue: localizeCurrency(value: 0),
      pipValue: 0,
    );
  }

  MatexPipValueCalculatorBlocState patchAccountCurrency(String? value) {
    late final MatexPipValueCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(accountCurrency: true);
    } else {
      fields = currentState.fields.copyWith(accountCurrency: value);
    }

    return currentState.copyWith(fields: fields);
  }

  Future<MatexPipValueCalculatorBlocState> patchInstrument(
    MatexFinancialInstrument? instrument,
  ) async {
    late final MatexPipValueCalculatorBlocFields fields;

    calculator
      ..counterToAccountCurrencyRate = 0
      ..instrumentPairRate = 0;

    // Note: Loads default metadata values from the super class.
    // instrument metadata will be loaded in the willCompute method.
    final metadata = await super.loadMetadata();

    if (instrument == null) {
      fields = currentState.fields.copyWithDefaults(
        pipDecimalPlaces: true,
        counterCurrency: true,
        baseCurrency: true,
      );

      calculator.pipDecimalPlaces = defaultPipDecimalPlaces;
    } else {
      final pipDecimalPlaces = await getPipPrecision(
        counterCurrency: instrument.counterCode,
        baseCurrency: instrument.baseCode,
      );

      fields = currentState.fields.copyWith(
        pipDecimalPlaces: pipDecimalPlaces.toString(),
        counterCurrency: instrument.counterCode,
        baseCurrency: instrument.baseCode,
      );

      calculator.pipDecimalPlaces = pipDecimalPlaces;
    }

    return currentState.copyWith(fields: fields, metadata: metadata);
  }

  MatexPipValueCalculatorBlocState patchPositionSize(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(positionSize: value);
    calculator.positionSize = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexPipValueCalculatorBlocState patchNumberOfPips(String value) {
    final fields = currentState.fields.copyWith(numberOfPips: value);

    return currentState.copyWith(fields: fields);
  }

  MatexPipValueCalculatorBlocState patchPipDecimalPlaces(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(pipDecimalPlaces: value);
    calculator.pipDecimalPlaces = dValue.toDouble().toInt();

    return currentState.copyWith(fields: fields);
  }

  MatexPipValueCalculatorBlocState patchPositionSizeFieldType(String value) {
    final fields = currentState.fields.copyWith(
      positionSizeFieldType: value,
      positionSize: '',
    );

    calculator.positionSize = 0;

    return currentState.copyWith(fields: fields);
  }

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexPipValueCalculatorPdfGenerator();
    final fields = currentState.fields;
    final results = await compute();
    final metadata = currentState.metadata;

    // ignore: use_build_context_synchronously
    return pdfGenerator.generate(
      context,
      fields,
      results,
      metadata,
    );
  }
}
