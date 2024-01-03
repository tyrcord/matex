// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexCompoundCalculatorBlocDocument extends FastCalculatorDocument {
  static final defaultFrequency = MatexFinancialFrequency.monthly.name;

  late final String? startBalance;
  late final String? rate;
  late final String? duration;
  late final String contributionFrequency;
  late final String compoundFrequency;
  late final String withdrawalFrequency;
  late final String rateFrequency;
  late final String? withdrawalAmount;
  late final String? additionalContribution;
  late final String? accountCurrency;

  static MatexForexCompoundCalculatorBlocDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexForexCompoundCalculatorBlocDocument(
      startBalance: json['startBalance'] as String?,
      rate: json['rate'] as String?,
      duration: json['duration'] as String?,
      contributionFrequency: json['contributionFrequency'] as String?,
      compoundFrequency: json['compoundFrequency'] as String?,
      withdrawalFrequency: json['withdrawalFrequency'] as String?,
      rateFrequency: json['rateFrequency'] as String?,
      withdrawalAmount: json['withdrawalAmount'] as String?,
      additionalContribution: json['additionalContribution'] as String?,
      accountCurrency: json['accountCurrency'] as String?,
    );
  }

  MatexForexCompoundCalculatorBlocDocument({
    String? startBalance,
    String? rate,
    String? duration,
    String? contributionFrequency,
    String? compoundFrequency,
    String? withdrawalFrequency,
    String? rateFrequency,
    String? withdrawalAmount,
    String? additionalContribution,
    String? accountCurrency,
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
    this.accountCurrency = assignValue(accountCurrency);
  }

  @override
  MatexForexCompoundCalculatorBlocDocument clone() => copyWith();

  @override
  MatexForexCompoundCalculatorBlocDocument copyWith({
    String? startBalance,
    String? rate,
    String? duration,
    String? contributionFrequency,
    String? compoundFrequency,
    String? withdrawalFrequency,
    String? rateFrequency,
    String? withdrawalAmount,
    String? additionalContribution,
    String? accountCurrency,
  }) {
    return MatexForexCompoundCalculatorBlocDocument(
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
      accountCurrency: accountCurrency ?? this.accountCurrency,
    );
  }

  @override
  MatexForexCompoundCalculatorBlocDocument copyWithDefaults({
    bool resetStartBalance = false,
    bool resetRate = false,
    bool resetDuration = false,
    bool resetContributionFrequency = false,
    bool resetCompoundFrequency = false,
    bool resetWithdrawalFrequency = false,
    bool resetRateFrequency = false,
    bool resetWithdrawalAmount = false,
    bool resetAdditionalContribution = false,
    bool resetAccountCurrency = false,
  }) {
    return MatexForexCompoundCalculatorBlocDocument(
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
      accountCurrency: resetAccountCurrency ? null : accountCurrency,
    );
  }

  @override
  MatexForexCompoundCalculatorBlocDocument merge(
    covariant MatexForexCompoundCalculatorBlocDocument model,
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
      accountCurrency: model.accountCurrency,
    );
  }

  @override
  MatexForexCompoundCalculatorBlocFields toFields() {
    return MatexForexCompoundCalculatorBlocFields(
      startBalance: startBalance,
      rate: rate,
      duration: duration,
      contributionFrequency:
          MatexFinancialFrequencyX.fromName(contributionFrequency),
      compoundFrequency: MatexFinancialFrequencyX.fromName(compoundFrequency),
      withdrawalFrequency:
          MatexFinancialFrequencyX.fromName(withdrawalFrequency),
      rateFrequency: MatexFinancialFrequencyX.fromName(rateFrequency),
      withdrawalAmount: withdrawalAmount,
      additionalContribution: additionalContribution,
      accountCurrency: accountCurrency,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'startBalance': startBalance,
      'rate': rate,
      'duration': duration,
      'contributionFrequency': contributionFrequency,
      'compoundFrequency': compoundFrequency,
      'withdrawalFrequency': withdrawalFrequency,
      'rateFrequency': rateFrequency,
      'withdrawalAmount': withdrawalAmount,
      'additionalContribution': additionalContribution,
      'accountCurrency': accountCurrency,
      ...super.toJson(),
    };
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
        accountCurrency,
      ];
}
