// Package imports
import 'package:matex_core/core.dart';
// Project imports
import 'package:matex_financial/financial.dart';

List<MatexCalculatorValidator<MatexDividendYieldCalculatorState>>
    dividendYieldValidators = [
  (state) => state.sharePrice != null && state.dividendAmount != null,
  (state) => state.sharePrice! > 0 && state.dividendAmount! > 0,
];
