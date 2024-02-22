// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexCompoundInterestCalculatorResults extends FastCalculatorResults {
  final int monthsToDoubleInvestment;
  final List<MatexCompoundInterestBreakdownEntry>? breakdown;
  final double totalEarnings;
  final double totalContributions;
  final double totalWithdrawals;
  final double startBalance;
  final double endBalance;
  final double rateOfReturn;
  final double effectiveAnnualRate;

  const MatexCompoundInterestCalculatorResults({
    this.breakdown,
    this.totalEarnings = 0,
    this.totalContributions = 0,
    this.totalWithdrawals = 0,
    this.startBalance = 0,
    this.endBalance = 0,
    this.rateOfReturn = 0,
    this.effectiveAnnualRate = 0,
    this.monthsToDoubleInvestment = 0,
  });

  @override
  MatexCompoundInterestCalculatorResults clone() => copyWith();

  @override
  MatexCompoundInterestCalculatorResults copyWith({
    List<MatexCompoundInterestBreakdownEntry>? breakdown,
    double? totalEarnings,
    double? totalContributions,
    double? totalWithdrawals,
    double? startBalance,
    double? endBalance,
    double? rateOfReturn,
    double? effectiveAnnualRate,
    int? monthsToDoubleInvestment,
  }) {
    return MatexCompoundInterestCalculatorResults(
      breakdown: breakdown ?? this.breakdown,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      totalContributions: totalContributions ?? this.totalContributions,
      totalWithdrawals: totalWithdrawals ?? this.totalWithdrawals,
      startBalance: startBalance ?? this.startBalance,
      endBalance: endBalance ?? this.endBalance,
      rateOfReturn: rateOfReturn ?? this.rateOfReturn,
      effectiveAnnualRate: effectiveAnnualRate ?? this.effectiveAnnualRate,
      monthsToDoubleInvestment:
          monthsToDoubleInvestment ?? this.monthsToDoubleInvestment,
    );
  }

  @override
  MatexCompoundInterestCalculatorResults merge(
    covariant MatexCompoundInterestCalculatorResults model,
  ) {
    return copyWith(
      breakdown: model.breakdown,
      totalEarnings: model.totalEarnings,
      totalContributions: model.totalContributions,
      totalWithdrawals: model.totalWithdrawals,
      startBalance: model.startBalance,
      endBalance: model.endBalance,
      rateOfReturn: model.rateOfReturn,
      effectiveAnnualRate: model.effectiveAnnualRate,
      monthsToDoubleInvestment: model.monthsToDoubleInvestment,
    );
  }

  @override
  List<Object?> get props => [
        breakdown,
        totalEarnings,
        totalContributions,
        totalWithdrawals,
        startBalance,
        endBalance,
        rateOfReturn,
        effectiveAnnualRate,
        monthsToDoubleInvestment,
      ];
}
