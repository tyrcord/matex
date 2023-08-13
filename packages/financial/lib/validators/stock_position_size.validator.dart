import 'package:matex_financial/financial.dart';
import 'package:matex_core/core.dart';

List<MatexCalculatorValidator<MatexStockPositionSizeCalculatorState>>
    stockPositionSizeValidators = [
  // Account size must be greater than 0
  (state) => state.accountSize != null && state.accountSize! > 0,

  // Entry price must be greater than 0
  (state) => state.entryPrice != null && state.entryPrice! > 0,

  // Stop loss price must be greater than 0 and less than entry price
  (state) {
    return state.stopLossPrice != null &&
        state.stopLossPrice! > 0 &&
        state.stopLossPrice! < state.entryPrice!;
  },

  // Risk percent must be greater than 0 and less than 100
  // Or stop loss amount must be greater than 0 and less than account size
  (state) {
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
  },

  // Entry fees must be greater than or equal to 0 and less than 100
  // Exit fees must be greater than or equal to 0 and less than 100
  // Slippage percent must be greater than or equal to 0 and less than 100
  (state) {
    if ((state.entryFees != null && state.entryFees! >= 1) ||
        (state.exitFees != null && state.exitFees! >= 1) ||
        (state.slippagePercent != null && state.slippagePercent! >= 1)) {
      return false;
    }

    return true;
  },
];
