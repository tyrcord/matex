// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
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
  MatexForexPositionSizeCalculatorBloc({
    MatexForexPositionSizeCalculatorBlocState? initialState,
    MatexForexPositionSizeCalculatorDataProvider? dataProvider,
    required super.exchangeProvider,
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

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorRiskPercent.name,
      MatexStockPositionSizeCalculatorBlocKey.riskPercent,
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
      final accountCurrency = fields.accountCurrency;
      final dPipValue = toDecimalOrDefault(results.pipValue);
      final pipValue = dPipValue.toDouble();
      final positionSize = results.positionSize?.toDouble() ?? 0;
      final dPositionSize = toDecimalOrDefault(positionSize);
      final instrumentMetadata = await getInstrumentMetadata();
      final standardLotUnits = await getUnitsPerStandardLot();
      final miniLotUnits = await getUnitsPerMiniLot();
      final microLotUnits = await getUnitsPerMicroLot();
      final dStandardLotUnits = toDecimalOrDefault(standardLotUnits);
      final dMiniLotUnits = toDecimalOrDefault(miniLotUnits);
      final dMicroLotUnits = toDecimalOrDefault(microLotUnits);
      final standardLotSize = (dPositionSize / dStandardLotUnits).toDouble();
      final miniLotSize = (dPositionSize / dMiniLotUnits).toDouble();
      final microLotSize = (dPositionSize / dMicroLotUnits).toDouble();

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
          value: results.stopLossPips,
        ),
        stopLossPips: results.stopLossPips,
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
    final dRiskPercent = toDecimalOrDefault(document.riskPercent);

    calculator.setState(MatexForexPositionSizeCalculatorState(
      pipDecimalPlaces: parseStringToInt(document.pipDecimalPlaces),
      accountSize: parseStringToDouble(document.accountSize),
      riskPercent: (dRiskPercent / dHundred).toDouble(),
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
        riskPercent: document.riskPercent,
        riskAmount: document.riskAmount,
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

    if (instrument != null) {
      pipDecimalPlaces = await getPipPrecision(
        counter: instrument.counter,
        base: instrument.base,
      );
    }

    return MatexForexPositionSizeCalculatorDocument(
      pipDecimalPlaces: pipDecimalPlaces.toString(),
      accountCurrency: getUserCurrencyCode(),
      riskPercent: userDefaultRiskPercent,
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
      final dValue = toDecimalOrDefault(value);
      fields = currentState.fields.copyWith(pipDecimalPlaces: value);
      calculator.pipDecimalPlaces = dValue.toDouble().toInt();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchAccountSize(String? value) {
    late MatexForexPositionSizeCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetAccountSize: true);
      calculator.accountSize = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = currentState.fields.copyWith(accountSize: value);
      calculator.accountSize = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchRiskPercent(String? value) {
    late MatexForexPositionSizeCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetRiskPercent: true);
      calculator.riskPercent = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = currentState.fields.copyWith(riskPercent: value);
      calculator.riskPercent = (dValue / dHundred).toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchRiskAmount(String? value) {
    late MatexForexPositionSizeCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetRiskAmount: true);
      calculator.riskAmount = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = currentState.fields.copyWith(riskAmount: value);
      calculator.riskAmount = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchEntryPrice(String? value) {
    late MatexForexPositionSizeCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetEntryPrice: true);
      calculator.entryPrice = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = currentState.fields.copyWith(entryPrice: value);
      calculator.entryPrice = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchStopLossPips(String? value) {
    late MatexForexPositionSizeCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetStopLossPips: true);
      calculator.stopLossPips = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = currentState.fields.copyWith(stopLossPips: value);
      calculator.stopLossPips = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexPositionSizeCalculatorBlocState patchStopLossPrice(String? value) {
    late MatexForexPositionSizeCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetStopLossPrice: true);
      calculator.stopLossPrice = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = currentState.fields.copyWith(stopLossPrice: value);
      calculator.stopLossPrice = dValue.toDouble();
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
      final symbol = counter + accountCurrency;
      final accountBaseQuote = await exchangeProvider!.rate(symbol);

      // TODO: display an error message
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
