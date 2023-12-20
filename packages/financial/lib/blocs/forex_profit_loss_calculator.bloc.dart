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
final _kDefaultProfitLossBlocState = MatexForexProfitLossCalculatorBlocState(
  fields: MatexForexProfitLossCalculatorBlocFields(),
  results: const MatexForexProfitLossCalculatorBlocResults(),
);

class MatexForexProfitLossCalculatorBloc extends MatexFinancialCalculatorBloc<
        MatexForexProfitLossCalculator,
        FastCalculatorBlocEvent,
        MatexForexProfitLossCalculatorBlocState,
        MatexForexProfitLossCalculatorDocument,
        MatexForexProfitLossCalculatorBlocResults>
    with MatexFinancialCalculatorFormatterMixin {
  MatexForexProfitLossCalculatorBloc({
    MatexForexProfitLossCalculatorBlocState? initialState,
    MatexForexProfitLossCalculatorDataProvider? dataProvider,
    required super.exchangeProvider,
    super.debouceComputeEvents = true,
    super.isAutoRefreshEnabled = false,
    super.showExportPdfDialog,
    super.autoRefreshPeriod,
    super.delegate,
  }) : super(
          initialState: initialState ?? _kDefaultProfitLossBlocState,
          dataProvider:
              dataProvider ?? MatexForexProfitLossCalculatorDataProvider(),
          debugLabel: 'MatexForexProfitLossCalculatorBloc',
        ) {
    calculator = MatexForexProfitLossCalculator();

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorFinancialInstrument.name,
      MatexForexProfitLossCalculatorBlocKey.instrument,
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
  Stream<MatexForexProfitLossCalculatorBlocState> willCompute() async* {
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

    final positionSizeFieldType = currentState.fields.positionSizeFieldType;

    // update the calculator position size with the latest lot size
    if (positionSizeFieldType != MatexPositionSizeType.unit) {
      final dLotSize = toDecimalOrDefault(currentState.fields.lotSize);

      final positionSize = await getPositionSizeForLotSize(
        positionSize: dLotSize.toDouble(),
        lotSize: positionSizeFieldType,
      );

      calculator.positionSize = positionSize;
    }
  }

  @override
  Future<MatexForexProfitLossCalculatorBlocResults> compute() async {
    if (await isCalculatorStateValid()) {
      final results = calculator.value();

      return MatexForexProfitLossCalculatorBlocResults(
        formattedNetProfit: localizeCurrency(
          value: results.netProfit,
          maximumFractionDigits: 3,
        ),
        returnOnInvestment: results.returnOnInvestment,
        netProfit: results.netProfit,
        formattedReturnOnInvestment: localizePercentage(
          value: results.returnOnInvestment,
        ),
      );
    }

    return retrieveDefaultResult();
  }

  @override
  Future<MatexForexProfitLossCalculatorDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value is Map<dynamic, dynamic> &&
        key == MatexForexProfitLossCalculatorBlocKey.instrument) {
      value = MatexFinancialInstrument.fromJson(value);
    }

    if (value == null) {
      switch (key) {
        case MatexFiancialCalculatorBlocKey.accountCurrency:
          return document.copyWithDefaults(resetAccountCurrency: true);

        case MatexForexProfitLossCalculatorBlocKey.positionSize:
          return document.copyWithDefaults(resetPositionSize: true);

        case MatexForexProfitLossCalculatorBlocKey.pipDecimalPlaces:
          return document.copyWithDefaults(resetPipDecimalPlaces: true);

        case MatexForexProfitLossCalculatorBlocKey.lotSize:
          return document.copyWithDefaults(resetLotSize: true);

        case MatexForexProfitLossCalculatorBlocKey.entryPrice:
          return document.copyWithDefaults(resetEntryPrice: true);

        case MatexForexProfitLossCalculatorBlocKey.exitPrice:
          return document.copyWithDefaults(resetExitPrice: true);

        case MatexForexProfitLossCalculatorBlocKey.instrument:
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

        case MatexForexProfitLossCalculatorBlocKey.positionSize:
          return document.copyWith(positionSize: value);

        case MatexForexProfitLossCalculatorBlocKey.pipDecimalPlaces:
          return document.copyWith(pipDecimalPlaces: value);

        case MatexForexProfitLossCalculatorBlocKey.lotSize:
          return document.copyWith(lotSize: value);
        case MatexForexProfitLossCalculatorBlocKey.entryPrice:
          return document.copyWith(entryPrice: value);
        case MatexForexProfitLossCalculatorBlocKey.exitPrice:
          return document.copyWith(exitPrice: value);
      }
    } else if (value is MatexPositionSizeType &&
        key == MatexForexProfitLossCalculatorBlocKey.positionSizeFieldType) {
      return document.copyWith(
        positionSizeFieldType: value.name,
        positionSize: '',
        lotSize: '',
      );
    } else if (value is MatexFinancialInstrument &&
        key == MatexForexProfitLossCalculatorBlocKey.instrument) {
      final pipDecimalPlaces = await getPipPrecision(
        counter: value.counter,
        base: value.base,
      );

      return document.copyWith(
        pipDecimalPlaces: pipDecimalPlaces.toString(),
        counter: value.counter,
        base: value.base,
      );
    } else if (value is MatexPosition &&
        key == MatexForexProfitLossCalculatorBlocKey.position) {
      return document.copyWith(position: value.name);
    }

    return null;
  }

  @override
  Future<MatexForexProfitLossCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is Map<dynamic, dynamic> &&
        key == MatexForexProfitLossCalculatorBlocKey.instrument) {
      value = MatexFinancialInstrument.fromJson(value);
    }

    if (value is String?) {
      switch (key) {
        case MatexFiancialCalculatorBlocKey.accountCurrency:
          return patchAccountCurrency(value);

        case MatexForexProfitLossCalculatorBlocKey.positionSize:
          return patchPositionSize(value);

        case MatexForexProfitLossCalculatorBlocKey.pipDecimalPlaces:
          return patchPipDecimalPlaces(value);

        case MatexForexProfitLossCalculatorBlocKey.lotSize:
          return patchLotSize(value);

        case MatexForexProfitLossCalculatorBlocKey.entryPrice:
          return patchEntryPrice(value);

        case MatexForexProfitLossCalculatorBlocKey.exitPrice:
          return patchExitPrice(value);

        case MatexForexProfitLossCalculatorBlocKey.instrument:
          return patchInstrument(null);
      }
    } else if (value is MatexPositionSizeType &&
        key == MatexForexProfitLossCalculatorBlocKey.positionSizeFieldType) {
      return patchPositionSizeFieldType(value);
    } else if (value is MatexFinancialInstrument &&
        key == MatexForexProfitLossCalculatorBlocKey.instrument) {
      return patchInstrument(value);
    } else if (value is MatexPosition &&
        key == MatexForexProfitLossCalculatorBlocKey.position) {
      return patchPosition(value);
    }

    return null;
  }

  @override
  Future<void> resetCalculator(
    MatexForexProfitLossCalculatorDocument document,
  ) async {
    calculator.setState(MatexForexProfitLossCalculatorState(
      pipDecimalPlaces: parseStringToInt(document.pipDecimalPlaces),
      positionSize: parseStringToDouble(document.positionSize),
      entryPrice: parseStringToDouble(document.entryPrice),
      exitPrice: parseStringToDouble(document.exitPrice),
      position: MatexPositionX.fromName(document.position),
    ));
  }

  @override
  Future<MatexForexProfitLossCalculatorBlocState> resetCalculatorBlocState(
    MatexForexProfitLossCalculatorDocument document,
  ) async {
    final pipDecimalPlaces = await getPipPrecision(
      counter: document.counter,
      base: document.base,
    );

    return _kDefaultProfitLossBlocState.copyWith(
      results: await retrieveDefaultResult(),
      fields: MatexForexProfitLossCalculatorBlocFields(
        position: MatexPositionX.fromName(document.position),
        pipDecimalPlaces: pipDecimalPlaces.toString(),
        accountCurrency: document.accountCurrency,
        entryPrice: document.entryPrice,
        exitPrice: document.exitPrice,
        counter: document.counter,
        base: document.base,
      ),
    );
  }

  @override
  Future<MatexForexProfitLossCalculatorDocument>
      retrieveDefaultCalculatorDocument() async {
    final instrument = userDefaultInstrument;
    int pipDecimalPlaces = kMatexDefaultPipDecimalPlaces;

    if (instrument != null) {
      pipDecimalPlaces = await getPipPrecision(
        counter: instrument.counter,
        base: instrument.base,
      );
    }

    return MatexForexProfitLossCalculatorDocument(
      pipDecimalPlaces: pipDecimalPlaces.toString(),
      accountCurrency: getUserCurrencyCode(),
      counter: instrument?.counter,
      base: instrument?.base,
    );
  }

  @override
  Future<MatexForexProfitLossCalculatorBlocResults>
      retrieveDefaultResult() async {
    return MatexForexProfitLossCalculatorBlocResults(
      formattedReturnOnInvestment: localizePercentage(value: 0),
      formattedNetProfit: localizeCurrency(value: 0),
    );
  }

  MatexForexProfitLossCalculatorBlocState patchAccountCurrency(String? value) {
    late final MatexForexProfitLossCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetAccountCurrency: true);
    } else {
      fields = currentState.fields.copyWith(accountCurrency: value);
    }

    return currentState.copyWith(fields: fields);
  }

  Future<MatexForexProfitLossCalculatorBlocState> patchInstrument(
    MatexFinancialInstrument? instrument,
  ) async {
    late final MatexForexProfitLossCalculatorBlocFields fields;

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

  MatexForexProfitLossCalculatorBlocState patchPositionSize(String? value) {
    late MatexForexProfitLossCalculatorBlocFields fields;
    final positionSizeFieldType = currentState.fields.positionSizeFieldType;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetPositionSize: true,
        resetLotSize: true,
      );

      calculator.positionSize = 0;
    } else if (positionSizeFieldType == MatexPositionSizeType.unit) {
      final dValue = toDecimalOrDefault(value);
      fields = currentState.fields.copyWith(positionSize: value);
      calculator.positionSize = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexProfitLossCalculatorBlocState patchLotSize(String? value) {
    late MatexForexProfitLossCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetPositionSize: true,
        resetLotSize: true,
      );

      calculator.positionSize = 0;
    } else {
      fields = currentState.fields.copyWith(lotSize: value);
      // NOTE: we need to convert the lot size to a position size
      // will be done in the will compute method
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexProfitLossCalculatorBlocState patchPipDecimalPlaces(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetPipDecimalPlaces: true);
      calculator.pipDecimalPlaces = kMatexDefaultPipDecimalPlaces;
    } else {
      fields = fields.copyWith(pipDecimalPlaces: value);
      final dValue = toDecimalOrDefault(value);
      calculator.pipDecimalPlaces = dValue.toDouble().toInt();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexProfitLossCalculatorBlocState patchPositionSizeFieldType(
    MatexPositionSizeType value,
  ) {
    final fields = currentState.fields.copyWith(
      positionSizeFieldType: value,
      positionSize: '',
      lotSize: '',
    );

    calculator.positionSize = 0;

    return currentState.copyWith(fields: fields);
  }

  MatexForexProfitLossCalculatorBlocState patchEntryPrice(String? value) {
    late MatexForexProfitLossCalculatorBlocFields fields;

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

  MatexForexProfitLossCalculatorBlocState patchExitPrice(String? value) {
    late MatexForexProfitLossCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetExitPrice: true);
      calculator.exitPrice = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = currentState.fields.copyWith(exitPrice: value);
      calculator.exitPrice = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexProfitLossCalculatorBlocState patchPosition(MatexPosition? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetPosition: true);
      calculator.position = MatexPosition.long;
    } else {
      fields = fields.copyWith(position: value);
      calculator.position = value;
    }

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

      // FIXME: display an error message
      if (accountBaseQuote == null) return;

      calculator.counterToAccountCurrencyRate = accountBaseQuote.price;
    }
  }

  @override
  String getReportFilename() => 'forex_profit_loss_calculator_report';

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexForexProfitLossCalculatorPdfGenerator();
    final fields = currentState.fields;
    final results = await compute();
    final metadata = currentState.metadata;

    // ignore: use_build_context_synchronously
    return pdfGenerator.generate(context, fields, results, metadata);
  }
}
