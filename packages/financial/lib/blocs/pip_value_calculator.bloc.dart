import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';

import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

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
  }

  @override
  Future<MatexPipValueCalculatorBlocResults> compute() async {
    if (await isCalculatorStateValid()) {
      final results = calculator.value();
      // FIXME: add your own logic here

      return MatexPipValueCalculatorBlocResults();
    }

    return retrieveDefaultResult(); // You may want to return a default result structure here
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

        case MatexPipValueCalculatorBlocKey.baseCurrency:
          return document.copyWith(baseCurrency: value);

        case MatexPipValueCalculatorBlocKey.counterCurrency:
          return document.copyWith(counterCurrency: value);

        case MatexPipValueCalculatorBlocKey.positionSize:
          return document.copyWith(positionSize: value);

        case MatexPipValueCalculatorBlocKey.numberOfPips:
          return document.copyWith(numberOfPips: value);

        case MatexPipValueCalculatorBlocKey.pipDecimalPlaces:
          return document.copyWith(pipDecimalPlaces: value);

        default:
          debugLog('Invalid key: $key', debugLabel: debugLabel);
      }
    }

    return null;
  }

  // Implement the patchCalculatorState method to update the calculator's state based on input changes.
  @override
  Future<MatexPipValueCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      switch (key) {
        case MatexPipValueCalculatorBlocKey.accountCurrency:
          return patchAccountCurrency(value);

        case MatexPipValueCalculatorBlocKey.baseCurrency:
          return patchBaseCurrency(value);

        case MatexPipValueCalculatorBlocKey.counterCurrency:
          return patchCounterCurrency(value);

        case MatexPipValueCalculatorBlocKey.positionSize:
          return patchPositionSize(value);

        case MatexPipValueCalculatorBlocKey.numberOfPips:
          return patchNumberOfPips(value);

        case MatexPipValueCalculatorBlocKey.pipDecimalPlaces:
          return patchPipDecimalPlaces(value);

        default:
          debugLog('Invalid key: $key', debugLabel: debugLabel);
          break;
      }
    }
    // Handle any other necessary types or error handling here.
    return null; // Or handle this scenario as needed.
  }

  @override
  Future<void> resetCalculator(
    MatexPipValueCalculatorDocument document,
  ) async {
    calculator.setState(MatexPipValueCalculatorState(
      accountCurrency: document.accountCurrency,
      baseCurrency: document.baseCurrency,
      counterCurrency: document.counterCurrency,
      positionSize: parseStringToDouble(document.positionSize),
      numberOfPips: parseStringToDouble(document.numberOfPips),
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
          ),
    );
  }

  @override
  Future<MatexPipValueCalculatorDocument>
      retrieveDefaultCalculatorDocument() async {
    final bloc = FastAppDictBloc.instance;

    return MatexPipValueCalculatorDocument(
        // FIXME: add default values here

        );
  }

  @override
  Future<MatexPipValueCalculatorBlocResults> retrieveDefaultResult() async {
    return MatexPipValueCalculatorBlocResults(
      formattedPipValue: localizeCurrency(value: 0),
      pipValue: 0,
    );
  }

  MatexPipValueCalculatorBlocState patchAccountCurrency(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(accountCurrency: value);
    // calculator.accountCurrency = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexPipValueCalculatorBlocState patchBaseCurrency(String value) {
    final fields = currentState.fields.copyWith(baseCurrency: value);
    // calculator.baseCurrency = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexPipValueCalculatorBlocState patchCounterCurrency(String value) {
    final fields = currentState.fields.copyWith(counterCurrency: value);
    // calculator.counterCurrency = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexPipValueCalculatorBlocState patchPositionSize(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(positionSize: value);
    // calculator.positionSize = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexPipValueCalculatorBlocState patchNumberOfPips(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(numberOfPips: value);
    // calculator.numberOfPips = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexPipValueCalculatorBlocState patchPipDecimalPlaces(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(pipDecimalPlaces: value);
    // calculator.pipDecimalPlaces = dValue.toInt();

    return currentState.copyWith(fields: fields);
  }

// FIXME: implement the toPdf method
//   @override
//   Future<Uint8List> toPdf(BuildContext context) async {

//   }
}
