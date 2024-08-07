// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';
import 'package:tlogger/logger.dart';

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
  static const defaultDebugLabel = 'MatexForexPositionSizeCalculatorBloc';

  MatexForexPositionSizeCalculatorBloc({
    MatexForexPositionSizeCalculatorBlocState? initialState,
    MatexForexPositionSizeCalculatorDataProvider? dataProvider,
    super.exportAlternativeAction,
    required super.exchangeProvider,
    super.debouceComputeEvents = true,
    super.isAutoRefreshEnabled = false,
    super.getExportDialog,
    super.autoRefreshPeriod,
    super.delegate,
    super.getContext,
  }) : super(
          initialState: initialState ?? _kDefaultPipValueBlocState,
          dataProvider:
              dataProvider ?? MatexForexPositionSizeCalculatorDataProvider(),
          debugLabel: defaultDebugLabel,
        ) {
    logger = TLoggerManager().getLogger(defaultDebugLabel);
    calculator = MatexForexPositionSizeCalculator();

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorFinancialInstrument.name,
      MatexForexPositionSizeCalculatorBlocKey.instrument,
    );

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorRiskPercent.name,
      MatexForexPositionSizeCalculatorBlocKey.riskPercent,
    );

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorRiskType.name,
      MatexForexPositionSizeCalculatorBlocKey.riskFieldType,
    );

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorStopLossType.name,
      MatexForexPositionSizeCalculatorBlocKey.stopLossFieldType,
    );

    listenToPrimaryCurrencyCodeChanges();
  }

  @override
  @mustCallSuper
  String getUserCurrencyCode() {
    String? localeCode = currentState.fields.accountCurrency?.toUpperCase();
    localeCode ??= super.getUserCurrencyCode();

    return localeCode;
  }

  @override
  @protected
  Stream<MatexForexPositionSizeCalculatorBlocState> willCompute() async* {
    yield* super.willCompute();

    final accountCurrency = currentState.fields.accountCurrency;
    final instrument = currentState.fields.financialInstrument;

    // update the state metadata with the latest instrument metadata
    if (instrument == null) {
      yield currentState.copyWith(
        metadata: mergeMetadata(emptyInstrumentMetadata),
      );
    } else {
      yield* patchInstrumentExchangeRate(instrument);
    }

    final quote = currentMetadata['instrumentExchangeRate'] as double?;

    // update the calculator with the latest instrument exchange rate
    await patchCalculatorExchangeRates(
      accountCurrency: accountCurrency!,
      instrumentPairRate: quote,
      instrument: instrument,
    );
  }

  @override
  Future<MatexForexPositionSizeCalculatorBlocResults> compute() async {
    if (await isCalculatorStateValid()) {
      final results = calculator.value();
      final fields = currentState.fields;

      final instrumentMetadata = await getInstrumentMetadata();
      final standardLotUnits = await getUnitsPerStandardLot();
      final miniLotUnits = await getUnitsPerMiniLot();
      final microLotUnits = await getUnitsPerMicroLot();

      final stopLossPips = results.stopLossPips ?? 0;
      final resultsRange = <MatexForexPositionSizeCalculatorBlocResults>[];

      if (stopLossPips > 0) {
        final tmpCalculator = MatexForexPositionSizeCalculator();
        final pipsRange = rangeAroundN(stopLossPips, 10, loose: true);
        final calculatorState = calculator.getState();
        tmpCalculator.setState(calculatorState);

        for (final pips in pipsRange) {
          tmpCalculator.stopLossPips = pips.toDouble();
          final tmpResults = tmpCalculator.value();

          final tmpFormattedResults = _buildResults(
            instrumentMetadata: instrumentMetadata,
            standardLotUnits: standardLotUnits,
            microLotUnits: microLotUnits,
            miniLotUnits: miniLotUnits,
            results: tmpResults,
            fields: fields,
          );

          resultsRange.add(tmpFormattedResults);
        }
      }

      return _buildResults(
        instrumentMetadata: instrumentMetadata,
        standardLotUnits: standardLotUnits,
        microLotUnits: microLotUnits,
        miniLotUnits: miniLotUnits,
        range: resultsRange,
        results: results,
        fields: fields,
      );
    }

    return retrieveDefaultResult();
  }

  MatexForexPositionSizeCalculatorBlocResults _buildResults({
    required MatexForexPositionSizeCalculatorResults results,
    required MatexForexPositionSizeCalculatorBlocFields fields,
    required double standardLotUnits,
    required double miniLotUnits,
    required double microLotUnits,
    MatexPairMetadata? instrumentMetadata,
    List<MatexForexPositionSizeCalculatorBlocResults>? range,
  }) {
    final accountCurrency = fields.accountCurrency;
    final positionSize = results.positionSize ?? 0;
    final stopLossPips = results.stopLossPips ?? 0;
    final pipValue = results.pipValue ?? 0;

    final standardLotSize = (positionSize / standardLotUnits);
    final miniLotSize = (positionSize / miniLotUnits);
    final microLotSize = (positionSize / microLotUnits);

    return MatexForexPositionSizeCalculatorBlocResults(
      formattedPipValue: localizeCurrency(
        minimumFractionDigits: 3,
        value: pipValue,
        symbol: accountCurrency,
      ),
      pipValue: pipValue,
      formattedPositionSize: localizeNumber(
        minimumFractionDigits: 3,
        value: positionSize,
      ),
      positionSize: positionSize,
      formattedAmountAtRisk: localizeCurrency(
        minimumFractionDigits: 3,
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
        value: stopLossPips,
      ),
      stopLossPips: stopLossPips,
      formattedRiskRatio: localizePercentage(
        minimumFractionDigits: 3,
        value: results.riskPercent,
      ),
      riskRatio: results.riskPercent,
      formattedStopLossPrice: localizeQuote(
        rate: results.stopLossPrice,
        metadata: instrumentMetadata,
      ),
      stopLossPrice: results.stopLossPrice,
      range: range,
    );
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

    if (value == null) {
      switch (key) {
        case MatexFiancialCalculatorBlocKey.accountCurrency:
          return document.copyWithDefaults(resetAccountCurrency: true);

        case MatexForexPositionSizeCalculatorBlocKey.pipDecimalPlaces:
          return document.copyWithDefaults(resetPipDecimalPlaces: true);

        case MatexForexPositionSizeCalculatorBlocKey.accountSize:
          return document.copyWithDefaults(resetAccountSize: true);

        case MatexForexPositionSizeCalculatorBlocKey.riskPercent:
          return document.copyWithDefaults(resetRiskPercent: true);

        case MatexForexPositionSizeCalculatorBlocKey.riskAmount:
          return document.copyWithDefaults(resetRiskAmount: true);

        case MatexForexPositionSizeCalculatorBlocKey.entryPrice:
          return document.copyWithDefaults(resetEntryPrice: true);

        case MatexForexPositionSizeCalculatorBlocKey.stopLossPips:
          return document.copyWithDefaults(resetStopLossPips: true);

        case MatexForexPositionSizeCalculatorBlocKey.stopLossPrice:
          return document.copyWithDefaults(resetStopLossPrice: true);

        case MatexForexPositionSizeCalculatorBlocKey.instrument:
          return document.copyWithDefaults(
            resetPipDecimalPlaces: true,
            resetCounter: true,
            resetBase: true,
          );
      }
    } else if (value is String) {
      switch (key) {
        case MatexFiancialCalculatorBlocKey.accountCurrency:
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

    if (value is String?) {
      switch (key) {
        case MatexFiancialCalculatorBlocKey.accountCurrency:
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

        case MatexForexPositionSizeCalculatorBlocKey.instrument:
          return patchInstrument(null);
      }
    } else if (value is Enum) {
      switch (key) {
        case MatexForexPositionSizeCalculatorBlocKey.riskFieldType:
          return patchRiskFieldType(value.name);

        case MatexForexPositionSizeCalculatorBlocKey.stopLossFieldType:
          return patchStopLossFieldType(value.name);
      }
    } else if (value is MatexFinancialInstrument) {
      if (key == MatexForexPipValueCalculatorBlocKey.instrument) {
        return patchInstrument(value);
      }
    }

    return null;
  }

  @override
  Future<void> resetCalculator(
    MatexForexPositionSizeCalculatorDocument document,
  ) async {
    final dRiskPercent = parseStringToDouble(document.riskPercent);
    const typeFromName = FastFinancialAmountSwitchFieldTypeX.fromName;
    final stopLossFieldType = typeFromName(document.stopLossFieldType);
    final riskFieldType = typeFromName(document.riskFieldType);

    calculator.setState(MatexForexPositionSizeCalculatorState(
      pipDecimalPlaces: tryParseStringToInt(document.pipDecimalPlaces),
      accountSize: tryParseStringToDouble(document.accountSize),
      entryPrice: tryParseStringToDouble(document.entryPrice),
      riskPercent: riskFieldType == FastFinancialAmountSwitchFieldType.percent
          ? (dRiskPercent / 100)
          : 0,
      riskAmount: riskFieldType == FastFinancialAmountSwitchFieldType.amount
          ? tryParseStringToDouble(document.riskAmount)
          : 0,
      stopLossPips: stopLossFieldType == FastFinancialAmountSwitchFieldType.pip
          ? tryParseStringToDouble(document.stopLossPips)
          : 0,
      stopLossPrice:
          stopLossFieldType == FastFinancialAmountSwitchFieldType.price
              ? tryParseStringToDouble(document.stopLossPrice)
              : 0,
    ));
  }

  @override
  Future<MatexForexPositionSizeCalculatorBlocState> resetCalculatorBlocState(
    MatexForexPositionSizeCalculatorDocument document,
  ) async {
    const percentType = FastFinancialAmountSwitchFieldType.percent;
    const amountType = FastFinancialAmountSwitchFieldType.amount;
    const priceType = FastFinancialAmountSwitchFieldType.price;
    const pipType = FastFinancialAmountSwitchFieldType.pip;
    const typeFromName = FastFinancialAmountSwitchFieldTypeX.fromName;
    final stopLossFieldType = typeFromName(document.stopLossFieldType);
    final riskFieldType = typeFromName(document.riskFieldType);
    final pipDecimalPlaces = await getPipPrecision(
      counter: document.counter,
      base: document.base,
    );

    return _kDefaultPipValueBlocState.copyWith(
      results: await retrieveDefaultResult(),
      fields: MatexForexPositionSizeCalculatorBlocFields(
        pipDecimalPlaces: pipDecimalPlaces.toString(),
        stopLossFieldType: document.stopLossFieldType,
        riskFieldType: document.riskFieldType,
        accountCurrency: document.accountCurrency,
        riskPercent: riskFieldType == percentType ? document.riskPercent : null,
        riskAmount: riskFieldType == amountType ? document.riskAmount : null,
        stopLossPips:
            stopLossFieldType == pipType ? document.stopLossPips : null,
        stopLossPrice:
            stopLossFieldType == priceType ? document.stopLossPrice : null,
        counter: document.counter,
        base: document.base,
      ),
    );
  }

  @override
  Future<MatexForexPositionSizeCalculatorDocument>
      retrieveDefaultCalculatorDocument() async {
    final instrument = userDefaultInstrument;
    int pipDecimalPlaces = kMatexDefaultPipDecimalPlaces;
    const percentType = FastFinancialAmountSwitchFieldType.percent;
    final riskType = userDefaultRiskType;

    if (instrument != null) {
      pipDecimalPlaces = await getPipPrecision(
        counter: instrument.counter,
        base: instrument.base,
      );
    }

    return MatexForexPositionSizeCalculatorDocument(
      riskPercent: riskType == percentType.name ? userDefaultRiskPercent : null,
      pipDecimalPlaces: pipDecimalPlaces.toString(),
      stopLossFieldType: userDefaultStopLossType,
      accountCurrency: getUserCurrencyCode(),
      riskFieldType: userDefaultRiskType,
      counter: instrument?.counter,
      base: instrument?.base,
    );
  }

  @override
  Future<MatexForexPositionSizeCalculatorBlocResults>
      retrieveDefaultResult() async {
    return MatexForexPositionSizeCalculatorBlocResults(
      formattedPositionSize: localizeNumber(value: 0),
      positionSize: 0,
    );
  }

  MatexForexPositionSizeCalculatorBlocState patchAccountCurrency(
    String? value,
  ) {
    late final MatexForexPositionSizeCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetAccountCurrency: true);
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

    if (instrument == null) {
      fields = currentState.fields.copyWithDefaults(
        resetPipDecimalPlaces: true,
        resetCounter: true,
        resetBase: true,
      );

      calculator.pipDecimalPlaces = kMatexDefaultPipDecimalPlaces;
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

    return currentState.copyWith(
      metadata: mergeMetadata(emptyInstrumentMetadata),
      fields: fields,
    );
  }

  MatexForexPositionSizeCalculatorBlocState patchPipDecimalPlaces(
    String? value,
  ) {
    late MatexForexPositionSizeCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetPipDecimalPlaces: true,
      );

      calculator.pipDecimalPlaces = kMatexDefaultPipDecimalPlaces;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(pipDecimalPlaces: value);
      calculator.pipDecimalPlaces = dValue.toInt();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchAccountSize(String? value) {
    late MatexForexPositionSizeCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetAccountSize: true);
      calculator.accountSize = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(accountSize: value);
      calculator.accountSize = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchRiskPercent(String? value) {
    late MatexForexPositionSizeCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetRiskPercent: true);
      calculator.riskPercent = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(riskPercent: value);
      calculator.riskPercent = (dValue / 100);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchRiskAmount(String? value) {
    late MatexForexPositionSizeCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetRiskAmount: true);
      calculator.riskAmount = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(riskAmount: value);
      calculator.riskAmount = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchEntryPrice(String? value) {
    late MatexForexPositionSizeCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetEntryPrice: true);
      calculator.entryPrice = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(entryPrice: value);
      calculator.entryPrice = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchStopLossPips(String? value) {
    late MatexForexPositionSizeCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetStopLossPips: true);
      calculator.stopLossPips = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(stopLossPips: value);
      calculator.stopLossPips = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchStopLossPrice(String? value) {
    late MatexForexPositionSizeCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetStopLossPrice: true);
      calculator.stopLossPrice = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(stopLossPrice: value);
      calculator.stopLossPrice = dValue;
    }

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

  Future<void> patchCalculatorExchangeRates({
    required String accountCurrency,
    MatexFinancialInstrument? instrument,
    double? instrumentPairRate,
  }) async {
    calculator
      ..instrumentPairRate = instrumentPairRate ?? 0
      ..counterToAccountCurrencyRate = 0
      ..isAccountCurrencyCounter = false;

    if (instrument == null) return;

    final counter = instrument.counter!;

    if (accountCurrency == counter) {
      calculator.isAccountCurrencyCounter = true;
    } else {
      final counterInstrument = MatexFinancialInstrument(
        counter: accountCurrency,
        base: counter,
      );

      final accountBaseQuote = await fetchInstrumentExchangeRate(
        counterInstrument,
      );

      if (accountBaseQuote == null) return;

      calculator.counterToAccountCurrencyRate = accountBaseQuote.price;
    }
  }

  @override
  String getReportFilename() => 'forex_position_size_calculator_report';

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexForexPositionSizeCalculatorPdfGenerator();
    final fields = currentState.fields;
    final results = await compute();
    final metadata = currentState.metadata;

    // ignore: use_build_context_synchronously
    return pdfGenerator.generate(context, fields, results, metadata);
  }
}
