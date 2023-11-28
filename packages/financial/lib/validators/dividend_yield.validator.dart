// Package imports
import 'package:matex_core/core.dart';
// Project imports
import 'package:matex_financial/financial.dart';

List<MatexCalculatorValidator<MatexDividendYieldCalculatorState>>
    dividendYieldValidators = [
  (state) => state.sharePrice != null && state.totalDividends != null,
  (state) => state.sharePrice! > 0 && state.totalDividends! > 0,
];
