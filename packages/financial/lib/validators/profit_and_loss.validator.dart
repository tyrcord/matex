// Package imports
import 'package:matex_core/core.dart';
// Project imports
import 'package:matex_financial/financial.dart';

// Validators for profit and loss calculation
final List<MatexCalculatorValidator<MatexProfitAndLossCalculatorState>>
    profitAndLossValidators = [
  isBuyingPriceValid,
  isSellingPriceValid,
  areExpectedSaleUnitsValid,
  isSellingPriceGreaterThanBuyingPrice,
];

// Validator: Check if the buying price is valid
bool isBuyingPriceValid(MatexProfitAndLossCalculatorState state) {
  return state.buyingPrice != null && state.buyingPrice! > 0;
}

// Validator: Check if the selling price is valid
bool isSellingPriceValid(MatexProfitAndLossCalculatorState state) {
  return state.sellingPrice != null && state.sellingPrice! > 0;
}

// Validator: Check if the expected sale units are valid
bool areExpectedSaleUnitsValid(MatexProfitAndLossCalculatorState state) {
  return state.expectedSaleUnits != null && state.expectedSaleUnits! > 0;
}

// Validator: Ensure that the selling price is greater than the buying price
bool isSellingPriceGreaterThanBuyingPrice(
  MatexProfitAndLossCalculatorState state,
) {
  return state.sellingPrice! > state.buyingPrice!;
}
