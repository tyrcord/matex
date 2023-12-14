// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexPipDeltaCalculator extends MatexCalculator<
    MatexForexPipDeltaCalculatorState, MatexForexPipDeltaCalculatorResults> {
  MatexForexPipDeltaCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: forexPipDeltaValidators);

  @override
  MatexForexPipDeltaCalculatorState initializeState() =>
      const MatexForexPipDeltaCalculatorState();

  @override
  MatexForexPipDeltaCalculatorState initializeDefaultState() =>
      initializeState();

  int? get pipDecimalPlaces => state.pipDecimalPlaces;
  double? get priceA => state.priceA;
  double? get priceB => state.priceB;

  set priceA(double? value) {
    setState(state.copyWith(priceA: value));
  }

  set pipDecimalPlaces(int? value) {
    setState(state.copyWith(pipDecimalPlaces: value));
  }

  set priceB(double? value) {
    setState(state.copyWith(priceB: value));
  }

  static const defaultResults = MatexForexPipDeltaCalculatorResults(
    numberOfPips: 0,
  );

  @override
  MatexForexPipDeltaCalculatorResults value() {
    if (!isValid) return defaultResults;

    final dPipDelta = computePipDelta(
      pipDecimalPlaces: state.pipDecimalPlaces,
      entryPrice: state.priceA,
      exitPrice: state.priceB,
    );

    return MatexForexPipDeltaCalculatorResults(
      numberOfPips: dPipDelta.toDouble().abs(),
    );
  }
}
