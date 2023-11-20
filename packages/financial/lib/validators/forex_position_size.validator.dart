// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

final List<MatexCalculatorValidator<MatexForexPositionSizeCalculatorState>>
    forexPositionSizeValidators = [
  isInstrumentPairRateValid,
  isRiskAmountOrPercentValid,
  isRiskWithinAccountLimits,
];

// Validator: Check if the instrument pair rate is valid
bool isInstrumentPairRateValid(MatexForexPositionSizeCalculatorState state) {
  return state.instrumentPairRate > 0;
}

// Validator: Check if either the risk amount or percent is valid
bool isRiskAmountOrPercentValid(MatexForexPositionSizeCalculatorState state) {
  return (state.riskAmount != null && state.riskAmount! > 0) ||
      (state.riskPercent != null &&
          state.accountSize != null &&
          state.riskPercent! > 0 &&
          state.accountSize! > 0);
}

// Validator: Ensure that the risk amount/percent is within account limits
bool isRiskWithinAccountLimits(MatexForexPositionSizeCalculatorState state) {
  if (state.riskAmount != null && state.riskAmount! > 0) {
    return isRiskAmountWithinAccountSize(state);
  }

  return isRiskPercentWithinRange(state);
}

// Helper: Check if risk amount does not exceed account size
bool isRiskAmountWithinAccountSize(
  MatexForexPositionSizeCalculatorState state,
) {
  if (state.accountSize != null && state.accountSize! > 0) {
    return state.riskAmount! <= state.accountSize!;
  }

  return true;
}

// Helper: Check if risk percent is within the valid range (0-1)
bool isRiskPercentWithinRange(MatexForexPositionSizeCalculatorState state) {
  final riskPercent = state.riskPercent!;

  return riskPercent > 0 && riskPercent <= 1;
}
