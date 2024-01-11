// Package imports
import 'package:matex_core/core.dart';
// Project imports
import 'package:matex_financial/financial.dart';
import 'package:tenhance/tenhance.dart';

final List<MatexCalculatorValidator<MatexCompoundInterestCalculatorState>>
    compoundInterestValidators = [
  (state) => state.compoundFrequency >= state.rateFrequency,
  (state) => state.contributionFrequency >= state.rateFrequency,
  (state) => state.withdrawalFrequency >= state.rateFrequency,
  (state) => state.startBalance != null && state.startBalance! > 0,
  (state) => state.rate != null && state.rate! > 0,
  (state) =>
      state.duration != null && state.duration! > 0 && state.duration! <= 100,
];
