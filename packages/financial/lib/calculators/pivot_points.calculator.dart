// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexPivotPointsCalculator extends MatexCalculator<
    MatexPivotPointsCalculatorState, MatexPivotPointsCalculatorResults> {
  MatexPivotPointsCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: pivotPointsValidators);

  @override
  MatexPivotPointsCalculatorState initializeState() =>
      const MatexPivotPointsCalculatorState();

  @override
  MatexPivotPointsCalculatorState initializeDefaultState() => initializeState();

  double? get lowPrice => state.lowPrice;
  double? get highPrice => state.highPrice;
  double? get closePrice => state.closePrice;
  double? get openPrice => state.openPrice;
  MatexPivotPointsMethods get method => state.method;

  set lowPrice(double? value) {
    setState(state.copyWith(lowPrice: value));
  }

  set highPrice(double? value) {
    setState(state.copyWith(highPrice: value));
  }

  set closePrice(double? value) {
    setState(state.copyWith(closePrice: value));
  }

  set openPrice(double? value) {
    setState(state.copyWith(openPrice: value));
  }

  set method(MatexPivotPointsMethods value) {
    setState(state.copyWith(method: value));
  }

  static const defaultResults = MatexPivotPointsCalculatorResults(
    pivotPoint: 0,
  );

  @override
  MatexPivotPointsCalculatorResults value() {
    if (!isValid) return defaultResults;

    final closePrice = state.closePrice;
    final highPrice = state.highPrice;
    final lowPrice = state.lowPrice;

    switch (method) {
      case MatexPivotPointsMethods.camarilla:
        return pivotPointsCamarilla(highPrice, lowPrice, closePrice);
      case MatexPivotPointsMethods.deMark:
        final openPrice = state.openPrice;
        return pivotPointsDeMark(highPrice, lowPrice, closePrice, openPrice);
      case MatexPivotPointsMethods.fibonacci:
        return pivotPointsFibonacci(highPrice, lowPrice, closePrice);
      case MatexPivotPointsMethods.woodie:
        return pivotPointsWoodie(highPrice, lowPrice, closePrice);
      default:
        return pivotPointsStandard(highPrice, lowPrice, closePrice);
    }
  }
}
