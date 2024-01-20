// Package imports:
import 'package:matex_core/core.dart';
import 'package:tenhance/decimal.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexPipValueCalculator extends MatexCalculator<
    MatexForexPipValueCalculatorState, MatexForexPipValueCalculatorResults> {
  MatexForexPipValueCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: pipValueValidators);

  @override
  MatexForexPipValueCalculatorState initializeState() =>
      const MatexForexPipValueCalculatorState();

  @override
  MatexForexPipValueCalculatorState initializeDefaultState() =>
      initializeState();

  bool? get isAccountCurrencyCounter => state.isAccountCurrencyCounter;
  double? get instrumentPairRate => state.instrumentPairRate;
  int? get pipDecimalPlaces => state.pipDecimalPlaces;
  double? get positionSize => state.positionSize;

  double? get counterToAccountCurrencyRate {
    return state.counterToAccountCurrencyRate;
  }

  set positionSize(double? value) {
    setState(state.copyWith(positionSize: value));
  }

  set pipDecimalPlaces(int? value) {
    setState(state.copyWith(pipDecimalPlaces: value));
  }

  set isAccountCurrencyCounter(bool? value) {
    setState(state.copyWith(isAccountCurrencyCounter: value));
  }

  set counterToAccountCurrencyRate(double? value) {
    setState(state.copyWith(counterToAccountCurrencyRate: value));
  }

  set instrumentPairRate(double? value) {
    setState(state.copyWith(instrumentPairRate: value));
  }

  static const defaultResults = MatexForexPipValueCalculatorResults(
    pipValue: 0,
  );

  @override
  MatexForexPipValueCalculatorResults value() {
    if (!isValid) return defaultResults;

    final dPipValue = computePipValue(
      counterToAccountCurrencyRate: state.counterToAccountCurrencyRate,
      isAccountCurrencyCounter: state.isAccountCurrencyCounter,
      instrumentPairRate: state.instrumentPairRate,
      pipDecimalPlaces: state.pipDecimalPlaces,
      positionSize: state.positionSize,
    );

    return MatexForexPipValueCalculatorResults(
      pipValue: dPipValue.toSafeDouble(),
    );
  }
}
