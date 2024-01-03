// Package imports:
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexCompoundInterestCalculatorState extends MatexCalculatorState {
  static const defaultFrequency = MatexFinancialFrequency.monthly;

  final double? startBalance;
  final double? rate;
  final int? duration;
  final MatexFinancialFrequency contributionFrequency;
  final MatexFinancialFrequency compoundFrequency;
  final MatexFinancialFrequency withdrawalFrequency;
  final MatexFinancialFrequency rateFrequency;
  final double? withdrawalAmount;
  final double? additionalContribution;

  const MatexCompoundInterestCalculatorState({
    this.startBalance,
    this.rate,
    this.withdrawalAmount,
    this.additionalContribution,
    this.duration,
    MatexFinancialFrequency? contributionFrequency,
    MatexFinancialFrequency? compoundFrequency,
    MatexFinancialFrequency? withdrawalFrequency,
    MatexFinancialFrequency? rateFrequency,
  })  : contributionFrequency =
            contributionFrequency ?? rateFrequency ?? defaultFrequency,
        compoundFrequency =
            compoundFrequency ?? rateFrequency ?? defaultFrequency,
        withdrawalFrequency =
            withdrawalFrequency ?? rateFrequency ?? defaultFrequency,
        rateFrequency = rateFrequency ?? defaultFrequency;

  @override
  MatexCompoundInterestCalculatorState clone() => copyWith();

  @override
  MatexCompoundInterestCalculatorState copyWith({
    double? startBalance,
    double? rate,
    int? duration,
    MatexFinancialFrequency? contributionFrequency,
    MatexFinancialFrequency? compoundFrequency,
    MatexFinancialFrequency? withdrawalFrequency,
    MatexFinancialFrequency? rateFrequency,
    double? withdrawalAmount,
    double? additionalContribution,
  }) {
    return MatexCompoundInterestCalculatorState(
      startBalance: startBalance ?? this.startBalance,
      rate: rate ?? this.rate,
      duration: duration ?? this.duration,
      contributionFrequency:
          contributionFrequency ?? this.contributionFrequency,
      compoundFrequency: compoundFrequency ?? this.compoundFrequency,
      withdrawalFrequency: withdrawalFrequency ?? this.withdrawalFrequency,
      rateFrequency: rateFrequency ?? this.rateFrequency,
      withdrawalAmount: withdrawalAmount ?? this.withdrawalAmount,
      additionalContribution:
          additionalContribution ?? this.additionalContribution,
    );
  }

  @override
  MatexCompoundInterestCalculatorState merge(
    covariant MatexCompoundInterestCalculatorState model,
  ) {
    return copyWith(
      startBalance: model.startBalance,
      rate: model.rate,
      duration: model.duration,
      contributionFrequency: model.contributionFrequency,
      compoundFrequency: model.compoundFrequency,
      withdrawalFrequency: model.withdrawalFrequency,
      rateFrequency: model.rateFrequency,
      withdrawalAmount: model.withdrawalAmount,
      additionalContribution: model.additionalContribution,
    );
  }

  @override
  List<Object?> get props => [
        startBalance,
        rate,
        duration,
        contributionFrequency,
        compoundFrequency,
        withdrawalFrequency,
        rateFrequency,
        withdrawalAmount,
        additionalContribution,
      ];
}
