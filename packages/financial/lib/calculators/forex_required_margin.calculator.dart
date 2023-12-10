import 'package:decimal/decimal.dart';
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

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
  double? get instrumentPairRate => state.instrumentPairRate;
  int? get pipDecimalPlaces => state.pipDecimalPlaces;
  double? get positionSize => state.positionSize;
  double? get leverage => state.leverage;

  double? get counterToAccountCurrencyRate {
    return state.counterToAccountCurrencyRate;
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
        instrumentPairRate: state.instrumentPairRate,
        positionSize: state.positionSize,
        leverage: state.leverage,
      ).toDouble(),
    );
  }

  Decimal computeRequiredMargin({
    bool isAccountCurrencyCounter = false,
    double? counterToAccountCurrencyRate,
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
    if (!isAccountCurrencyCounter) {
      final dMultiplier = decimalFromRational(dInstrumentPairRate / dLeverage);
      final dRate = dCounterToAccountCurrencyRate > dZero
          ? dCounterToAccountCurrencyRate
          : dOne;

      return dPositionSize * dMultiplier * dRate;
    }

    return decimalFromRational(dPositionSize * dInstrumentPairRate / dLeverage);
  }
}
