// Dart imports:
import 'dart:math';

// Package imports:
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';

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

    final pipDecimalPlaces = state.pipDecimalPlaces;
    final dPriceA = toDecimalOrDefault(state.priceA);
    final dPriceB = toDecimalOrDefault(state.priceB);
    final decimalMultiplicator = pow(10, pipDecimalPlaces).toString();
    final dDelta = dPriceA - dPriceB;
    final dDecimalMultiplicator = toDecimalOrDefault(decimalMultiplicator);
    final dResult = dDelta * dDecimalMultiplicator;

    return MatexForexPipDeltaCalculatorResults(
      numberOfPips: dResult.toDouble().abs(),
    );
  }
}
