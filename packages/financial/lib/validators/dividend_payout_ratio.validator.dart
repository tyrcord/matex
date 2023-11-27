// Package imports
import 'package:matex_core/core.dart';
// Project imports
import 'package:matex_financial/financial.dart';

final List<MatexCalculatorValidator<DividendPayoutRatioCalculatorState>>
    dividendPayoutRatioValidators = [
  (state) => state.netIncome != null && state.totalDividend != null,
  (state) => state.netIncome! > 0 && state.totalDividend! > 0,
];
