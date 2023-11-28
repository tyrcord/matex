import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexDividendYieldCalculatorState extends MatexCalculatorState {
  static const defaultFrequency = MatexFinancialFrequency.annually;

  final MatexFinancialFrequency paymentFrequency;
  final double? totalDividends;
  final double? sharePrice;

  const MatexDividendYieldCalculatorState({
    MatexFinancialFrequency? paymentFrequency,
    this.totalDividends,
    this.sharePrice,
  }) : paymentFrequency = paymentFrequency ?? defaultFrequency;

  @override
  MatexDividendYieldCalculatorState clone() => copyWith();

  factory MatexDividendYieldCalculatorState.fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexDividendYieldCalculatorState(
      sharePrice: json['sharePrice'] as double?,
      totalDividends: json['totalDividends'] as double?,
      paymentFrequency:
          json['dividendPaymentFrequency'] as MatexFinancialFrequency? ??
              defaultFrequency,
    );
  }

  @override
  MatexDividendYieldCalculatorState copyWith({
    double? sharePrice,
    double? totalDividends,
    MatexFinancialFrequency? paymentFrequency,
  }) {
    return MatexDividendYieldCalculatorState(
      paymentFrequency: paymentFrequency ?? this.paymentFrequency,
      totalDividends: totalDividends ?? this.totalDividends,
      sharePrice: sharePrice ?? this.sharePrice,
    );
  }

  @override
  MatexDividendYieldCalculatorState copyWithDefaults({
    bool resetPaymentFrequency = false,
    bool resetTotalDividend = false,
    bool resetSharePrice = false,
  }) {
    return MatexDividendYieldCalculatorState(
      sharePrice: resetSharePrice ? null : sharePrice,
      totalDividends: resetTotalDividend ? null : totalDividends,
      paymentFrequency:
          resetPaymentFrequency ? defaultFrequency : paymentFrequency,
    );
  }

  @override
  MatexDividendYieldCalculatorState merge(
    covariant MatexDividendYieldCalculatorState model,
  ) {
    return copyWith(
      paymentFrequency: model.paymentFrequency,
      totalDividends: model.totalDividends,
      sharePrice: model.sharePrice,
    );
  }

  @override
  List<Object?> get props => [
        paymentFrequency,
        totalDividends,
        sharePrice,
      ];
}
