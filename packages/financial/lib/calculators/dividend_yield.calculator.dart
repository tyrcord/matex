// Package imports:
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';

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
  double? get totalDividend => state.totalDividends;
  MatexFinancialFrequency get paymentFrequency => state.paymentFrequency;

  // Setters
  set sharePrice(double? value) {
    setState(state.copyWith(sharePrice: value));
  }

  set totalDividend(double? value) {
    setState(state.copyWith(totalDividends: value));
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

    final dSharePrice = toDecimal(state.sharePrice) ?? dZero;
    final dDividendAmount = toDecimal(state.totalDividends) ?? dZero;

    final dFrequency =
        toDecimal(getPaymentFrequency(state.paymentFrequency)) ?? dZero;

    if (dSharePrice == dZero) return defaultResults;

    final dDividendYield = decimalFromRational(
      (dDividendAmount * dFrequency) / dSharePrice,
    );

    return MatexDividendYieldResultsModel(
      dividendYield: dDividendYield.toDouble(),
    );
  }
}
