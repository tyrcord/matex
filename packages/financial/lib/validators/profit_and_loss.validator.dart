import 'package:matex_financial/financial.dart';
import 'package:matex_core/core.dart';

List<MatexCalculatorValidator<MatexProfitAndLossCalculatorState>>
    profitAndLossValidators = [
  (state) => state.buyingPrice != null && state.buyingPrice! > 0,
  (state) => state.sellingPrice != null && state.sellingPrice! > 0,
  (state) => state.expectedSaleUnits != null && state.expectedSaleUnits! > 0,
  (state) => state.sellingPrice! > state.buyingPrice!,
];
