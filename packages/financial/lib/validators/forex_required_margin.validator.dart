// Package imports

// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

// Project imports

// Validators for forex pip value calculation
final List<MatexCalculatorValidator<MatexForexRequiredMarginCalculatorState>>
    forexRequiredMarginValidators = [
  _isPositionSizeNotNull,
  _isPositionSizeAndInstrumentPairRateValid,
  _isLeverageValid,
];

// Validator: Check if the position size is not null
bool _isPositionSizeNotNull(MatexForexRequiredMarginCalculatorState state) {
  return state.positionSize != null;
}

// Validator: Check if both position size and instrument pair rate are valid
bool _isPositionSizeAndInstrumentPairRateValid(
  MatexForexRequiredMarginCalculatorState state,
) {
  return state.positionSize! > 0 && state.instrumentPairRate > 0;
}

bool _isLeverageValid(MatexForexRequiredMarginCalculatorState state) {
  return state.leverage > 0;
}
