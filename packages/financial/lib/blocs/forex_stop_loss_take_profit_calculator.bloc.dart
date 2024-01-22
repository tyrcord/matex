// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:tlogger/logger.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

// Initialize default state for the Pip Value Calculator
final _kDefaultPipValueBlocState =
    MatexForexStopLossTakeProfitCalculatorBlocState(
  fields: MatexForexStopLossTakeProfitCalculatorBlocFields(),
  results: const MatexForexStopLossTakeProfitCalculatorBlocResults(),
);

class MatexForexStopLossTakeProfitCalculatorBloc
    extends MatexFinancialCalculatorBloc<
        MatexForexStopLossTakeProfitCalculator,
        FastCalculatorBlocEvent,
        MatexForexStopLossTakeProfitCalculatorBlocState,
        MatexForexStopLossTakeProfitCalculatorDocument,
        MatexForexStopLossTakeProfitCalculatorBlocResults>
    with MatexFinancialCalculatorFormatterMixin {
  static const defaultDebugLabel = 'MatexForexStopLossTakeProfitCalculatorBloc';

  MatexForexStopLossTakeProfitCalculatorBloc({
    MatexForexStopLossTakeProfitCalculatorBlocState? initialState,
    MatexForexStopLossTakeProfitCalculatorDataProvider? dataProvider,
    required super.exchangeProvider,
    super.debouceComputeEvents = true,
    super.isAutoRefreshEnabled = false,
    super.getExportDialog,
    super.autoRefreshPeriod,
    super.delegate,
    super.getContext,
  }) : super(
          initialState: initialState ?? _kDefaultPipValueBlocState,
          dataProvider: dataProvider ??
              MatexForexStopLossTakeProfitCalculatorDataProvider(),
          debugLabel: defaultDebugLabel,
        ) {
    logger = TLoggerManager().getLogger(defaultDebugLabel);
    calculator = MatexForexStopLossTakeProfitCalculator();

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorFinancialInstrument.name,
      MatexForexStopLossTakeProfitCalculatorBlocKey.instrument,
    );

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorStopLossType.name,
      MatexForexStopLossTakeProfitCalculatorBlocKey.stopLossFieldType,
    );

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorTakeProfitType.name,
      MatexForexStopLossTakeProfitCalculatorBlocKey.takeProfitFieldType,
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
  Stream<MatexForexStopLossTakeProfitCalculatorBlocState> mapEventToState(
    FastCalculatorBlocEvent<FastCalculatorResults> event,
  ) async* {
    final instrument = currentState.fields.financialInstrument;

    if (event.type == FastCalculatorBlocEventType.custom &&
        event.payload!.key == 'fetchEntryPrice' &&
        event.payload != null &&
        instrument != null) {
      var metadata = mergeMetadata({'isFetchingPriceEntry': true});

      yield currentState.copyWith(metadata: metadata);

      final quote = await fetchInstrumentExchangeRate(instrument);

      metadata = mergeMetadata({'isFetchingPriceEntry': false});

      yield currentState.copyWith(metadata: metadata);

      addEvent(FastCalculatorBlocEvent.patchValue(
        key: MatexForexStopLossTakeProfitCalculatorBlocKey.entryPrice,
        value: quote?.price.toString(),
      ));
    }

    yield* super.mapEventToState(event);
  }

  @override
  @protected
  Stream<MatexForexStopLossTakeProfitCalculatorBlocState> willCompute() async* {
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

    final entryPrice = currentState.fields.entryPrice;

    if (entryPrice == null) {
      // update the calculator entry price with the instrument exchange rate
      calculator.entryPrice = quote ?? 0;

      // update the state entry price with the instrument exchange rate
      yield currentState.copyWith(
        fields: currentState.fields.copyWith(entryPrice: quote?.toString()),
      );
    }

    final positionSizeFieldType = currentState.fields.positionSizeFieldType;

    // update the calculator position size with the latest lot size
    if (positionSizeFieldType != MatexPositionSizeType.unit) {
      final dLotSize = parseStringToDouble(currentState.fields.lotSize);

      final positionSize = await getPositionSizeForLotSize(
        positionSize: dLotSize,
        lotSize: positionSizeFieldType,
      );

      calculator.positionSize = positionSize;
    }
  }

  @override
  Future<MatexForexStopLossTakeProfitCalculatorBlocResults> compute() async {
    if (await isCalculatorStateValid()) {
      final fields = currentState.fields;
      final accountCurrency = fields.accountCurrency;
      final results = calculator.value();
      final pipValue = results.pipValue;

      final instrumentMetadata =
          currentState.metadata['instrumentMetadata'] as MatexPairMetadata?;

      return MatexForexStopLossTakeProfitCalculatorBlocResults(
        formattedPipValue: localizeCurrency(
          minimumFractionDigits: 3,
          symbol: accountCurrency,
          value: pipValue,
        ),
        pipValue: pipValue,
        takeProfitPrice: results.takeProfitPrice,
        takeProfitPips: results.takeProfitPips,
        takeProfitAmount: results.takeProfitAmount,
        stopLossPrice: results.stopLossPrice,
        stopLossPips: results.stopLossPips,
        stopLossAmount: results.stopLossAmount,
        riskRewardRatio: results.riskRewardRatio,
        formattedRiskRewardRatio: localizeRiskRewardRatio(
          results.riskRewardRatio,
        ),
        formattedStopLossAmount: localizeCurrency(
          minimumFractionDigits: 3,
          symbol: accountCurrency,
          value: results.stopLossAmount,
        ),
        formattedStopLossPips: localizeNumber(
          value: results.stopLossPips,
          minimumFractionDigits: 3,
        ),
        formattedStopLossPrice: localizeQuote(
          rate: results.stopLossPrice,
          metadata: instrumentMetadata,
        ),
        formattedTakeProfitAmount: localizeCurrency(
          minimumFractionDigits: 3,
          symbol: accountCurrency,
          value: results.takeProfitAmount,
        ),
        formattedTakeProfitPips: localizeNumber(
          value: results.takeProfitPips,
          minimumFractionDigits: 3,
        ),
        formattedTakeProfitPrice: localizeQuote(
          rate: results.takeProfitPrice,
          metadata: instrumentMetadata,
        ),
      );
    }

    return retrieveDefaultResult();
  }

  @override
  Future<MatexForexStopLossTakeProfitCalculatorDocument?>
      patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value is Map<dynamic, dynamic> &&
        key == MatexForexStopLossTakeProfitCalculatorBlocKey.instrument) {
      value = MatexFinancialInstrument.fromJson(value);
    }

    if (value == null) {
      switch (key) {
        case MatexFiancialCalculatorBlocKey.accountCurrency:
          return document.copyWithDefaults(resetAccountCurrency: true);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.positionSize:
          return document.copyWithDefaults(resetPositionSize: true);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.entryPrice:
          return document.copyWithDefaults(resetEntryPrice: true);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.pipDecimalPlaces:
          return document.copyWithDefaults(resetPipDecimalPlaces: true);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.lotSize:
          return document.copyWithDefaults(resetLotSize: true);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.stopLossPrice:
          return document.copyWithDefaults(resetStopLossPrice: true);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.stopLossPips:
          return document.copyWithDefaults(resetStopLossPips: true);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.stopLossAmount:
          return document.copyWithDefaults(resetStopLossAmount: true);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.takeProfitPrice:
          return document.copyWithDefaults(resetTakeProfitPrice: true);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.takeProfitPips:
          return document.copyWithDefaults(resetTakeProfitPips: true);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.takeProfitAmount:
          return document.copyWithDefaults(resetTakeProfitAmount: true);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.instrument:
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

        case MatexForexStopLossTakeProfitCalculatorBlocKey.positionSize:
          return document.copyWith(positionSize: value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.pipDecimalPlaces:
          return document.copyWith(pipDecimalPlaces: value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.lotSize:
          return document.copyWith(lotSize: value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.entryPrice:
          return document.copyWith(entryPrice: value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.stopLossPrice:
          return document.copyWith(stopLossPrice: value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.stopLossPips:
          return document.copyWith(stopLossPips: value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.stopLossAmount:
          return document.copyWith(stopLossAmount: value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.takeProfitPrice:
          return document.copyWith(takeProfitPrice: value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.takeProfitPips:
          return document.copyWith(takeProfitPips: value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.takeProfitAmount:
          return document.copyWith(takeProfitAmount: value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.stopLossFieldType:
          return document.copyWith(
            stopLossFieldType: value,
            stopLossPrice: '',
            stopLossPips: '',
            stopLossAmount: '',
          );

        case MatexForexStopLossTakeProfitCalculatorBlocKey.takeProfitFieldType:
          return document.copyWith(
            takeProfitFieldType: value,
            takeProfitPrice: '',
            takeProfitPips: '',
            takeProfitAmount: '',
          );
      }
    } else if (value is MatexPositionSizeType) {
      if (key ==
          MatexForexStopLossTakeProfitCalculatorBlocKey.positionSizeFieldType) {
        return document.copyWith(
          positionSizeFieldType: value.name,
          positionSize: '',
          lotSize: '',
        );
      }
    } else if (value is MatexPosition &&
        key == MatexForexStopLossTakeProfitCalculatorBlocKey.position) {
      return document.copyWith(position: value.name);
    } else if (value is Enum) {
      switch (key) {
        case MatexForexStopLossTakeProfitCalculatorBlocKey.stopLossFieldType:
          return document.copyWith(
            stopLossFieldType: value.name,
            stopLossPrice: '',
            stopLossPips: '',
            stopLossAmount: '',
          );

        case MatexForexStopLossTakeProfitCalculatorBlocKey.takeProfitFieldType:
          return document.copyWith(
            takeProfitFieldType: value.name,
            takeProfitPrice: '',
            takeProfitPips: '',
            takeProfitAmount: '',
          );
      }
    } else if (value is MatexFinancialInstrument) {
      switch (key) {
        case MatexForexStopLossTakeProfitCalculatorBlocKey.instrument:
          final pipDecimalPlaces = await getPipPrecision(
            counter: value.counter,
            base: value.base,
          );

          return document.copyWith(
            pipDecimalPlaces: pipDecimalPlaces.toString(),
            counter: value.counter,
            base: value.base,
            entryPrice: '',
          );
      }
    }

    return null;
  }

  @override
  Future<MatexForexStopLossTakeProfitCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is Map<dynamic, dynamic> &&
        key == MatexForexStopLossTakeProfitCalculatorBlocKey.instrument) {
      value = MatexFinancialInstrument.fromJson(value);
    }

    if (value is String?) {
      switch (key) {
        case MatexFiancialCalculatorBlocKey.accountCurrency:
          return patchAccountCurrency(value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.positionSize:
          return patchPositionSize(value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.pipDecimalPlaces:
          return patchPipDecimalPlaces(value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.lotSize:
          return patchLotSize(value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.entryPrice:
          return patchEntryPrice(value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.stopLossPrice:
          return patchStopLossPrice(value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.stopLossPips:
          return patchStopLossPips(value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.stopLossAmount:
          return patchStopLossAmount(value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.takeProfitPrice:
          return patchTakeProfitPrice(value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.takeProfitPips:
          return patchTakeProfitPips(value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.takeProfitAmount:
          return patchTakeProfitAmount(value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.stopLossFieldType:
          return patchStopLossFieldType(value);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.takeProfitFieldType:
          return patchTakeProfitFieldType(value);
      }
    } else if (value is MatexPositionSizeType) {
      if (key ==
          MatexForexStopLossTakeProfitCalculatorBlocKey.positionSizeFieldType) {
        return patchPositionSizeFieldType(value);
      }
    } else if (value is MatexPosition &&
        key == MatexForexStopLossTakeProfitCalculatorBlocKey.position) {
      return patchPosition(value);
    } else if (value is Enum) {
      switch (key) {
        case MatexForexStopLossTakeProfitCalculatorBlocKey.stopLossFieldType:
          return patchStopLossFieldType(value.name);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.takeProfitFieldType:
          return patchTakeProfitFieldType(value.name);
      }
    } else if (value is MatexFinancialInstrument) {
      if (key == MatexForexStopLossTakeProfitCalculatorBlocKey.instrument) {
        return patchInstrument(value);
      }
    }

    return null;
  }

  @override
  Future<void> resetCalculator(
    MatexForexStopLossTakeProfitCalculatorDocument document,
  ) async {
    const typeFromName = FastFinancialAmountSwitchFieldTypeX.fromName;
    const amountType = FastFinancialAmountSwitchFieldType.amount;
    const priceType = FastFinancialAmountSwitchFieldType.price;
    const pipType = FastFinancialAmountSwitchFieldType.pip;
    final stopLossFieldType = typeFromName(document.stopLossFieldType);
    final takeProfitFieldType = typeFromName(document.takeProfitFieldType);

    calculator.setState(MatexForexStopLossTakeProfitCalculatorState(
      pipDecimalPlaces: tryParseStringToInt(document.pipDecimalPlaces),
      positionSize: tryParseStringToDouble(document.positionSize),
      entryPrice: tryParseStringToDouble(document.entryPrice),
      position: MatexPositionX.fromName(document.position),
      stopLossPips: stopLossFieldType == pipType
          ? tryParseStringToDouble(document.stopLossPips)
          : 0,
      stopLossPrice: stopLossFieldType == priceType
          ? tryParseStringToDouble(document.stopLossPrice)
          : 0,
      stopLossAmount: stopLossFieldType == amountType
          ? tryParseStringToDouble(document.stopLossAmount)
          : 0,
      takeProfitAmount: takeProfitFieldType == amountType
          ? tryParseStringToDouble(document.takeProfitAmount)
          : 0,
      takeProfitPips: takeProfitFieldType == pipType
          ? tryParseStringToDouble(document.takeProfitPips)
          : 0,
      takeProfitPrice: takeProfitFieldType == priceType
          ? tryParseStringToDouble(document.takeProfitPrice)
          : 0,
    ));
  }

  @override
  Future<MatexForexStopLossTakeProfitCalculatorBlocState>
      resetCalculatorBlocState(
    MatexForexStopLossTakeProfitCalculatorDocument document,
  ) async {
    const typeFromName = FastFinancialAmountSwitchFieldTypeX.fromName;
    const amountType = FastFinancialAmountSwitchFieldType.amount;
    const priceType = FastFinancialAmountSwitchFieldType.price;
    const pipType = FastFinancialAmountSwitchFieldType.pip;
    final stopLossFieldType = typeFromName(document.stopLossFieldType);
    final takeProfitFieldType = typeFromName(document.takeProfitFieldType);
    final pipDecimalPlaces = await getPipPrecision(
      counter: document.counter,
      base: document.base,
    );

    return _kDefaultPipValueBlocState.copyWith(
      results: await retrieveDefaultResult(),
      fields: MatexForexStopLossTakeProfitCalculatorBlocFields(
        position: MatexPositionX.fromName(document.position),
        pipDecimalPlaces: pipDecimalPlaces.toString(),
        accountCurrency: document.accountCurrency,
        stopLossPips:
            stopLossFieldType == pipType ? document.stopLossPips : null,
        stopLossPrice:
            stopLossFieldType == priceType ? document.stopLossPrice : null,
        stopLossAmount:
            stopLossFieldType == amountType ? document.stopLossAmount : null,
        takeProfitPips:
            takeProfitFieldType == pipType ? document.takeProfitPips : null,
        takeProfitPrice:
            takeProfitFieldType == priceType ? document.takeProfitPrice : null,
        takeProfitAmount: takeProfitFieldType == amountType
            ? document.takeProfitAmount
            : null,
        entryPrice: document.entryPrice,
        counter: document.counter,
        base: document.base,
        stopLossFieldType: document.stopLossFieldType,
        takeProfitFieldType: document.takeProfitFieldType,
      ),
    );
  }

  @override
  Future<MatexForexStopLossTakeProfitCalculatorDocument>
      retrieveDefaultCalculatorDocument() async {
    final instrument = userDefaultInstrument;
    int pipDecimalPlaces = kMatexDefaultPipDecimalPlaces;

    if (instrument != null) {
      pipDecimalPlaces = await getPipPrecision(
        counter: instrument.counter,
        base: instrument.base,
      );
    }

    return MatexForexStopLossTakeProfitCalculatorDocument(
      takeProfitFieldType: userDefaultTakeProfitType,
      pipDecimalPlaces: pipDecimalPlaces.toString(),
      stopLossFieldType: userDefaultStopLossType,
      accountCurrency: getUserCurrencyCode(),
      counter: instrument?.counter,
      base: instrument?.base,
    );
  }

  @override
  Future<MatexForexStopLossTakeProfitCalculatorBlocResults>
      retrieveDefaultResult() async {
    return MatexForexStopLossTakeProfitCalculatorBlocResults(
      formattedPipValue: localizeCurrency(value: 0),
      pipValue: 0,
    );
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchAccountCurrency(
    String? value,
  ) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetAccountCurrency: true);
    } else {
      fields = fields.copyWith(accountCurrency: value);
    }

    return currentState.copyWith(fields: fields);
  }

  Future<MatexForexStopLossTakeProfitCalculatorBlocState> patchInstrument(
    MatexFinancialInstrument? instrument,
  ) async {
    late final MatexForexStopLossTakeProfitCalculatorBlocFields fields;

    calculator
      ..counterToAccountCurrencyRate = 0
      ..isAccountCurrencyCounter = false
      ..instrumentPairRate = 0;

    if (instrument == null) {
      fields = currentState.fields.copyWithDefaults(
        resetPipDecimalPlaces: true,
        resetEntryPrice: true,
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
        entryPrice: '',
      );

      calculator.pipDecimalPlaces = pipDecimalPlaces;
    }

    return currentState.copyWith(
      metadata: mergeMetadata(emptyInstrumentMetadata),
      fields: fields,
    );
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchPositionSize(
    String? value,
  ) {
    var fields = currentState.fields;
    final positionSizeFieldType = fields.positionSizeFieldType;

    if (value == null) {
      fields = fields.copyWithDefaults(
        resetPositionSize: true,
        resetLotSize: true,
      );

      calculator.positionSize = 0;
    } else if (positionSizeFieldType == MatexPositionSizeType.unit) {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(positionSize: value);
      calculator.positionSize = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchLotSize(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(
        resetPositionSize: true,
        resetLotSize: true,
      );

      calculator.positionSize = 0;
    } else {
      fields = fields.copyWith(lotSize: value);
      // NOTE: we need to convert the lot size to a position size
      // will be done in the will compute method
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchPosition(
    MatexPosition? value,
  ) {
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

  MatexForexStopLossTakeProfitCalculatorBlocState patchPipDecimalPlaces(
    String? value,
  ) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetPipDecimalPlaces: true);
      calculator.pipDecimalPlaces = kMatexDefaultPipDecimalPlaces;
    } else {
      fields = currentState.fields.copyWith(pipDecimalPlaces: value);
      final dValue = parseStringToDouble(value);
      calculator.pipDecimalPlaces = dValue.toInt();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchEntryPrice(
    String? value,
  ) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetEntryPrice: true);
      calculator.entryPrice = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(entryPrice: value);
      calculator.entryPrice = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchStopLossPrice(
    String? value,
  ) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetStopLossPrice: true);
      calculator.stopLossPrice = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(stopLossPrice: value);
      calculator.stopLossPrice = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchStopLossPips(
    String? value,
  ) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetStopLossPips: true);
      calculator.stopLossPips = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(stopLossPips: value);
      calculator.stopLossPips = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchStopLossAmount(
    String? value,
  ) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetStopLossAmount: true);
      calculator.stopLossAmount = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(stopLossAmount: value);
      calculator.stopLossAmount = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchTakeProfitPrice(
    String? value,
  ) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetTakeProfitPrice: true);
      calculator.takeProfitPrice = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(takeProfitPrice: value);
      calculator.takeProfitPrice = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchTakeProfitPips(
    String? value,
  ) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetTakeProfitPips: true);
      calculator.takeProfitPips = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(takeProfitPips: value);
      calculator.takeProfitPips = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchTakeProfitAmount(
    String? value,
  ) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetTakeProfitAmount: true);
      calculator.takeProfitAmount = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(takeProfitAmount: value);
      calculator.takeProfitAmount = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchStopLossFieldType(
    String? value,
  ) {
    final fields = currentState.fields.copyWith(
      stopLossFieldType: value,
      stopLossPrice: '',
      stopLossPips: '',
      stopLossAmount: '',
    );

    calculator
      ..stopLossPrice = 0
      ..stopLossPips = 0
      ..stopLossAmount = 0;

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchTakeProfitFieldType(
    String? value,
  ) {
    final fields = currentState.fields.copyWith(
      takeProfitFieldType: value,
      takeProfitPrice: '',
      takeProfitPips: '',
      takeProfitAmount: '',
    );

    calculator
      ..takeProfitPrice = 0
      ..takeProfitPips = 0
      ..takeProfitAmount = 0;

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchPositionSizeFieldType(
    MatexPositionSizeType? value,
  ) {
    final fields = currentState.fields.copyWith(
      positionSizeFieldType: value,
      positionSize: '',
      lotSize: '',
    );

    calculator.positionSize = 0;

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
  String getReportFilename() => 'forex_stop_loss_take_profit_calculator_report';

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexForexStopLossTakeProfitCalculatorPdfGenerator();
    final fields = currentState.fields;
    final results = await compute();
    final metadata = currentState.metadata;

    // ignore: use_build_context_synchronously
    return pdfGenerator.generate(context, fields, results, metadata);
  }
}
