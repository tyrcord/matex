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
  MatexForexStopLossTakeProfitCalculatorBloc({
    MatexForexStopLossTakeProfitCalculatorBlocState? initialState,
    MatexForexStopLossTakeProfitCalculatorDataProvider? dataProvider,
    required super.exchangeProvider,
    super.debouceComputeEvents = true,
    super.isAutoRefreshEnabled = false,
    super.showExportPdfDialog,
    super.autoRefreshPeriod,
    super.delegate,
  }) : super(
          initialState: initialState ?? _kDefaultPipValueBlocState,
          dataProvider: dataProvider ??
              MatexForexStopLossTakeProfitCalculatorDataProvider(),
          debugLabel: 'MatexForexStopLossTakeProfitCalculatorBloc',
        ) {
    calculator = MatexForexStopLossTakeProfitCalculator();

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorFinancialInstrument.name,
      MatexForexStopLossTakeProfitCalculatorBlocKey.instrument,
    );

    listenToPrimaryCurrencyCodeChanges();
  }

  @override
  bool get isMandatoryFieldValid {
    final fields = currentState.fields;

    return (fields.positionSize != null || fields.lotSize != null) &&
        fields.financialInstrument != null &&
        fields.accountCurrency != null;
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

    final instrument = currentState.fields.financialInstrument;

    // update the state metadata with the latest instrument metadata
    if (instrument != null) yield* patchInstrumentExchangeRate(instrument);

    final quote = currentMetadata['instrumentExchangeRate'] as double?;

    if (quote != null) await patchCalculatorExchangeRates(quote);

    var fields = currentState.fields;

    if (fields.positionSizeFieldType != MatexPositionSizeType.unit &&
        fields.lotSize != null &&
        fields.lotSize!.isNotEmpty) {
      final positionSize = await getPositionSizeForLotSize(
        lotSize: fields.positionSizeFieldType,
        positionSize: parseFieldValueToDouble(fields.lotSize),
      );

      final isInt = isDoubleInteger(positionSize);

      calculator.positionSize = positionSize;

      fields = currentState.fields.copyWith(
        positionSize:
            isInt ? positionSize.toInt().toString() : positionSize.toString(),
      );
    }

    yield currentState.copyWith(fields: fields);
  }

  @override
  Future<MatexForexStopLossTakeProfitCalculatorBlocResults> compute() async {
    if (await isCalculatorStateValid()) {
      final fields = currentState.fields;
      final accountCurrency = fields.accountCurrency;
      final results = calculator.value();
      final pipValue = results.pipValue;

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
        // FIXME: it should be the folowing format: 1:2.5
        formattedRiskRewardRatio: localizeNumber(
          value: results.riskRewardRatio,
          minimumFractionDigits: 2,
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
        ),
      );
    }

    return retrieveDefaultResult();
  }

  @override
  Future<MatexForexStopLossTakeProfitCalculatorDocument?>
      patchCalculatorDocument(String key, dynamic value) async {
    if (value is Map<dynamic, dynamic> &&
        key == MatexForexStopLossTakeProfitCalculatorBlocKey.instrument) {
      value = MatexFinancialInstrument.fromJson(value);
    }

    if (value is String?) {
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
    } else if (value is Enum) {
      switch (key) {
        case MatexForexStopLossTakeProfitCalculatorBlocKey
              .positionSizeFieldType:
          return document.copyWith(
            positionSizeFieldType: value.name,
            positionSize: '',
            lotSize: '',
          );

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
    } else if (value is Enum) {
      switch (key) {
        case MatexForexStopLossTakeProfitCalculatorBlocKey.stopLossFieldType:
          return patchStopLossFieldType(value.name);

        case MatexForexStopLossTakeProfitCalculatorBlocKey.takeProfitFieldType:
          return patchTakeProfitFieldType(value.name);

        default:
          debugLog('Invalid key: $key', debugLabel: debugLabel);
          break;
      }
    } else if (value is MatexFinancialInstrument) {
      switch (key) {
        case MatexForexStopLossTakeProfitCalculatorBlocKey.instrument:
          return patchInstrument(value);
      }
    }

    return null;
  }

  @override
  Future<MatexForexStopLossTakeProfitCalculatorDocument?>
      resetCalculatorDocument(
    String key,
  ) async {
    switch (key) {
      case MatexFiancialCalculatorBlocKey.accountCurrency:
        return document.copyWithDefaults(resetAccountCurrency: true);

      case MatexForexStopLossTakeProfitCalculatorBlocKey.instrument:
        return document.copyWithDefaults(
          resetCounter: true,
          resetBase: true,
        );
    }

    return null;
  }

  @override
  Future<MatexForexStopLossTakeProfitCalculatorBlocState?> resetCalculatorState(
    String key,
  ) async {
    switch (key) {
      case MatexFiancialCalculatorBlocKey.accountCurrency:
        return patchAccountCurrency(null);

      case MatexForexStopLossTakeProfitCalculatorBlocKey.instrument:
        return patchInstrument(null);
    }

    return null;
  }

  @override
  Future<void> resetCalculator(
    MatexForexStopLossTakeProfitCalculatorDocument document,
  ) async {
    calculator.setState(MatexForexStopLossTakeProfitCalculatorState(
      pipDecimalPlaces: parseStringToInt(document.pipDecimalPlaces) ??
          kMatexDefaultPipDecimalPlaces,
      positionSize: parseStringToDouble(document.positionSize),
      entryPrice: parseStringToDouble(document.entryPrice),
      stopLossPrice: parseStringToDouble(document.stopLossPrice),
      stopLossPips: parseStringToDouble(document.stopLossPips),
      stopLossAmount: parseStringToDouble(document.stopLossAmount),
      takeProfitPrice: parseStringToDouble(document.takeProfitPrice),
      takeProfitPips: parseStringToDouble(document.takeProfitPips),
      takeProfitAmount: parseStringToDouble(document.takeProfitAmount),
    ));
  }

  @override
  Future<MatexForexStopLossTakeProfitCalculatorBlocState>
      resetCalculatorBlocState(
    MatexForexStopLossTakeProfitCalculatorDocument document,
  ) async {
    final pipDecimalPlaces = await getPipPrecision(
      counter: document.counter,
      base: document.base,
    );

    return _kDefaultPipValueBlocState.copyWith(
      results: await retrieveDefaultResult(),
      fields: MatexForexStopLossTakeProfitCalculatorBlocFields(
        pipDecimalPlaces: pipDecimalPlaces.toString(),
        accountCurrency: document.accountCurrency,
        counter: document.counter,
        base: document.base,
      ),
    );
  }

  @override
  Future<MatexForexStopLossTakeProfitCalculatorDocument>
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

    int pipDecimalPlaces = kMatexDefaultPipDecimalPlaces;

    if (json != null) {
      instrument = MatexFinancialInstrument.fromJson(json);

      pipDecimalPlaces = await getPipPrecision(
        counter: instrument.counter,
        base: instrument.base,
      );
    }

    return MatexForexStopLossTakeProfitCalculatorDocument(
      pipDecimalPlaces: pipDecimalPlaces.toString(),
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
    late final MatexForexStopLossTakeProfitCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetAccountCurrency: true);
    } else {
      fields = currentState.fields.copyWith(accountCurrency: value);
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

    // Note: Erase the previous instrument exchange rate metadata
    final metadata = await super.loadMetadata();

    return currentState.copyWith(fields: fields, metadata: metadata);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchPositionSize(
    String? value,
  ) {
    late final MatexForexStopLossTakeProfitCalculatorBlocFields fields;
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

  MatexForexStopLossTakeProfitCalculatorBlocState patchLotSize(String? value) {
    late MatexForexStopLossTakeProfitCalculatorBlocFields fields;
    final positionSizeFieldType = currentState.fields.positionSizeFieldType;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetPositionSize: true,
        resetLotSize: true,
      );

      calculator.positionSize = 0;
    } else if (positionSizeFieldType != MatexPositionSizeType.unit) {
      final dValue = toDecimal(value) ?? dZero;
      fields = currentState.fields.copyWith(positionSize: value);
      calculator.positionSize = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchPipDecimalPlaces(
    String? value,
  ) {
    late MatexForexStopLossTakeProfitCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetPipDecimalPlaces: true,
      );

      calculator.pipDecimalPlaces = kMatexDefaultPipDecimalPlaces;
    } else {
      final dValue = toDecimal(value) ?? dZero;
      fields = currentState.fields.copyWith(pipDecimalPlaces: value);
      calculator.pipDecimalPlaces = dValue.toDouble().toInt();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchEntryPrice(
    String? value,
  ) {
    late MatexForexStopLossTakeProfitCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetEntryPrice: true,
      );

      calculator.entryPrice = 0;
    } else {
      final dValue = toDecimal(value) ?? dZero;
      fields = currentState.fields.copyWith(entryPrice: value);
      calculator.entryPrice = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchStopLossPrice(
    String? value,
  ) {
    late MatexForexStopLossTakeProfitCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetStopLossPrice: true,
      );

      calculator.stopLossPrice = 0;
    } else {
      final dValue = toDecimal(value) ?? dZero;
      fields = currentState.fields.copyWith(stopLossPrice: value);
      calculator.stopLossPrice = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchStopLossPips(
    String? value,
  ) {
    late MatexForexStopLossTakeProfitCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetStopLossPips: true,
      );

      calculator.stopLossPips = 0;
    } else {
      final dValue = toDecimal(value) ?? dZero;
      fields = currentState.fields.copyWith(stopLossPips: value);
      calculator.stopLossPips = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchStopLossAmount(
    String? value,
  ) {
    late MatexForexStopLossTakeProfitCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetStopLossAmount: true,
      );

      calculator.stopLossAmount = 0;
    } else {
      final dValue = toDecimal(value) ?? dZero;
      fields = currentState.fields.copyWith(stopLossAmount: value);
      calculator.stopLossAmount = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchTakeProfitPrice(
    String? value,
  ) {
    late MatexForexStopLossTakeProfitCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetTakeProfitPrice: true,
      );

      calculator.takeProfitPrice = 0;
    } else {
      final dValue = toDecimal(value) ?? dZero;
      fields = currentState.fields.copyWith(takeProfitPrice: value);
      calculator.takeProfitPrice = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchTakeProfitPips(
    String? value,
  ) {
    late MatexForexStopLossTakeProfitCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetTakeProfitPips: true,
      );

      calculator.takeProfitPips = 0;
    } else {
      final dValue = toDecimal(value) ?? dZero;
      fields = currentState.fields.copyWith(takeProfitPips: value);
      calculator.takeProfitPips = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexStopLossTakeProfitCalculatorBlocState patchTakeProfitAmount(
    String? value,
  ) {
    late MatexForexStopLossTakeProfitCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetTakeProfitAmount: true,
      );

      calculator.takeProfitAmount = 0;
    } else {
      final dValue = toDecimal(value) ?? dZero;
      fields = currentState.fields.copyWith(takeProfitAmount: value);
      calculator.takeProfitAmount = dValue.toDouble();
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

  Future<void> patchCalculatorExchangeRates(double instrumentPairRate) async {
    final accountCurrency = currentState.fields.accountCurrency!;
    final counter = currentState.fields.counter!;

    calculator
      ..instrumentPairRate = instrumentPairRate
      ..counterToAccountCurrencyRate = 0
      ..isAccountCurrencyCounter = false;

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
  String getReportFilename() => 'forex_stop_loss_take_profit_calculator_report';

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexForexStopLossTakeProfitCalculatorPdfGenerator();
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
