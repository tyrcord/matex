// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexRequiredMarginCalculator extends MatexCalculator<
    MatexForexRequiredMarginCalculatorState,
    MatexForexRequiredMarginCalculatorResults> {
  MatexForexRequiredMarginCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: forexRequiredMarginValidators);

  @override
  MatexForexRequiredMarginCalculatorState initializeState() =>
      const MatexForexRequiredMarginCalculatorState();

  @override
  MatexForexRequiredMarginCalculatorState initializeDefaultState() =>
      initializeState();

  bool get isAccountCurrencyCounter => state.isAccountCurrencyCounter;
  bool get isAccountCurrencyBase => state.isAccountCurrencyBase;
  double? get instrumentPairRate => state.instrumentPairRate;
  double? get positionSize => state.positionSize;
  double? get leverage => state.leverage;

  double? get counterToAccountCurrencyRate {
    return state.counterToAccountCurrencyRate;
  }

  set isAccountCurrencyBase(bool? value) {
    setState(state.copyWith(isAccountCurrencyBase: value));
  }

  set leverage(double? value) {
    setState(state.copyWith(leverage: value));
  }

  set positionSize(double? value) {
    late MatexForexRequiredMarginCalculatorState nextState;

    if (value == null) {
      nextState = state.copyWithDefaults(resetPositionSize: true);
    } else {
      nextState = state.copyWith(positionSize: value);
    }

    setState(nextState);
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

  static const defaultResults = MatexForexRequiredMarginCalculatorResults(
    requiredMargin: 0,
  );

  @override
  MatexForexRequiredMarginCalculatorResults value() {
    if (!isValid) return defaultResults;

    return MatexForexRequiredMarginCalculatorResults(
      requiredMargin: computeRequiredMargin(
        counterToAccountCurrencyRate: state.counterToAccountCurrencyRate,
        isAccountCurrencyCounter: state.isAccountCurrencyCounter,
        isAccountCurrencyBase: state.isAccountCurrencyBase,
        instrumentPairRate: state.instrumentPairRate,
        positionSize: state.positionSize,
        leverage: state.leverage,
      ),
    );
  }

  double computeRequiredMargin({
    bool isAccountCurrencyCounter = false,
    double? counterToAccountCurrencyRate,
    bool isAccountCurrencyBase = false,
    double? instrumentPairRate,
    double? positionSize,
    double? leverage,
  }) {
    counterToAccountCurrencyRate ??= 0;
    instrumentPairRate ??= 0;
    positionSize ??= 0;
    leverage ??= 0;

    if (leverage == 0) return 0;

    // Calculate the required margin
    if (isAccountCurrencyBase) {
      return positionSize / leverage;
    } else if (isAccountCurrencyCounter) {
      return positionSize * instrumentPairRate / leverage;
    }

    final multiplier = instrumentPairRate / leverage;

    return positionSize * multiplier * counterToAccountCurrencyRate;
  }
}
