// Package imports
import 'package:matex_core/core.dart';
// Project imports
import 'package:matex_financial/financial.dart';

final List<MatexCalculatorValidator<MatexForexProfitLossCalculatorState>>
    forexProfitAndLossValidators = [
  isMandadoryFieldsNotNull,
  isMandadoryFieldsValid,
];

// Validator: Check if the position size is not null
bool isMandadoryFieldsNotNull(MatexForexProfitLossCalculatorState state) {
  return state.positionSize != null &&
      state.positionSize != null &&
      state.entryPrice != null &&
      state.exitPrice != null;
}

// Validator: Check if both position size and instrument pair rate are valid
bool isMandadoryFieldsValid(
  MatexForexProfitLossCalculatorState state,
) {
  return state.positionSize! > 0 &&
      state.instrumentPairRate > 0 &&
      state.entryPrice! > 0 &&
      state.exitPrice! >= 0 &&
      state.positionSize! > 0;
}
