// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

// Initialize default state for the Pip Value Calculator
final _kDefaultPipValueBlocState = MatexPipValueCalculatorBlocState(
  fields: MatexPipValueCalculatorBlocFields(),
  results: const MatexPipValueCalculatorBlocResults(),
);

class MatexPipValueCalculatorBloc extends MatexCalculatorBloc<
    MatexPipValueCalculator,
    FastCalculatorBlocEvent,
    MatexPipValueCalculatorBlocState,
    MatexPipValueCalculatorDocument,
    MatexPipValueCalculatorBlocResults> {
  MatexPipValueCalculatorBloc({
    MatexPipValueCalculatorBlocState? initialState,
    MatexPipValueCalculatorDataProvider? dataProvider,
    super.showExportPdfDialog,
    super.debouceComputeEvents,
  }) : super(
          initialState: initialState ?? _kDefaultPipValueBlocState,
          dataProvider: dataProvider ?? MatexPipValueCalculatorDataProvider(),
          debugLabel: 'MatexPipValueCalculatorBloc',
        ) {
    calculator = MatexPipValueCalculator();

    // FIXME:
    // Add listeners for default value changes if needed

    _listenToPrimaryCurrencyCodeChanges();
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
        key: MatexPipValueCalculatorBlocKey.accountCurrency,
        value: state.primaryCurrencyCode,
      ));
    }
  }

  @override
  Future<MatexPipValueCalculatorBlocResults> compute() async {
    if (await isCalculatorStateValid()) {
      // final results = calculator.value();
      // FIXME: add your own logic here

      return MatexPipValueCalculatorBlocResults();
    }

    return retrieveDefaultResult();
  }

  @override
  Future<MatexPipValueCalculatorDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      switch (key) {
        case MatexPipValueCalculatorBlocKey.accountCurrency:
          return document.copyWith(accountCurrency: value);

        case MatexPipValueCalculatorBlocKey.positionSize:
          return document.copyWith(positionSize: value);

        case MatexPipValueCalculatorBlocKey.numberOfPips:
          return document.copyWith(numberOfPips: value);

        case MatexPipValueCalculatorBlocKey.pipDecimalPlaces:
          return document.copyWith(pipDecimalPlaces: value);
      }
    } else if (value is Enum) {
      value = describeEnum(value);

      switch (key) {
        case MatexPipValueCalculatorBlocKey.positionSizeFieldType:
          return document.copyWith(
            positionSizeFieldType: value,
            positionSize: '',
          );
      }
    } else if (value is MatexFinancialInstrument) {
      switch (key) {
        case MatexPipValueCalculatorBlocKey.instrument:
          return document.copyWith(
            baseCurrency: value.baseCode,
            counterCurrency: value.counterCode,
          );
      }
    }

    return null;
  }

  @override
  Future<MatexPipValueCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      switch (key) {
        case MatexPipValueCalculatorBlocKey.accountCurrency:
          return patchAccountCurrency(value);

        case MatexPipValueCalculatorBlocKey.positionSize:
          return patchPositionSize(value);

        case MatexPipValueCalculatorBlocKey.numberOfPips:
          return patchNumberOfPips(value);

        case MatexPipValueCalculatorBlocKey.pipDecimalPlaces:
          return patchPipDecimalPlaces(value);
      }
    } else if (value is Enum) {
      value = describeEnum(value);

      switch (key) {
        case MatexPipValueCalculatorBlocKey.positionSizeFieldType:
          return patchPositionSizeFieldType(value);

        default:
          debugLog('Invalid key: $key', debugLabel: debugLabel);
          break;
      }
    } else if (value is MatexFinancialInstrument) {
      switch (key) {
        case MatexPipValueCalculatorBlocKey.instrument:
          return patchInstrument(value);
      }
    }

    return null;
  }

  @override
  Future<MatexPipValueCalculatorDocument?> resetCalculatorDocument(
    String key,
  ) async {
    switch (key) {
      case MatexPipValueCalculatorBlocKey.accountCurrency:
        return document.copyWithDefaults(accountCurrency: true);

      case MatexPipValueCalculatorBlocKey.instrument:
        return document.copyWithDefaults(
          counterCurrency: true,
          baseCurrency: true,
        );
    }

    return null;
  }

  @override
  Future<MatexPipValueCalculatorBlocState?> resetCalculatorState(
    String key,
  ) async {
    switch (key) {
      case MatexPipValueCalculatorBlocKey.accountCurrency:
        return patchAccountCurrency(null);

      case MatexPipValueCalculatorBlocKey.instrument:
        return patchInstrument(null);
    }

    return null;
  }

  @override
  Future<void> resetCalculator(
    MatexPipValueCalculatorDocument document,
  ) async {
    calculator.setState(MatexPipValueCalculatorState(
      positionSize: parseStringToDouble(document.positionSize),
      pipDecimalPlaces: parseStringToInt(document.pipDecimalPlaces),
    ));
  }

  @override
  Future<MatexPipValueCalculatorBlocState> resetCalculatorBlocState(
    MatexPipValueCalculatorDocument document,
  ) async {
    return _kDefaultPipValueBlocState.copyWith(
      fields: MatexPipValueCalculatorBlocFields(
        // FIXME: add default values here
        accountCurrency: document.accountCurrency,
      ),
    );
  }

  @override
  Future<MatexPipValueCalculatorDocument>
      retrieveDefaultCalculatorDocument() async {
    // final bloc = FastAppDictBloc.instance;

    return MatexPipValueCalculatorDocument(
      // FIXME: add default values here
      accountCurrency: getUserCurrencyCode(),
    );
  }

  @override
  Future<MatexPipValueCalculatorBlocResults> retrieveDefaultResult() async {
    return MatexPipValueCalculatorBlocResults(
      formattedPipValue: localizeCurrency(value: 0),
      pipValue: 0,
    );
  }

  MatexPipValueCalculatorBlocState patchAccountCurrency(String? value) {
    late final MatexPipValueCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(accountCurrency: true);
    } else {
      fields = currentState.fields.copyWith(accountCurrency: value);
    }

    calculator.isAccountCurrencyCounterCurrency =
        value == fields.counterCurrency;

    return currentState.copyWith(fields: fields);
  }

  MatexPipValueCalculatorBlocState patchInstrument(
    MatexFinancialInstrument? instrument,
  ) {
    late final MatexPipValueCalculatorBlocFields fields;

    if (instrument == null) {
      fields = currentState.fields.copyWithDefaults(
        baseCurrency: true,
        counterCurrency: true,
      );

      calculator.isAccountCurrencyCounterCurrency = false;
    } else {
      fields = currentState.fields.copyWith(
        baseCurrency: instrument.baseCode,
        counterCurrency: instrument.counterCode,
      );

      calculator.isAccountCurrencyCounterCurrency =
          instrument.counterCode == fields.accountCurrency;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexPipValueCalculatorBlocState patchPositionSize(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(positionSize: value);
    calculator.positionSize = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexPipValueCalculatorBlocState patchNumberOfPips(String value) {
    final fields = currentState.fields.copyWith(numberOfPips: value);

    return currentState.copyWith(fields: fields);
  }

  MatexPipValueCalculatorBlocState patchPipDecimalPlaces(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(pipDecimalPlaces: value);
    calculator.pipDecimalPlaces = dValue.toDouble().toInt();

    return currentState.copyWith(fields: fields);
  }

  MatexPipValueCalculatorBlocState patchPositionSizeFieldType(String value) {
    final fields = currentState.fields.copyWith(
      positionSizeFieldType: value,
      positionSize: '',
    );

    calculator.positionSize = 0;

    return currentState.copyWith(fields: fields);
  }

// FIXME: implement the toPdf method
//   @override
//   Future<Uint8List> toPdf(BuildContext context) async {

//   }
}
