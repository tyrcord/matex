// Package imports:
import 'package:decimal/decimal.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';
import 'package:tenhance/decimal.dart';

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
      ).toSafeDouble(),
    );
  }

  Decimal computeRequiredMargin({
    bool isAccountCurrencyCounter = false,
    double? counterToAccountCurrencyRate,
    bool isAccountCurrencyBase = false,
    double? instrumentPairRate,
    double? positionSize,
    double? leverage,
  }) {
    final dInstrumentPairRate = toDecimalOrDefault(instrumentPairRate);
    final dPositionSize = toDecimalOrDefault(positionSize);
    final dLeverage = toDecimalOrDefault(leverage);
    final dCounterToAccountCurrencyRate =
        toDecimalOrDefault(counterToAccountCurrencyRate);

    if (dLeverage == dZero) return dZero;

    // Calculate the required margin
    if (isAccountCurrencyBase) {
      return decimalFromRational(dPositionSize / dLeverage);
    } else if (isAccountCurrencyCounter) {
      return decimalFromRational(
        dPositionSize * dInstrumentPairRate / dLeverage,
      );
    }

    final dMultiplier = decimalFromRational(dInstrumentPairRate / dLeverage);

    return dPositionSize * dMultiplier * dCounterToAccountCurrencyRate;
  }
}
