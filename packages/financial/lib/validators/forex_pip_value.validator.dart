// Package imports
import 'package:matex_core/core.dart';
// Project imports
import 'package:matex_financial/financial.dart';

// Validators for forex pip value calculation
final List<MatexCalculatorValidator<MatexForexPipValueCalculatorState>>
    pipValueValidators = [
  isPositionSizeNotNull,
  isPositionSizeAndInstrumentPairRateValid,
];

// Validator: Check if the position size is not null
bool isPositionSizeNotNull(MatexForexPipValueCalculatorState state) {
  return state.positionSize != null;
}

// Validator: Check if both position size and instrument pair rate are valid
bool isPositionSizeAndInstrumentPairRateValid(
  MatexForexPipValueCalculatorState state,
) {
  return state.positionSize! > 0 && state.instrumentPairRate > 0;
}
