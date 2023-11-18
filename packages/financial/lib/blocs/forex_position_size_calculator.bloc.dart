// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:flutter/widgets.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

// Initialize default state for the Pip Value Calculator
final _kDefaultPipValueBlocState = MatexForexPositionSizeCalculatorBlocState(
  fields: MatexForexPositionSizeCalculatorBlocFields(),
  results: const MatexForexPositionSizeCalculatorBlocResults(),
);

class MatexForexPositionSizeCalculatorBloc extends MatexFinancialCalculatorBloc<
        MatexForexPositionSizeCalculator,
        FastCalculatorBlocEvent,
        MatexForexPositionSizeCalculatorBlocState,
        MatexForexPositionSizeCalculatorDocument,
        MatexForexPositionSizeCalculatorBlocResults>
    with MatexFinancialCalculatorFormatterMixin {
  final MatexFinancialInstrumentExchangeService exchangeProvider;

  MatexForexPositionSizeCalculatorBloc({
    MatexForexPositionSizeCalculatorBlocState? initialState,
    MatexForexPositionSizeCalculatorDataProvider? dataProvider,
    required this.exchangeProvider,
    super.debouceComputeEvents = true,
    super.isAutoRefreshEnabled = false,
    super.showExportPdfDialog,
    super.autoRefreshPeriod,
    super.delegate,
  }) : super(
          initialState: initialState ?? _kDefaultPipValueBlocState,
          dataProvider:
              dataProvider ?? MatexForexPositionSizeCalculatorDataProvider(),
          debugLabel: 'MatexForexPositionSizeCalculatorBloc',
        ) {
    calculator = MatexForexPositionSizeCalculator();

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorFinancialInstrument.name,
      MatexForexPositionSizeCalculatorBlocKey.instrument,
    );

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
        key: MatexForexPositionSizeCalculatorBlocKey.accountCurrency,
        value: getUserCurrencyCode(),
      ));
    }
  }

  @override
  bool get isMandatoryFieldValid {
    return currentState.fields.accountCurrency != null &&
        currentState.fields.base != null &&
        currentState.fields.counter != null &&
        (currentState.fields.positionSize != null ||
            currentState.fields.lotSize != null);
  }

  @override
  @protected
  Stream<MatexForexPositionSizeCalculatorBlocState> willCompute() async* {
    yield* super.willCompute();

    var fields = currentState.fields;
    MatexQuote? quote;
    String? updatedOn;

    if (isMandatoryFieldValid) {
      quote = await patchExchangeRates();

      if (quote != null) {
        updatedOn = await localizeTimestampInMilliseconds(quote.timestamp);
      }
    }

    if (fields.positionSizeFieldType != MatexPositionSizeType.unit.name &&
        fields.lotSize != null &&
        fields.lotSize!.isNotEmpty) {
      final positionSize = await getPositionSizeForLotSize(
        lotSize: getPositionSizeTypeFromString(fields.positionSizeFieldType),
        positionSize: parseFieldValueToDouble(fields.lotSize),
      );

      final isInt = isDoubleInteger(positionSize);

      calculator.positionSize = positionSize;
      fields = fields.copyWith(
        positionSize:
            isInt ? positionSize.toInt().toString() : positionSize.toString(),
      );
    }

    yield currentState.copyWith(
      fields: fields,
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

    if (instrumentPairRate > 0 && isMandatoryFieldValid) {
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
      'microLotSize': microLotSize,
      'miniLotSize': miniLotSize,
    };
  }

  @override
  Future<MatexForexPositionSizeCalculatorBlocResults> compute() async {
    if (await isCalculatorStateValid()) {
      final results = calculator.value();
      final fields = currentState.fields;
      final accountCurrency = fields.accountCurrency;
      final dPipValue = toDecimal(results.pipValue) ?? dZero;
      final dNumberOfPips = toDecimal(fields.numberOfPips) ?? dZero;
      final dCustomPipValue = dPipValue * dNumberOfPips;

      final customPipValue = dCustomPipValue.toDouble();
      final pipValue = dPipValue.toDouble();
      final positionSize = calculator.positionSize;

      final standard = await getStandardLotValue();
      final mini = await getMiniLotValue();
      final micro = await getMicroLotValue();

      final standardLotValue = computePipValueForLotSize(
        standard,
        pipValue,
        positionSize,
      );

      final miniLotValue = computePipValueForLotSize(
        mini,
        pipValue,
        positionSize,
      );

      final microLotValue = computePipValueForLotSize(
        micro,
        pipValue,
        positionSize,
      );

      return MatexForexPositionSizeCalculatorBlocResults(
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
            positionSize,
          ),
        ),
        formattedMiniLotValue: localizeCurrency(
          symbol: accountCurrency,
          minimumFractionDigits: 3,
          value: computePipValueForLotSize(
            mini,
            pipValue,
            positionSize,
          ),
        ),
        formattedMicroLotValue: localizeCurrency(
          symbol: accountCurrency,
          minimumFractionDigits: 3,
          value: computePipValueForLotSize(
            micro,
            pipValue,
            positionSize,
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
  Future<MatexForexPositionSizeCalculatorDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value is Map<dynamic, dynamic> &&
        key == MatexForexPositionSizeCalculatorBlocKey.instrument) {
      value = MatexFinancialInstrument.fromJson(value);
    }

    if (value is String) {
      switch (key) {
        case MatexForexPositionSizeCalculatorBlocKey.accountCurrency:
          return document.copyWith(accountCurrency: value);

        case MatexForexPositionSizeCalculatorBlocKey.positionSize:
          return document.copyWith(positionSize: value);

        case MatexForexPositionSizeCalculatorBlocKey.numberOfPips:
          return document.copyWith(numberOfPips: value);

        case MatexForexPositionSizeCalculatorBlocKey.pipDecimalPlaces:
          return document.copyWith(pipDecimalPlaces: value);

        case MatexForexPositionSizeCalculatorBlocKey.lotSize:
          return document.copyWith(lotSize: value);
      }
    } else if (value is Enum) {
      switch (key) {
        case MatexForexPositionSizeCalculatorBlocKey.positionSizeFieldType:
          return document.copyWith(
            positionSizeFieldType: value.name,
            positionSize: '',
            lotSize: '',
          );
      }
    } else if (value is MatexFinancialInstrument) {
      switch (key) {
        case MatexForexPositionSizeCalculatorBlocKey.instrument:
          final pipDecimalPlaces = await getPipPrecision(
            counter: value.counter,
            base: value.base,
          );

          return document.copyWith(
            pipDecimalPlaces: pipDecimalPlaces.toString(),
            counter: value.counter,
            base: value.base,
          );
      }
    }

    return null;
  }

  @override
  Future<MatexForexPositionSizeCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is Map<dynamic, dynamic> &&
        key == MatexForexPositionSizeCalculatorBlocKey.instrument) {
      value = MatexFinancialInstrument.fromJson(value);
    }

    if (value is String) {
      switch (key) {
        case MatexForexPositionSizeCalculatorBlocKey.accountCurrency:
          return patchAccountCurrency(value);

        case MatexForexPositionSizeCalculatorBlocKey.positionSize:
          return patchPositionSize(value);

        case MatexForexPositionSizeCalculatorBlocKey.numberOfPips:
          return patchNumberOfPips(value);

        case MatexForexPositionSizeCalculatorBlocKey.pipDecimalPlaces:
          return patchPipDecimalPlaces(value);

        case MatexForexPositionSizeCalculatorBlocKey.lotSize:
          return patchLotSize(value);
      }
    } else if (value is Enum) {
      switch (key) {
        case MatexForexPositionSizeCalculatorBlocKey.positionSizeFieldType:
          return patchPositionSizeFieldType(value.name);

        default:
          debugLog('Invalid key: $key', debugLabel: debugLabel);
          break;
      }
    } else if (value is MatexFinancialInstrument) {
      switch (key) {
        case MatexForexPositionSizeCalculatorBlocKey.instrument:
          return patchInstrument(value);
      }
    }

    return null;
  }

  @override
  Future<MatexForexPositionSizeCalculatorDocument?> resetCalculatorDocument(
    String key,
  ) async {
    switch (key) {
      case MatexForexPositionSizeCalculatorBlocKey.accountCurrency:
        return document.copyWithDefaults(accountCurrency: true);

      case MatexForexPositionSizeCalculatorBlocKey.instrument:
        return document.copyWithDefaults(
          counter: true,
          base: true,
        );
      case MatexForexPositionSizeCalculatorBlocKey.numberOfPips:
        return document.copyWithDefaults(numberOfPips: true);
    }

    return null;
  }

  @override
  Future<MatexForexPositionSizeCalculatorBlocState?> resetCalculatorState(
    String key,
  ) async {
    switch (key) {
      case MatexForexPositionSizeCalculatorBlocKey.accountCurrency:
        return patchAccountCurrency(null);

      case MatexForexPositionSizeCalculatorBlocKey.instrument:
        return patchInstrument(null);

      case MatexForexPositionSizeCalculatorBlocKey.numberOfPips:
        return patchNumberOfPips(null);
    }

    return null;
  }

  @override
  Future<void> resetCalculator(
    MatexForexPositionSizeCalculatorDocument document,
  ) async {
    calculator.setState(MatexForexPositionSizeCalculatorState(
      pipDecimalPlaces: parseStringToInt(document.pipDecimalPlaces),
      positionSize: parseStringToDouble(document.positionSize),
    ));
  }

  @override
  Future<MatexForexPositionSizeCalculatorBlocState> resetCalculatorBlocState(
    MatexForexPositionSizeCalculatorDocument document,
  ) async {
    final pipDecimalPlaces = await getPipPrecision(
      counter: document.counter,
      base: document.base,
    );

    return _kDefaultPipValueBlocState.copyWith(
      results: await retrieveDefaultResult(),
      fields: MatexForexPositionSizeCalculatorBlocFields(
        pipDecimalPlaces: pipDecimalPlaces.toString(),
        accountCurrency: document.accountCurrency,
        counter: document.counter,
        base: document.base,
      ),
    );
  }

  @override
  Future<MatexForexPositionSizeCalculatorDocument>
      retrieveDefaultCalculatorDocument() async {
    final bloc = FastAppDictBloc.instance;
    final json = bloc.getValue<Map<dynamic, dynamic>?>(
      MatexCalculatorDefaultValueKeys.matexCalculatorFinancialInstrument.name,
    );

    debugLog(
      'retrieveDefaultCalculatorDocument: $json',
      debugLabel: debugLabel,
    );

    MatexFinancialInstrument? instrument;

    int pipDecimalPlaces = kDefaultPipPipDecimalPlaces;

    if (json != null) {
      instrument = MatexFinancialInstrument.fromJson(json);

      pipDecimalPlaces = await getPipPrecision(
        counter: instrument.counter,
        base: instrument.base,
      );
    }

    return MatexForexPositionSizeCalculatorDocument(
      pipDecimalPlaces: pipDecimalPlaces.toString(),
      accountCurrency: getUserCurrencyCode(),
      counter: instrument?.counter,
      base: instrument?.base,
    );
  }

  @override
  Future<MatexForexPositionSizeCalculatorBlocResults>
      retrieveDefaultResult() async {
    return MatexForexPositionSizeCalculatorBlocResults(
      formattedPipValue: localizeCurrency(value: 0),
      pipValue: 0,
    );
  }

  MatexForexPositionSizeCalculatorBlocState patchAccountCurrency(
      String? value) {
    late final MatexForexPositionSizeCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(accountCurrency: true);
    } else {
      fields = currentState.fields.copyWith(accountCurrency: value);
    }

    return currentState.copyWith(fields: fields);
  }

  Future<MatexForexPositionSizeCalculatorBlocState> patchInstrument(
    MatexFinancialInstrument? instrument,
  ) async {
    late final MatexForexPositionSizeCalculatorBlocFields fields;

    calculator
      ..counterToAccountCurrencyRate = 0
      ..isAccountCurrencyCounter = false
      ..instrumentPairRate = 0;

    // Note: Loads default metadata values from the super class.
    // instrument metadata will be loaded in the willCompute method.
    final metadata = await super.loadMetadata();

    if (instrument == null) {
      fields = currentState.fields.copyWithDefaults(
        pipDecimalPlaces: true,
        counter: true,
        base: true,
      );

      calculator.pipDecimalPlaces = kDefaultPipPipDecimalPlaces;
    } else {
      final pipDecimalPlaces = await getPipPrecision(
        counter: instrument.counter,
        base: instrument.base,
      );

      fields = currentState.fields.copyWith(
        pipDecimalPlaces: pipDecimalPlaces.toString(),
        counter: instrument.counter,
        base: instrument.base,
      );

      calculator.pipDecimalPlaces = pipDecimalPlaces;
    }

    return currentState.copyWith(fields: fields, metadata: metadata);
  }

  MatexForexPositionSizeCalculatorBlocState patchPositionSize(String value) {
    final fields = currentState.fields.copyWith(positionSize: value);
    final positionSizeFieldType = fields.positionSizeFieldType;

    if (positionSizeFieldType == MatexPositionSizeType.unit.name) {
      final dValue = toDecimal(value) ?? dZero;
      calculator.positionSize = dValue.toDouble();

      return currentState.copyWith(fields: fields);
    }

    return currentState;
  }

  MatexForexPositionSizeCalculatorBlocState patchLotSize(String value) {
    final fields = currentState.fields.copyWith(lotSize: value);
    final positionSizeFieldType = fields.positionSizeFieldType;

    if (positionSizeFieldType != MatexPositionSizeType.unit.name) {
      final dValue = toDecimal(value) ?? dZero;
      calculator.positionSize = dValue.toDouble();

      return currentState.copyWith(fields: fields);
    }

    return currentState;
  }

  MatexForexPositionSizeCalculatorBlocState patchNumberOfPips(String? value) {
    late final MatexForexPositionSizeCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(numberOfPips: true);
    } else {
      fields = currentState.fields.copyWith(numberOfPips: value);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchPipDecimalPlaces(
      String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(pipDecimalPlaces: value);
    calculator.pipDecimalPlaces = dValue.toDouble().toInt();

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchPositionSizeFieldType(
      String value) {
    final fields = currentState.fields.copyWith(
      positionSizeFieldType: value,
      positionSize: '',
      lotSize: '',
    );

    calculator.positionSize = 0;

    return currentState.copyWith(fields: fields);
  }

  Future<MatexQuote?> patchExchangeRates() async {
    final accountCurrency = currentState.fields.accountCurrency!;
    final counter = currentState.fields.counter!;
    final base = currentState.fields.base!;
    final pipDecimalPlaces = currentState.fields.pipDecimalPlaces;
    final symbol = base + counter;
    final instrumentQuoteFuture = exchangeProvider.rate(symbol);

    if (pipDecimalPlaces == null) {
      final pairMetadata = await getInstrumentMetadata();

      if (pairMetadata != null) {
        calculator.pipDecimalPlaces = pairMetadata.pip.precision;
      } else {
        calculator.pipDecimalPlaces = kDefaultPipPipDecimalPlaces;
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
      ..isAccountCurrencyCounter = false;

    if (accountCurrency == counter) {
      calculator.isAccountCurrencyCounter = true;
    } else {
      final symbol = counter + accountCurrency;
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
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexForexPositionSizeCalculatorPdfGenerator();
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
