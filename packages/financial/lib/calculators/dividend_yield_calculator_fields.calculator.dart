// Package imports:
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class DividendYieldCalculatorFields extends MatexCalculator<
    DividendYieldCalculatorState, DividendYieldResultsModel> {
  DividendYieldCalculatorFields({
    super.defaultState,
    super.state,
  }) : super(validators: dividendYieldValidators);

  @override
  DividendYieldCalculatorState initializeState() =>
      const DividendYieldCalculatorState();

  @override
  DividendYieldCalculatorState initializeDefaultState() => initializeState();

  // Properties
  double? get sharePrice => state.sharePrice;
  double? get totalDividend => state.totalDividend;
  MatexFinancialFrequency get dividendPaymentFrequency =>
      state.dividendPaymentFrequency;

  // Setters
  set sharePrice(double? value) {
    setState(state.copyWith(sharePrice: value));
  }

  set totalDividend(double? value) {
    setState(state.copyWith(totalDividend: value));
  }

  set dividendPaymentFrequency(MatexFinancialFrequency value) {
    setState(state.copyWith(dividendPaymentFrequency: value));
  }

  // Default Results
  static const defaultResults = DividendYieldResultsModel(
    dividendYield: 0,
  );

  @override
  DividendYieldResultsModel value() {
    if (!isValid) return defaultResults;

    final dSharePrice = toDecimal(state.sharePrice) ?? dZero;
    final dDividendAmount = toDecimal(state.totalDividend) ?? dZero;

    final dFrequency =
        toDecimal(getPaymentFrequency(state.dividendPaymentFrequency)) ?? dZero;

    if (dSharePrice == dZero) return defaultResults;

    final dDividendYield = decimalFromRational(
      (dDividendAmount * dFrequency) / dSharePrice,
    );

    return DividendYieldResultsModel(
      dividendYield: dDividendYield.toDouble(),
    );
  }
}
