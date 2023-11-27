import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class DividendYieldCalculatorState extends MatexCalculatorState {
  static const defaultFrequency = MatexFinancialFrequency.annually;

  final double? sharePrice;
  final double? totalDividend;

  final MatexFinancialFrequency dividendPaymentFrequency;

  const DividendYieldCalculatorState({
    this.sharePrice,
    this.totalDividend,
    MatexFinancialFrequency? dividendPaymentFrequency,
  }) : dividendPaymentFrequency = dividendPaymentFrequency ?? defaultFrequency;

  @override
  DividendYieldCalculatorState clone() => copyWith();

  factory DividendYieldCalculatorState.fromJson(Map<String, dynamic> json) {
    return DividendYieldCalculatorState(
      sharePrice: json['sharePrice'] as double?,
      totalDividend: json['totalDividend'] as double?,
      dividendPaymentFrequency:
          json['dividendPaymentFrequency'] as MatexFinancialFrequency? ??
              defaultFrequency,
    );
  }

  @override
  DividendYieldCalculatorState copyWith({
    double? sharePrice,
    double? totalDividend,
    MatexFinancialFrequency? dividendPaymentFrequency,
  }) {
    return DividendYieldCalculatorState(
      sharePrice: sharePrice ?? this.sharePrice,
      totalDividend: totalDividend ?? this.totalDividend,
      dividendPaymentFrequency:
          dividendPaymentFrequency ?? this.dividendPaymentFrequency,
    );
  }

  @override
  DividendYieldCalculatorState copyWithDefaults({
    bool resetSharePrice = false,
    bool resetTotalDividend = false,
    bool resetDividendPaymentFrequency = false,
  }) {
    return DividendYieldCalculatorState(
      sharePrice: resetSharePrice ? null : sharePrice,
      totalDividend: resetTotalDividend ? null : totalDividend,
      dividendPaymentFrequency: resetDividendPaymentFrequency
          ? defaultFrequency
          : dividendPaymentFrequency,
    );
  }

  @override
  DividendYieldCalculatorState merge(
    covariant DividendYieldCalculatorState model,
  ) {
    return copyWith(
      sharePrice: model.sharePrice,
      totalDividend: model.totalDividend,
      dividendPaymentFrequency: model.dividendPaymentFrequency,
    );
  }

  @override
  List<Object?> get props => [
        sharePrice,
        totalDividend,
        dividendPaymentFrequency,
      ];
}
