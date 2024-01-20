// Package imports

// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

// Project imports

// Validators for stock position size calculation
final List<MatexCalculatorValidator<MatexStockPositionSizeCalculatorState>>
    stockPositionSizeValidators = [
  isAccountSizeValid,
  isEntryPriceValid,
  isStopLossPriceValidForPosition,
  isRiskPercentOrStopLossAmountValid,
  areEntryExitFeesAndSlippagePercentValid,
];

// Validator: Check if the account size is valid
bool isAccountSizeValid(MatexStockPositionSizeCalculatorState state) {
  return state.accountSize != null && state.accountSize! > 0;
}

// Validator: Check if the entry price is valid
bool isEntryPriceValid(MatexStockPositionSizeCalculatorState state) {
  return state.entryPrice != null && state.entryPrice! > 0;
}

// Validator: Check if the stop loss price is valid for the position type
bool isStopLossPriceValidForPosition(
  MatexStockPositionSizeCalculatorState state,
) {
  if (state.isShortPosition) {
    return state.stopLossPrice != null &&
        state.stopLossPrice! > 0 &&
        state.stopLossPrice! > state.entryPrice!;
  }

  return state.stopLossPrice != null &&
      state.stopLossPrice! > 0 &&
      state.stopLossPrice! < state.entryPrice!;
}

// Validator: Check if the risk percent or stop loss amount is valid
bool isRiskPercentOrStopLossAmountValid(
  MatexStockPositionSizeCalculatorState state,
) {
  if (state.riskPercent != null &&
      state.riskPercent! > 0 &&
      state.riskPercent! <= 1) {
    return true;
  } else if (state.stopLossAmount != null &&
      state.stopLossAmount! > 0 &&
      state.stopLossAmount! <= state.accountSize!) {
    return true;
  }

  return false;
}

// Validator: Ensure that entry fees, exit fees, and slippage percent are valid
bool areEntryExitFeesAndSlippagePercentValid(
  MatexStockPositionSizeCalculatorState state,
) {
  return (state.entryFees == null || state.entryFees! < 1) &&
      (state.exitFees == null || state.exitFees! < 1) &&
      (state.slippagePercent == null || state.slippagePercent! < 1);
}
