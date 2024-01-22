// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexDividendPayoutRatioCalculator extends MatexCalculator<
    MatexDividendPayoutRatioCalculatorState,
    MatexDividendPayoutRatioCalculatorResults> {
  MatexDividendPayoutRatioCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: dividendPayoutRatioValidators);

  @override
  MatexDividendPayoutRatioCalculatorState initializeState() =>
      const MatexDividendPayoutRatioCalculatorState();

  @override
  MatexDividendPayoutRatioCalculatorState initializeDefaultState() =>
      initializeState();

  double? get netIncome => state.netIncome;

  set netIncome(double? value) {
    setState(state.copyWith(netIncome: value));
  }

  double? get totalDividends => state.totalDividends;

  set totalDividends(double? value) {
    setState(state.copyWith(totalDividends: value));
  }

  static const defaultResults = MatexDividendPayoutRatioCalculatorResults(
    dividendPayoutRatio: 0,
  );

  @override
  MatexDividendPayoutRatioCalculatorResults value() {
    if (!isValid) return defaultResults;

    final totalDividends = state.totalDividends ?? 0;
    final netIncome = state.netIncome ?? 0;

    if (netIncome == 0) return defaultResults;

    return MatexDividendPayoutRatioCalculatorResults(
      dividendPayoutRatio: totalDividends / netIncome,
    );
  }
}
