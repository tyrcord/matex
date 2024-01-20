// Package imports:
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';
import 'package:tenhance/decimal.dart';

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

    final dTotalDividend = toDecimal(state.totalDividends) ?? dZero;
    final dNetIncome = toDecimal(state.netIncome) ?? dZero;

    if (dNetIncome == dZero) return defaultResults;

    final dDividendPayoutRatio =
        decimalFromRational(dTotalDividend / dNetIncome);

    return MatexDividendPayoutRatioCalculatorResults(
      dividendPayoutRatio: dDividendPayoutRatio.toSafeDouble(),
    );
  }
}
