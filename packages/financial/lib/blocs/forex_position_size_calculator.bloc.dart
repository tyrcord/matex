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
        currentState.fields.counter != null;
  }

  @override
  @protected
  Stream<MatexForexPositionSizeCalculatorBlocState> willCompute() async* {
    yield* super.willCompute();

    MatexQuote? quote;
    String? updatedOn;

    if (isMandatoryFieldValid) {
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
      final pipValue = dPipValue.toDouble();
      final positionSize = results.positionSize?.toDouble() ?? 0;

      // FIXME: review naming
      final standard = await getStandardLotValue();
      final mini = await getMiniLotValue();
      final micro = await getMicroLotValue();

      // FIXME: use decimal and helper
      final standardLotSize = positionSize / standard;
      final miniLotSize = positionSize / mini;
      final microLotSize = positionSize / micro;

      return MatexForexPositionSizeCalculatorBlocResults(
        formattedPipValue: localizeCurrency(
          value: pipValue,
          symbol: accountCurrency,
        ),
        pipValue: pipValue,
        formattedPositionSize: localizeNumber(
          minimumFractionDigits: 3,
          value: results.positionSize,
        ),
        positionSize: results.positionSize,
        formattedAmountAtRisk: localizeCurrency(
          value: results.amountAtRisk,
          symbol: accountCurrency,
        ),
        amountAtRisk: results.amountAtRisk,
        formattedStandardLotSize: localizeNumber(
          minimumFractionDigits: 3,
          value: standardLotSize,
        ),
        standardLotSize: standardLotSize,
        formattedMiniLotSize: localizeNumber(
          minimumFractionDigits: 3,
          value: miniLotSize,
        ),
        miniLotSize: miniLotSize,
        formattedMicroLotSize: localizeNumber(
          minimumFractionDigits: 3,
          value: microLotSize,
        ),
        microLotSize: microLotSize,
        formattedStopLossPips: localizeNumber(
          minimumFractionDigits: 3,
          value: results.stopLossPips,
        ),
        //TODO: add stop loss price (use delta helper)
        stopLossPips: results.stopLossPips,
        // FIXME: review naming
        formattedRiskRatio: localizePercentage(
          minimumFractionDigits: 3,
          value: results.riskPercent,
        ),
        riskRatio: results.riskPercent,
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

        case MatexForexPositionSizeCalculatorBlocKey.pipDecimalPlaces:
          return document.copyWith(pipDecimalPlaces: value);

        case MatexForexPositionSizeCalculatorBlocKey.accountSize:
          return document.copyWith(accountSize: value);

        case MatexForexPositionSizeCalculatorBlocKey.riskPercent:
          return document.copyWith(riskPercent: value);

        case MatexForexPositionSizeCalculatorBlocKey.riskAmount:
          return document.copyWith(riskAmount: value);

        case MatexForexPositionSizeCalculatorBlocKey.entryPrice:
          return document.copyWith(entryPrice: value);

        case MatexForexPositionSizeCalculatorBlocKey.stopLossPips:
          return document.copyWith(stopLossPips: value);

        case MatexForexPositionSizeCalculatorBlocKey.stopLossPrice:
          return document.copyWith(stopLossPrice: value);
      }
    } else if (value is Enum) {
      switch (key) {
        case MatexForexPositionSizeCalculatorBlocKey.riskFieldType:
          return document.copyWith(
            riskFieldType: value.name,
            riskAmount: '',
            riskPercent: '',
          );

        case MatexForexPositionSizeCalculatorBlocKey.stopLossFieldType:
          return document.copyWith(
            stopLossFieldType: value.name,
            stopLossPips: '',
            stopLossPrice: '',
            entryPrice: '',
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

        case MatexForexPositionSizeCalculatorBlocKey.pipDecimalPlaces:
          return patchPipDecimalPlaces(value);

        case MatexForexPositionSizeCalculatorBlocKey.accountSize:
          return patchAccountSize(value);

        case MatexForexPositionSizeCalculatorBlocKey.riskPercent:
          return patchRiskPercent(value);

        case MatexForexPositionSizeCalculatorBlocKey.riskAmount:
          return patchRiskAmount(value);

        case MatexForexPositionSizeCalculatorBlocKey.entryPrice:
          return patchEntryPrice(value);

        case MatexForexPositionSizeCalculatorBlocKey.stopLossPips:
          return patchStopLossPips(value);

        case MatexForexPositionSizeCalculatorBlocKey.stopLossPrice:
          return patchStopLossPrice(value);
      }
    } else if (value is Enum) {
      switch (key) {
        case MatexForexPositionSizeCalculatorBlocKey.riskFieldType:
          return patchRiskFieldType(value.name);

        case MatexForexPositionSizeCalculatorBlocKey.stopLossFieldType:
          return patchStopLossFieldType(value.name);

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
    }

    return null;
  }

  @override
  Future<void> resetCalculator(
    MatexForexPositionSizeCalculatorDocument document,
  ) async {
    final riskPercent = toDecimal(document.riskPercent) ?? dZero;

    calculator.setState(MatexForexPositionSizeCalculatorState(
      pipDecimalPlaces: parseStringToInt(document.pipDecimalPlaces),
      accountSize: parseStringToDouble(document.accountSize),
      riskPercent: (riskPercent / dHundred).toDouble(),
      riskAmount: parseStringToDouble(document.riskAmount),
      entryPrice: parseStringToDouble(document.entryPrice),
      stopLossPips: parseStringToDouble(document.stopLossPips),
      stopLossPrice: parseStringToDouble(document.stopLossPrice),
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
      formattedPositionSize: localizeCurrency(value: 0),
      positionSize: 0,
    );
  }

  MatexForexPositionSizeCalculatorBlocState patchAccountCurrency(
    String? value,
  ) {
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

  MatexForexPositionSizeCalculatorBlocState patchPipDecimalPlaces(
      String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(pipDecimalPlaces: value);
    calculator.pipDecimalPlaces = dValue.toDouble().toInt();

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchAccountSize(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(accountSize: value);
    calculator.accountSize = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchRiskPercent(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(riskPercent: value);
    calculator.riskPercent = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchRiskAmount(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(riskAmount: value);
    calculator.riskAmount = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchEntryPrice(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(entryPrice: value);
    calculator.entryPrice = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchStopLossPips(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(stopLossPips: value);
    calculator.stopLossPips = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchStopLossPrice(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(stopLossPrice: value);
    calculator.stopLossPrice = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchRiskFieldType(String value) {
    final fields = currentState.fields.copyWith(
      riskFieldType: value,
      riskPercent: '',
      riskAmount: '',
    );

    calculator
      ..riskPercent = 0
      ..riskAmount = 0;

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchStopLossFieldType(
    String value,
  ) {
    final fields = currentState.fields.copyWith(
      stopLossFieldType: value,
      entryPrice: '',
      stopLossPips: '',
      stopLossPrice: '',
    );

    calculator
      ..entryPrice = 0
      ..stopLossPips = 0
      ..stopLossPrice = 0;

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
