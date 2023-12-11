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
  final MatexFinancialInstrumentExchangeService exchangeProvider;

  MatexForexStopLossTakeProfitCalculatorBloc({
    MatexForexStopLossTakeProfitCalculatorBlocState? initialState,
    MatexForexStopLossTakeProfitCalculatorDataProvider? dataProvider,
    required this.exchangeProvider,
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
        key: MatexForexStopLossTakeProfitCalculatorBlocKey.accountCurrency,
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
  Stream<MatexForexStopLossTakeProfitCalculatorBlocState> willCompute() async* {
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
        case MatexForexStopLossTakeProfitCalculatorBlocKey.accountCurrency:
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
        case MatexForexStopLossTakeProfitCalculatorBlocKey.accountCurrency:
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
    } else if (value is Enum) {
      switch (key) {
        case MatexForexStopLossTakeProfitCalculatorBlocKey
              .positionSizeFieldType:
          return patchPositionSizeFieldType(value.name);

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
      case MatexForexStopLossTakeProfitCalculatorBlocKey.accountCurrency:
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
      case MatexForexStopLossTakeProfitCalculatorBlocKey.accountCurrency:
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
          kDefaultPipPipDecimalPlaces,
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

    int pipDecimalPlaces = kDefaultPipPipDecimalPlaces;

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

    // Note: Loads default metadata values from the super class.
    // instrument metadata will be loaded in the willCompute method.
    final metadata = await super.loadMetadata();

    if (instrument == null) {
      fields = currentState.fields.copyWithDefaults(
        resetPipDecimalPlaces: true,
        resetCounter: true,
        resetBase: true,
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
    } else if (positionSizeFieldType == MatexPositionSizeType.unit.name) {
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
    } else if (positionSizeFieldType != MatexPositionSizeType.unit.name) {
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

      calculator.pipDecimalPlaces = kDefaultPipPipDecimalPlaces;
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
    String? value,
  ) {
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
