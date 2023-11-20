// Package imports
import 'package:matex_core/core.dart';
// Project imports
import 'package:matex_financial/financial.dart';

// Validators for VAT calculation
final List<MatexCalculatorValidator<MatexVatCalculatorState>> vatValidators = [
  isPriceBeforeVatValid,
  isVatRateValid,
  isDiscountAmountValid,
  isDiscountRateValid,
];

// Validator: Check if the price before VAT is valid
bool isPriceBeforeVatValid(MatexVatCalculatorState state) {
  return state.priceBeforeVat != null && state.priceBeforeVat! > 0;
}

// Validator: Check if any VAT rate (general, federal, regional) is valid
bool isVatRateValid(MatexVatCalculatorState state) {
  return (state.vatRate != null && state.vatRate! > 0 && state.vatRate! < 1) ||
      (state.federalVatRate != null &&
          state.federalVatRate! > 0 &&
          state.federalVatRate! < 1) ||
      (state.regionalVatRate != null &&
          state.regionalVatRate! > 0 &&
          state.regionalVatRate! < 1);
}

// Validator: Ensure that the discount amount is valid
bool isDiscountAmountValid(MatexVatCalculatorState state) {
  return state.discountAmount == null ||
      (state.discountAmount! < state.priceBeforeVat! &&
          state.discountAmount! >= 0);
}

// Validator: Ensure that the discount rate is valid
bool isDiscountRateValid(MatexVatCalculatorState state) {
  return state.discountRate == null ||
      (state.discountRate! < 1 && state.discountRate! >= 0);
}
