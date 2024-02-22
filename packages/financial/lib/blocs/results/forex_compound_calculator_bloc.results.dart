// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexCompoundCalculatorBlocResults extends FastCalculatorResults {
  final List<MatexCompoundInterestBreakdownEntry>? breakdown;
  final double totalEarnings;
  final double totalContributions;
  final double totalWithdrawals;
  final double startBalance;
  final double endBalance;
  final double rateOfReturn;
  final double effectiveAnnualRate;
  final int monthsToDoubleInvestment;

  // Formatted properties
  final String? formattedTotalEarnings;
  final String? formattedTotalContributions;
  final String? formattedTotalWithdrawals;
  final String? formattedStartBalance;
  final String? formattedEndBalance;
  final String? formattedRateOfReturn;
  final String? formattedEffectiveAnnualRate;
  final String? formattedTimeToDoubleInvestment;

  const MatexForexCompoundCalculatorBlocResults({
    this.breakdown,
    this.totalEarnings = 0,
    this.totalContributions = 0,
    this.totalWithdrawals = 0,
    this.startBalance = 0,
    this.endBalance = 0,
    this.rateOfReturn = 0,
    this.effectiveAnnualRate = 0,
    this.monthsToDoubleInvestment = 0,
    this.formattedTotalEarnings,
    this.formattedTotalContributions,
    this.formattedTotalWithdrawals,
    this.formattedStartBalance,
    this.formattedEndBalance,
    this.formattedRateOfReturn,
    this.formattedEffectiveAnnualRate,
    this.formattedTimeToDoubleInvestment,
  });

  @override
  MatexForexCompoundCalculatorBlocResults clone() => copyWith();

  @override
  MatexForexCompoundCalculatorBlocResults copyWith({
    List<MatexCompoundInterestBreakdownEntry>? breakdown,
    double? totalEarnings,
    double? totalContributions,
    double? totalWithdrawals,
    double? startBalance,
    double? endBalance,
    double? rateOfReturn,
    double? effectiveAnnualRate,
    int? monthsToDoubleInvestment,
    String? formattedTotalEarnings,
    String? formattedTotalContributions,
    String? formattedTotalWithdrawals,
    String? formattedStartBalance,
    String? formattedEndBalance,
    String? formattedRateOfReturn,
    String? formattedEffectiveAnnualRate,
    String? formattedTimeToDoubleInvestment,
  }) {
    return MatexForexCompoundCalculatorBlocResults(
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
      formattedTotalEarnings:
          formattedTotalEarnings ?? this.formattedTotalEarnings,
      formattedTotalContributions:
          formattedTotalContributions ?? this.formattedTotalContributions,
      formattedTotalWithdrawals:
          formattedTotalWithdrawals ?? this.formattedTotalWithdrawals,
      formattedStartBalance:
          formattedStartBalance ?? this.formattedStartBalance,
      formattedEndBalance: formattedEndBalance ?? this.formattedEndBalance,
      formattedRateOfReturn:
          formattedRateOfReturn ?? this.formattedRateOfReturn,
      formattedEffectiveAnnualRate:
          formattedEffectiveAnnualRate ?? this.formattedEffectiveAnnualRate,
      formattedTimeToDoubleInvestment: formattedTimeToDoubleInvestment ??
          this.formattedTimeToDoubleInvestment,
    );
  }

  @override
  MatexForexCompoundCalculatorBlocResults merge(
    covariant MatexForexCompoundCalculatorBlocResults model,
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
      formattedTotalEarnings: model.formattedTotalEarnings,
      formattedTotalContributions: model.formattedTotalContributions,
      formattedTotalWithdrawals: model.formattedTotalWithdrawals,
      formattedStartBalance: model.formattedStartBalance,
      formattedEndBalance: model.formattedEndBalance,
      formattedRateOfReturn: model.formattedRateOfReturn,
      formattedEffectiveAnnualRate: model.formattedEffectiveAnnualRate,
      formattedTimeToDoubleInvestment: model.formattedTimeToDoubleInvestment,
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
        formattedTotalEarnings,
        formattedTotalContributions,
        formattedTotalWithdrawals,
        formattedStartBalance,
        formattedEndBalance,
        formattedRateOfReturn,
        formattedEffectiveAnnualRate,
        formattedTimeToDoubleInvestment,
      ];
}
