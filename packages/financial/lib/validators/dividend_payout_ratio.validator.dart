// Package imports
import 'package:matex_core/core.dart';
// Project imports
import 'package:matex_financial/financial.dart';

final List<MatexCalculatorValidator<MatexDividendPayoutRatioCalculatorState>>
    dividendPayoutRatioValidators = [
  (state) => state.netIncome != null && state.totalDividends != null,
  (state) => state.netIncome! > 0 && state.totalDividends! > 0,
];
