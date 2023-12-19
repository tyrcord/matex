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
final _kDefaultPipValueBlocState = MatexForexRequiredMarginCalculatorBlocState(
  fields: MatexForexRequiredMarginCalculatorBlocFields(),
  results: const MatexForexRequiredMarginCalculatorBlocResults(),
);

class MatexForexRequiredMarginCalculatorBloc
    extends MatexFinancialCalculatorBloc<
        MatexForexRequiredMarginCalculator,
        FastCalculatorBlocEvent,
        MatexForexRequiredMarginCalculatorBlocState,
        MatexForexRequiredMarginCalculatorDocument,
        MatexForexRequiredMarginCalculatorBlocResults>
    with MatexFinancialCalculatorFormatterMixin {
  MatexForexRequiredMarginCalculatorBloc({
    MatexForexRequiredMarginCalculatorBlocState? initialState,
    MatexForexRequiredMarginCalculatorDataProvider? dataProvider,
    required super.exchangeProvider,
    super.debouceComputeEvents = true,
    super.isAutoRefreshEnabled = false,
    super.showExportPdfDialog,
    super.autoRefreshPeriod,
    super.delegate,
  }) : super(
          initialState: initialState ?? _kDefaultPipValueBlocState,
          dataProvider:
              dataProvider ?? MatexForexRequiredMarginCalculatorDataProvider(),
          debugLabel: 'MatexForexRequiredMarginCalculatorBloc',
        ) {
    calculator = MatexForexRequiredMarginCalculator();

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorFinancialInstrument.name,
      MatexForexRequiredMarginCalculatorBlocKey.instrument,
    );

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorLeverage.name,
      MatexForexRequiredMarginCalculatorBlocKey.leverage,
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
  Stream<MatexForexRequiredMarginCalculatorBlocState> willCompute() async* {
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
  Future<MatexForexRequiredMarginCalculatorBlocResults> compute() async {
    if (await isCalculatorStateValid()) {
      final results = calculator.value();

      return MatexForexRequiredMarginCalculatorBlocResults(
        requiredMargin: results.requiredMargin,
        formattedRequiredMargin: localizeCurrency(
          value: results.requiredMargin,
          maximumFractionDigits: 3,
        ),
      );
    }

    return retrieveDefaultResult();
  }

  @override
  Future<MatexForexRequiredMarginCalculatorDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value is Map<dynamic, dynamic> &&
        key == MatexForexRequiredMarginCalculatorBlocKey.instrument) {
      value = MatexFinancialInstrument.fromJson(value);
    }

    if (value == null) {
      switch (key) {
        case MatexFiancialCalculatorBlocKey.accountCurrency:
          return document.copyWithDefaults(resetAccountCurrency: true);

        case MatexForexRequiredMarginCalculatorBlocKey.positionSize:
          return document.copyWithDefaults(resetPositionSize: true);

        case MatexForexRequiredMarginCalculatorBlocKey.leverage:
          return document.copyWithDefaults(resetLeverage: true);

        case MatexForexRequiredMarginCalculatorBlocKey.lotSize:
          return document.copyWithDefaults(resetLotSize: true);

        case MatexForexRequiredMarginCalculatorBlocKey.instrument:
          return document.copyWithDefaults(
            resetCounter: true,
            resetBase: true,
          );
      }
    } else if (value is String) {
      switch (key) {
        case MatexFiancialCalculatorBlocKey.accountCurrency:
          return document.copyWith(accountCurrency: value);

        case MatexForexRequiredMarginCalculatorBlocKey.positionSize:
          return document.copyWith(positionSize: value);

        case MatexForexRequiredMarginCalculatorBlocKey.leverage:
          return document.copyWith(leverage: value);

        case MatexForexRequiredMarginCalculatorBlocKey.lotSize:
          return document.copyWith(lotSize: value);
      }
    } else if (value is Enum) {
      switch (key) {
        case MatexForexRequiredMarginCalculatorBlocKey.positionSizeFieldType:
          return document.copyWith(
            positionSizeFieldType: value.name,
            positionSize: '',
            lotSize: '',
          );
      }
    } else if (value is MatexFinancialInstrument) {
      if (key == MatexForexPipDeltaCalculatorBlocKey.instrument) {
        return document.copyWith(
          counter: value.counter,
          base: value.base,
        );
      }
    }

    return null;
  }

  @override
  Future<MatexForexRequiredMarginCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is Map<dynamic, dynamic> &&
        key == MatexForexRequiredMarginCalculatorBlocKey.instrument) {
      value = MatexFinancialInstrument.fromJson(value);
    }

    if (value is String?) {
      switch (key) {
        case MatexFiancialCalculatorBlocKey.accountCurrency:
          return patchAccountCurrency(value);

        case MatexForexRequiredMarginCalculatorBlocKey.positionSize:
          return patchPositionSize(value);

        case MatexForexRequiredMarginCalculatorBlocKey.leverage:
          return patchLeverage(value);

        case MatexForexRequiredMarginCalculatorBlocKey.lotSize:
          return patchLotSize(value);

        case MatexForexPipValueCalculatorBlocKey.instrument:
          return patchInstrument(null);
      }
    } else if (value is MatexPositionSizeType) {
      if (key ==
          MatexForexRequiredMarginCalculatorBlocKey.positionSizeFieldType) {
        return patchPositionSizeFieldType(value);
      }
    } else if (value is MatexFinancialInstrument) {
      if (key == MatexForexRequiredMarginCalculatorBlocKey.instrument) {
        return patchInstrument(value);
      }
    }

    return null;
  }

  @override
  Future<void> resetCalculator(
    MatexForexRequiredMarginCalculatorDocument document,
  ) async {
    calculator.setState(MatexForexRequiredMarginCalculatorState(
      positionSize: parseStringToDouble(document.positionSize),
      leverage: parseStringToDouble(document.leverage),
    ));
  }

  @override
  Future<MatexForexRequiredMarginCalculatorBlocState> resetCalculatorBlocState(
    MatexForexRequiredMarginCalculatorDocument document,
  ) async {
    return _kDefaultPipValueBlocState.copyWith(
      results: await retrieveDefaultResult(),
      fields: MatexForexRequiredMarginCalculatorBlocFields(
        accountCurrency: document.accountCurrency,
        leverage: document.leverage,
        counter: document.counter,
        base: document.base,
      ),
    );
  }

  @override
  Future<MatexForexRequiredMarginCalculatorDocument>
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

    if (json != null) {
      instrument = MatexFinancialInstrument.fromJson(json);
    }

    final leverage = bloc.getValue<double?>(
      MatexCalculatorDefaultValueKeys.matexCalculatorLeverage.name,
    );

    return MatexForexRequiredMarginCalculatorDocument(
      leverage: leverage?.toString() ?? kMatexDefaultLeverage.toString(),
      accountCurrency: getUserCurrencyCode(),
      counter: instrument?.counter,
      base: instrument?.base,
    );
  }

  @override
  Future<MatexForexRequiredMarginCalculatorBlocResults>
      retrieveDefaultResult() async {
    return MatexForexRequiredMarginCalculatorBlocResults(
      formattedRequiredMargin: localizeCurrency(value: 0),
      requiredMargin: 0,
    );
  }

  MatexForexRequiredMarginCalculatorBlocState patchAccountCurrency(
    String? value,
  ) {
    late final MatexForexRequiredMarginCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetAccountCurrency: true);
    } else {
      fields = currentState.fields.copyWith(accountCurrency: value);
    }

    return currentState.copyWith(fields: fields);
  }

  Future<MatexForexRequiredMarginCalculatorBlocState> patchInstrument(
    MatexFinancialInstrument? instrument,
  ) async {
    late MatexForexRequiredMarginCalculatorBlocFields fields;

    calculator
      ..counterToAccountCurrencyRate = 0
      ..isAccountCurrencyCounter = false
      ..instrumentPairRate = 0;

    if (instrument == null) {
      fields = currentState.fields.copyWithDefaults(
        resetCounter: true,
        resetBase: true,
      );
    } else {
      fields = currentState.fields.copyWith(
        counter: instrument.counter,
        base: instrument.base,
      );
    }

    return currentState.copyWith(
      metadata: mergeMetadata(emptyInstrumentMetadata),
      fields: fields,
    );
  }

  MatexForexRequiredMarginCalculatorBlocState patchPositionSize(String? value) {
    late MatexForexRequiredMarginCalculatorBlocFields fields;
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

  Future<MatexForexRequiredMarginCalculatorBlocState> patchLotSize(
    String? value,
  ) async {
    late MatexForexRequiredMarginCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetLotSize: true);
    } else {
      fields = currentState.fields.copyWith(lotSize: value);
      // NOTE: we need to convert the lot size to a position size
      // will be done in the will compute method
    }

    calculator.positionSize = 0;

    return currentState.copyWith(fields: fields);
  }

  MatexForexRequiredMarginCalculatorBlocState patchLeverage(String? value) {
    late final MatexForexRequiredMarginCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetLeverage: true);
      calculator.leverage = kMatexDefaultLeverage;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = currentState.fields.copyWith(leverage: value);
      calculator.leverage = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexRequiredMarginCalculatorBlocState patchPositionSizeFieldType(
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

  Future<void> patchCalculatorExchangeRates({
    required String accountCurrency,
    MatexFinancialInstrument? instrument,
    double? instrumentPairRate,
  }) async {
    calculator
      ..instrumentPairRate = instrumentPairRate ?? 0
      ..counterToAccountCurrencyRate = 0
      ..isAccountCurrencyBase = false
      ..isAccountCurrencyCounter = false;

    if (instrument == null) return;

    final counter = instrument.counter!;
    final base = instrument.base!;

    calculator.isAccountCurrencyBase = accountCurrency == base;

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
  String getReportFilename() => 'forex_required_margin_calculator_report';

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexForexRequiredMarginCalculatorPdfGenerator();
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
