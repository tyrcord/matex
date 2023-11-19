// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

final List<MatexCalculatorValidator<MatexForexPositionSizeCalculatorState>>
    forexPositionSizeValidators = [
  (state) => state.instrumentPairRate > 0,
  (state) =>
      (state.riskAmount != null && state.riskAmount! > 0) ||
      (state.riskPercent != null &&
          state.accountSize != null &&
          state.riskPercent! > 0 &&
          state.accountSize! > 0),
  (state) {
    final riskAmount = state.riskAmount;
    final accountSize = state.accountSize;

    if (riskAmount != null && riskAmount > 0) {
      if (accountSize != null && accountSize > 0) {
        return riskAmount <= accountSize;
      }

      return true;
    }

    final riskPercent = state.riskPercent!;

    if (riskPercent > 0 && accountSize! > 0) {
      return riskPercent > 0 && riskPercent <= 1;
    }

    return false;
  },
];
