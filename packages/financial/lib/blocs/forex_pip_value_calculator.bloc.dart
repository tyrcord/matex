// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';
import 'package:tenhance/decimal.dart';
import 'package:tlogger/logger.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

// Initialize default state for the Pip Value Calculator
final _kDefaultPipValueBlocState = MatexForexPipValueCalculatorBlocState(
  results: const MatexForexPipValueCalculatorBlocResults(),
  fields: MatexForexPipValueCalculatorBlocFields(),
);

class MatexForexPipValueCalculatorBloc extends MatexFinancialCalculatorBloc<
        MatexForexPipValueCalculator,
        FastCalculatorBlocEvent,
        MatexForexPipValueCalculatorBlocState,
        MatexForexPipValueCalculatorDocument,
        MatexForexPipValueCalculatorBlocResults>
    with MatexFinancialCalculatorFormatterMixin {
  static const defaultDebugLabel = 'MatexForexPipValueCalculatorBloc';

  MatexForexPipValueCalculatorBloc({
    MatexForexPipValueCalculatorBlocState? initialState,
    MatexForexPipValueCalculatorDataProvider? dataProvider,
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
              dataProvider ?? MatexForexPipValueCalculatorDataProvider(),
          debugLabel: defaultDebugLabel,
        ) {
    logger = TLoggerManager().getLogger(defaultDebugLabel);
    calculator = MatexForexPipValueCalculator();

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorFinancialInstrument.name,
      MatexForexPipValueCalculatorBlocKey.instrument,
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
  @mustCallSuper
  Stream<MatexForexPipValueCalculatorBlocState> willCompute() async* {
    logger?.debug('willCompute');
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
        positionSize: dLotSize.toSafeDouble(),
        lotSize: positionSizeFieldType,
      );

      calculator.positionSize = positionSize;
    }
  }

  @override
  Future<MatexForexPipValueCalculatorBlocResults> compute() async {
    if (await isCalculatorStateValid()) {
      final results = calculator.value();
      final fields = currentState.fields;
      final dNumberOfPips = toDecimalOrDefault(fields.numberOfPips);
      final dPipValue = toDecimalOrDefault(results.pipValue);
      final dCustomPipValue = dPipValue * dNumberOfPips;
      final accountCurrency = fields.accountCurrency;
      final positionSize = calculator.positionSize;
      final customPipValue = dCustomPipValue.toSafeDouble();
      final pipValue = dPipValue.toSafeDouble();
      final standardLotUnits = await getUnitsPerStandardLot();
      final miniLotUnits = await getUnitsPerMiniLot();
      final microLotUnits = await getUnitsPerMicroLot();

      final standardLotValue = computePipValueForUnits(
        standardLotUnits,
        pipValue,
        positionSize,
      );

      final miniLotValue = computePipValueForUnits(
        miniLotUnits,
        pipValue,
        positionSize,
      );

      final microLotValue = computePipValueForUnits(
        microLotUnits,
        pipValue,
        positionSize,
      );

      return MatexForexPipValueCalculatorBlocResults(
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
          value: computePipValueForUnits(
            standardLotUnits,
            pipValue,
            positionSize,
          ),
        ),
        formattedMiniLotValue: localizeCurrency(
          symbol: accountCurrency,
          minimumFractionDigits: 3,
          value: computePipValueForUnits(
            miniLotUnits,
            pipValue,
            positionSize,
          ),
        ),
        formattedMicroLotValue: localizeCurrency(
          symbol: accountCurrency,
          minimumFractionDigits: 3,
          value: computePipValueForUnits(
            microLotUnits,
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
  Future<MatexForexPipValueCalculatorDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value is Map<dynamic, dynamic> &&
        key == MatexForexPipValueCalculatorBlocKey.instrument) {
      value = MatexFinancialInstrument.fromJson(value);
    }

    if (value == null) {
      switch (key) {
        case MatexFiancialCalculatorBlocKey.accountCurrency:
          return document.copyWithDefaults(resetAccountCurrency: true);

        case MatexForexPipValueCalculatorBlocKey.positionSize:
          return document.copyWithDefaults(resetPositionSize: true);

        case MatexForexPipValueCalculatorBlocKey.numberOfPips:
          return document.copyWithDefaults(resetNumberOfPips: true);

        case MatexForexPipValueCalculatorBlocKey.pipDecimalPlaces:
          return document.copyWithDefaults(resetPipDecimalPlaces: true);

        case MatexForexPipValueCalculatorBlocKey.lotSize:
          return document.copyWithDefaults(resetLotSize: true);

        case MatexForexPipValueCalculatorBlocKey.instrument:
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

        case MatexForexPipValueCalculatorBlocKey.positionSize:
          return document.copyWith(positionSize: value);

        case MatexForexPipValueCalculatorBlocKey.numberOfPips:
          return document.copyWith(numberOfPips: value);

        case MatexForexPipValueCalculatorBlocKey.pipDecimalPlaces:
          return document.copyWith(pipDecimalPlaces: value);

        case MatexForexPipValueCalculatorBlocKey.lotSize:
          return document.copyWith(lotSize: value);
      }
    } else if (value is Enum) {
      if (key == MatexForexPipValueCalculatorBlocKey.positionSizeFieldType) {
        return document.copyWith(
          positionSizeFieldType: value.name,
          positionSize: '',
          lotSize: '',
        );
      }
    } else if (value is MatexFinancialInstrument) {
      if (key == MatexForexPipDeltaCalculatorBlocKey.instrument) {
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
  Future<MatexForexPipValueCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is Map<dynamic, dynamic> &&
        key == MatexForexPipValueCalculatorBlocKey.instrument) {
      value = MatexFinancialInstrument.fromJson(value);
    }

    if (value is String?) {
      switch (key) {
        case MatexFiancialCalculatorBlocKey.accountCurrency:
          return patchAccountCurrency(value);

        case MatexForexPipValueCalculatorBlocKey.positionSize:
          return patchPositionSize(value);

        case MatexForexPipValueCalculatorBlocKey.numberOfPips:
          return patchNumberOfPips(value);

        case MatexForexPipValueCalculatorBlocKey.pipDecimalPlaces:
          return patchPipDecimalPlaces(value);

        case MatexForexPipValueCalculatorBlocKey.lotSize:
          return patchLotSize(value);

        case MatexForexPipValueCalculatorBlocKey.instrument:
          return patchInstrument(null);
      }
    } else if (value is MatexPositionSizeType) {
      if (key == MatexForexPipValueCalculatorBlocKey.positionSizeFieldType) {
        return patchPositionSizeFieldType(value);
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
    MatexForexPipValueCalculatorDocument document,
  ) async {
    calculator.setState(MatexForexPipValueCalculatorState(
      pipDecimalPlaces: parseStringToInt(document.pipDecimalPlaces),
      positionSize: parseStringToDouble(document.positionSize),
    ));
  }

  @override
  Future<MatexForexPipValueCalculatorBlocState> resetCalculatorBlocState(
    MatexForexPipValueCalculatorDocument document,
  ) async {
    final pipDecimalPlaces = await getPipPrecision(
      counter: document.counter,
      base: document.base,
    );

    return _kDefaultPipValueBlocState.copyWith(
      results: await retrieveDefaultResult(),
      fields: MatexForexPipValueCalculatorBlocFields(
        pipDecimalPlaces: pipDecimalPlaces.toString(),
        accountCurrency: document.accountCurrency,
        counter: document.counter,
        base: document.base,
      ),
    );
  }

  @override
  Future<MatexForexPipValueCalculatorDocument>
      retrieveDefaultCalculatorDocument() async {
    final instrument = userDefaultInstrument;
    int pipDecimalPlaces = kMatexDefaultPipDecimalPlaces;

    if (instrument != null) {
      pipDecimalPlaces = await getPipPrecision(
        counter: instrument.counter,
        base: instrument.base,
      );
    }

    return MatexForexPipValueCalculatorDocument(
      pipDecimalPlaces: pipDecimalPlaces.toString(),
      accountCurrency: getUserCurrencyCode(),
      counter: instrument?.counter,
      base: instrument?.base,
    );
  }

  @override
  Future<MatexForexPipValueCalculatorBlocResults>
      retrieveDefaultResult() async {
    return MatexForexPipValueCalculatorBlocResults(
      formattedPipValue: localizeCurrency(value: 0),
      pipValue: 0,
    );
  }

  MatexForexPipValueCalculatorBlocState patchAccountCurrency(String? value) {
    late final MatexForexPipValueCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetAccountCurrency: true);
    } else {
      fields = currentState.fields.copyWith(accountCurrency: value);
    }

    return currentState.copyWith(fields: fields);
  }

  Future<MatexForexPipValueCalculatorBlocState> patchInstrument(
    MatexFinancialInstrument? instrument,
  ) async {
    late MatexForexPipValueCalculatorBlocFields fields;

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

  MatexForexPipValueCalculatorBlocState patchPositionSize(String? value) {
    var fields = currentState.fields;
    final positionSizeFieldType = fields.positionSizeFieldType;

    if (value == null) {
      fields = fields.copyWithDefaults(
        resetPositionSize: true,
        resetLotSize: true,
      );

      calculator.positionSize = 0;
    } else if (positionSizeFieldType == MatexPositionSizeType.unit) {
      final dValue = toDecimalOrDefault(value);
      fields = fields.copyWith(positionSize: value);
      calculator.positionSize = dValue.toSafeDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  Future<MatexForexPipValueCalculatorBlocState> patchLotSize(
    String? value,
  ) async {
    late MatexForexPipValueCalculatorBlocFields fields;

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

    calculator.positionSize = 0;

    return currentState.copyWith(fields: fields);
  }

  MatexForexPipValueCalculatorBlocState patchNumberOfPips(String? value) {
    late final MatexForexPipValueCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetNumberOfPips: true);
    } else {
      fields = currentState.fields.copyWith(numberOfPips: value);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexPipValueCalculatorBlocState patchPipDecimalPlaces(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetPipDecimalPlaces: true);
      calculator.pipDecimalPlaces = kMatexDefaultPipDecimalPlaces;
    } else {
      fields = fields.copyWith(pipDecimalPlaces: value);
      final dValue = toDecimalOrDefault(value);
      calculator.pipDecimalPlaces = dValue.toSafeDouble().toInt();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexPipValueCalculatorBlocState patchPositionSizeFieldType(
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
  String getReportFilename() => 'forex_pip_value_calculator_report';

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexForexPipValueCalculatorPdfGenerator();
    final metadata = currentState.metadata;
    final fields = currentState.fields;
    final results = await compute();

    // ignore: use_build_context_synchronously
    return pdfGenerator.generate(context, fields, results, metadata);
  }
}
