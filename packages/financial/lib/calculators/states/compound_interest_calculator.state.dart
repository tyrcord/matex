// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
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

  Map<String, dynamic> toJson() {
    return {
      'startBalance': startBalance,
      'rate': rate,
      'duration': duration,
      'contributionFrequency': contributionFrequency.name,
      'compoundFrequency': compoundFrequency.name,
      'withdrawalFrequency': withdrawalFrequency.name,
      'rateFrequency': rateFrequency.name,
      'withdrawalAmount': withdrawalAmount,
      'additionalContribution': additionalContribution,
    };
  }

  factory MatexCompoundInterestCalculatorState.fromJson(
    Map<String, dynamic> json,
  ) {
    final contributionFrequency = MatexFinancialFrequencyX.fromName(
      json['contributionFrequency'] as String?,
    );

    final rateFrequency = MatexFinancialFrequencyX.fromName(
      json['rateFrequency'] as String?,
    );

    final withdrawalFrequency = MatexFinancialFrequencyX.fromName(
      json['withdrawalFrequency'] as String?,
    );

    final compoundFrequency = MatexFinancialFrequencyX.fromName(
      json['compoundFrequency'] as String?,
    );

    return MatexCompoundInterestCalculatorState(
      additionalContribution: json['additionalContribution'] as double?,
      contributionFrequency: contributionFrequency ?? defaultFrequency,
      withdrawalFrequency: withdrawalFrequency ?? defaultFrequency,
      compoundFrequency: compoundFrequency ?? defaultFrequency,
      withdrawalAmount: json['withdrawalAmount'] as double?,
      rateFrequency: rateFrequency ?? defaultFrequency,
      startBalance: json['startBalance'] as double?,
      duration: json['duration'] as int?,
      rate: json['rate'] as double?,
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
