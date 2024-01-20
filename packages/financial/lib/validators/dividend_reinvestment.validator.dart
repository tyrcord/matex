// Package imports

// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

// Project imports

List<MatexCalculatorValidator<MatexDividendReinvestmentCalculatorState>>
    dividendReinvestmentValidators = [
  (state) {
    return state.numberOfShares != null &&
        state.dividendYield != null &&
        state.yearsToGrow != null &&
        state.sharePrice != null;
  },
  (state) {
    return state.numberOfShares! > 0 &&
        state.dividendYield! > 0 &&
        state.yearsToGrow! > 0 &&
        state.yearsToGrow! <= 100 &&
        state.sharePrice! > 0;
  },
  (state) {
    if (state.taxRate != null) {
      return state.taxRate! >= 0 && state.taxRate! <= 1;
    }

    return true;
  },
  (state) {
    if (state.annualSharePriceIncrease != null) {
      return state.annualSharePriceIncrease! >= 0 &&
          state.annualSharePriceIncrease! <= 1;
    }

    return true;
  },
  (state) {
    if (state.annualDividendIncrease != null) {
      return state.annualDividendIncrease! >= 0 &&
          state.annualDividendIncrease! <= 1;
    }

    return true;
  },
  (state) {
    if (state.annualContribution != null) {
      return state.annualContribution! >= 0;
    }

    return true;
  },
];
