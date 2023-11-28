import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';
import 'package:matex_financial/financial.dart';

class MatexDividendPayoutRatioCalculator extends MatexCalculator<
    DividendPayoutRatioCalculatorState, DividendPayoutRatioCalculatorResults> {
  MatexDividendPayoutRatioCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: dividendPayoutRatioValidators);

  @override
  DividendPayoutRatioCalculatorState initializeState() =>
      const DividendPayoutRatioCalculatorState();

  @override
  DividendPayoutRatioCalculatorState initializeDefaultState() =>
      initializeState();

  double? get netIncome => state.netIncome;

  set netIncome(double? value) {
    setState(state.copyWith(netIncome: value));
  }

  double? get totalDividend => state.totalDividend;

  set totalDividend(double? value) {
    setState(state.copyWith(totalDividends: value));
  }

  static const defaultResults = DividendPayoutRatioCalculatorResults(
    dividendPayoutRatio: 0,
  );

  @override
  DividendPayoutRatioCalculatorResults value() {
    if (!isValid) return defaultResults;

    final dTotalDividend = toDecimal(state.totalDividend) ?? dZero;
    final dNetIncome = toDecimal(state.netIncome) ?? dZero;

    if (dNetIncome == dZero) return defaultResults;

    final dDividendPayoutRatio =
        decimalFromRational(dTotalDividend / dNetIncome);

    return DividendPayoutRatioCalculatorResults(
      dividendPayoutRatio: dDividendPayoutRatio.toDouble(),
    );
  }
}
