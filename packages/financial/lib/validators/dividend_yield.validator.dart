// Package imports
import 'package:matex_core/core.dart';
// Project imports
import 'package:matex_financial/financial.dart';

List<MatexCalculatorValidator<DividendYieldCalculatorState>>
    dividendYieldValidators = [
  (state) => state.sharePrice != null && state.totalDividend != null,
  (state) => state.sharePrice! > 0 && state.totalDividend! > 0,
];
