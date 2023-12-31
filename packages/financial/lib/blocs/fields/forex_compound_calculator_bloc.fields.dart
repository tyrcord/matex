// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexForexCompoundCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  static const defaultFrequency = MatexFinancialFrequency.monthly;

  late final String? startBalance;
  late final String? rate;
  late final String? duration;
  late final MatexFinancialFrequency contributionFrequency;
  late final MatexFinancialFrequency compoundFrequency;
  late final MatexFinancialFrequency withdrawalFrequency;
  late final MatexFinancialFrequency rateFrequency;
  late final String? withdrawalAmount;
  late final String? additionalContribution;

  String get formattedStartBalance {
    final value = parseFieldValueToDouble(startBalance);

    return localizeCurrency(value: value);
  }

  String get formattedRate {
    final value = parseFieldValueToDouble(rate);

    return localizePercentage(value: value);
  }

  String get formattedDuration {
    final value = parseFieldValueToDouble(duration);

    return localizeNumber(value: value);
  }

  String get formattedWithdrawalAmount {
    final value = parseFieldValueToDouble(withdrawalAmount);

    return localizeCurrency(value: value);
  }

  String get formattedAdditionalContribution {
    final value = parseFieldValueToDouble(additionalContribution);

    return localizeCurrency(value: value);
  }

  String get formattedContributionFrequency =>
      contributionFrequency.localizedName;

  String get formattedCompoundFrequency => compoundFrequency.localizedName;

  String get formattedWithdrawalFrequency => withdrawalFrequency.localizedName;

  String get formattedRateFrequency => rateFrequency.localizedName;

  MatexForexCompoundCalculatorBlocFields({
    String? startBalance,
    String? rate,
    String? duration,
    MatexFinancialFrequency? contributionFrequency,
    MatexFinancialFrequency? compoundFrequency,
    MatexFinancialFrequency? withdrawalFrequency,
    MatexFinancialFrequency? rateFrequency,
    String? withdrawalAmount,
    String? additionalContribution,
  }) {
    this.startBalance = assignValue(startBalance);
    this.rate = assignValue(rate);
    this.duration = assignValue(duration);
    this.contributionFrequency = contributionFrequency ?? defaultFrequency;
    this.compoundFrequency = compoundFrequency ?? defaultFrequency;
    this.withdrawalFrequency = withdrawalFrequency ?? defaultFrequency;
    this.rateFrequency = rateFrequency ?? defaultFrequency;
    this.withdrawalAmount = assignValue(withdrawalAmount);
    this.additionalContribution = assignValue(additionalContribution);
  }

  @override
  MatexForexCompoundCalculatorBlocFields clone() => copyWith();

  @override
  MatexForexCompoundCalculatorBlocFields copyWith({
    String? startBalance,
    String? rate,
    String? duration,
    MatexFinancialFrequency? contributionFrequency,
    MatexFinancialFrequency? compoundFrequency,
    MatexFinancialFrequency? withdrawalFrequency,
    MatexFinancialFrequency? rateFrequency,
    String? withdrawalAmount,
    String? additionalContribution,
  }) {
    return MatexForexCompoundCalculatorBlocFields(
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
  MatexForexCompoundCalculatorBlocFields copyWithDefaults({
    bool resetStartBalance = false,
    bool resetRate = false,
    bool resetDuration = false,
    bool resetContributionFrequency = false,
    bool resetCompoundFrequency = false,
    bool resetWithdrawalFrequency = false,
    bool resetRateFrequency = false,
    bool resetWithdrawalAmount = false,
    bool resetAdditionalContribution = false,
  }) {
    return MatexForexCompoundCalculatorBlocFields(
      startBalance: resetStartBalance ? null : startBalance,
      rate: resetRate ? null : rate,
      duration: resetDuration ? null : duration,
      contributionFrequency:
          resetContributionFrequency ? null : contributionFrequency,
      compoundFrequency: resetCompoundFrequency ? null : compoundFrequency,
      withdrawalFrequency:
          resetWithdrawalFrequency ? null : withdrawalFrequency,
      rateFrequency: resetRateFrequency ? null : rateFrequency,
      withdrawalAmount: resetWithdrawalAmount ? null : withdrawalAmount,
      additionalContribution:
          resetAdditionalContribution ? null : additionalContribution,
    );
  }

  @override
  MatexForexCompoundCalculatorBlocFields merge(
    covariant MatexForexCompoundCalculatorBlocFields model,
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
