// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexDividendYieldCalculator extends MatexCalculator<
    MatexDividendYieldCalculatorState, MatexDividendYieldResultsModel> {
  MatexDividendYieldCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: dividendYieldValidators);

  @override
  MatexDividendYieldCalculatorState initializeState() =>
      const MatexDividendYieldCalculatorState();

  @override
  MatexDividendYieldCalculatorState initializeDefaultState() =>
      initializeState();

  // Properties
  double? get sharePrice => state.sharePrice;
  double? get dividendAmount => state.dividendAmount;
  MatexFinancialFrequency get paymentFrequency => state.paymentFrequency;

  // Setters
  set sharePrice(double? value) {
    setState(state.copyWith(sharePrice: value));
  }

  set dividendAmount(double? value) {
    setState(state.copyWith(dividendAmount: value));
  }

  set paymentFrequency(MatexFinancialFrequency value) {
    setState(state.copyWith(paymentFrequency: value));
  }

  // Default Results
  static const defaultResults = MatexDividendYieldResultsModel(
    dividendYield: 0,
  );

  @override
  MatexDividendYieldResultsModel value() {
    if (!isValid) return defaultResults;

    final dSharePrice = state.sharePrice ?? 0.0;

    if (dSharePrice == 0) return defaultResults;

    final paymentFrequency = getPaymentFrequency(state.paymentFrequency);
    final dDividendAmount = state.dividendAmount ?? 0;
    final dTotalDividends = dDividendAmount * paymentFrequency;
    final dDividendYield = (dTotalDividends / dSharePrice);

    return MatexDividendYieldResultsModel(
      totalDividends: dTotalDividends,
      dividendYield: dDividendYield,
      sharePrice: dSharePrice,
    );
  }
}
