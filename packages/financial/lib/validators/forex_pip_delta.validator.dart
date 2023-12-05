// Package imports
import 'package:matex_core/core.dart';
// Project imports
import 'package:matex_financial/financial.dart';

final List<MatexCalculatorValidator<MatexForexPipDeltaCalculatorState>>
    forexPipDeltaValidators = [
  _validatePipDecimalPlaces,
  _validatePositivePrices,
];

// Validates that pip decimal places are non-negative
bool _validatePipDecimalPlaces(MatexForexPipDeltaCalculatorState state) {
  final pipDecimalPlaces = state.pipDecimalPlaces;

  return pipDecimalPlaces >= 0;
}

// Validates that prices are positive
bool _validatePositivePrices(MatexForexPipDeltaCalculatorState state) {
  final priceA = state.priceA;
  final priceB = state.priceB;

  return (priceA != null && priceA > 0) || (priceB != null && priceB > 0);
}
