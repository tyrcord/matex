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
  final MatexFinancialInstrumentExchangeService exchangeProvider;

  MatexForexRequiredMarginCalculatorBloc({
    MatexForexRequiredMarginCalculatorBlocState? initialState,
    MatexForexRequiredMarginCalculatorDataProvider? dataProvider,
    required this.exchangeProvider,
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
        key: MatexForexRequiredMarginCalculatorBlocKey.accountCurrency,
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
  Stream<MatexForexRequiredMarginCalculatorBlocState> willCompute() async* {
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

    if (!isMandatoryFieldValid) return metadata;

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
    };
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

    if (value is String) {
      switch (key) {
        case MatexForexRequiredMarginCalculatorBlocKey.accountCurrency:
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
      switch (key) {
        case MatexForexRequiredMarginCalculatorBlocKey.instrument:
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
        case MatexForexRequiredMarginCalculatorBlocKey.accountCurrency:
          return patchAccountCurrency(value);

        case MatexForexRequiredMarginCalculatorBlocKey.positionSize:
          return patchPositionSize(value);

        case MatexForexRequiredMarginCalculatorBlocKey.leverage:
          return patchLeverage(value);

        case MatexForexRequiredMarginCalculatorBlocKey.lotSize:
          return patchLotSize(value);
      }
    } else if (value is Enum) {
      switch (key) {
        case MatexForexRequiredMarginCalculatorBlocKey.positionSizeFieldType:
          return patchPositionSizeFieldType(value.name);

        default:
          debugLog('Invalid key: $key', debugLabel: debugLabel);
          break;
      }
    } else if (value is MatexFinancialInstrument) {
      switch (key) {
        case MatexForexRequiredMarginCalculatorBlocKey.instrument:
          return patchInstrument(value);
      }
    }

    return null;
  }

  @override
  Future<MatexForexRequiredMarginCalculatorDocument?> resetCalculatorDocument(
    String key,
  ) async {
    switch (key) {
      case MatexForexRequiredMarginCalculatorBlocKey.accountCurrency:
        return document.copyWithDefaults(resetAccountCurrency: true);

      case MatexForexRequiredMarginCalculatorBlocKey.instrument:
        return document.copyWithDefaults(
          resetCounter: true,
          resetBase: true,
        );
    }

    return null;
  }

  @override
  Future<MatexForexRequiredMarginCalculatorBlocState?> resetCalculatorState(
    String key,
  ) async {
    switch (key) {
      case MatexForexRequiredMarginCalculatorBlocKey.accountCurrency:
        return patchAccountCurrency(null);

      case MatexForexRequiredMarginCalculatorBlocKey.instrument:
        return patchInstrument(null);
    }

    return null;
  }

  @override
  Future<void> resetCalculator(
    MatexForexRequiredMarginCalculatorDocument document,
  ) async {
    calculator.setState(MatexForexRequiredMarginCalculatorState(
      positionSize: parseStringToDouble(document.positionSize),
      leverage: parseStringToDouble(document.leverage) ?? 1,
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

    return MatexForexRequiredMarginCalculatorDocument(
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
    late final MatexForexRequiredMarginCalculatorBlocFields fields;

    calculator
      ..counterToAccountCurrencyRate = 0
      ..isAccountCurrencyBase = false
      ..isAccountCurrencyCounter = false
      ..instrumentPairRate = 0;

    // Note: Loads default metadata values from the super class.
    // instrument metadata will be loaded in the willCompute method.
    final metadata = await super.loadMetadata();

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

    return currentState.copyWith(fields: fields, metadata: metadata);
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
    } else if (positionSizeFieldType == MatexPositionSizeType.unit.name) {
      final dValue = toDecimalOrDefault(value);
      fields = currentState.fields.copyWith(positionSize: value);
      calculator.positionSize = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexRequiredMarginCalculatorBlocState patchLotSize(String? value) {
    late MatexForexRequiredMarginCalculatorBlocFields fields;
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

  MatexForexRequiredMarginCalculatorBlocState patchLeverage(String? value) {
    late final MatexForexRequiredMarginCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetLeverage: true);
      calculator.leverage = 1;
    } else {
      final dValue = toDecimal(value) ?? dZero;
      fields = currentState.fields.copyWith(leverage: value);
      calculator.leverage = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexRequiredMarginCalculatorBlocState patchPositionSizeFieldType(
    String value,
  ) {
    final fields = currentState.fields.copyWith(
      positionSizeFieldType: value,
      positionSize: '',
      lotSize: '',
    );

    calculator.positionSize = 0;

    return currentState.copyWith(fields: fields);
  }

  // FIXME: take a look at pip value calculator
  // to see how to refactor this method and combine them
  Future<MatexQuote?> patchExchangeRates() async {
    final accountCurrency = currentState.fields.accountCurrency!;
    final counter = currentState.fields.counter!;
    final base = currentState.fields.base!;
    final symbol = base + counter;
    final instrumentQuoteFuture = exchangeProvider.rate(symbol);
    final instrumentQuote = await instrumentQuoteFuture;

    if (instrumentQuote == null) {
      // FIXME: display an error message
      return null;
    }

    calculator
      ..instrumentPairRate = instrumentQuote.price
      ..counterToAccountCurrencyRate = 0
      ..isAccountCurrencyBase = accountCurrency == base
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
  String getReportFilename() => 'forex_pip_value_calculator_report';

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
