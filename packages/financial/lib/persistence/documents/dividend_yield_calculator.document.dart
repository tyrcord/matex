import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexDividendYieldCalculatorDocument extends FastCalculatorDocument {
  static const defaultFrequency = MatexFinancialFrequency.annually;

  late final String? paymentFrequency;
  late final String? dividendAmount;
  late final String? sharePrice;

  MatexDividendYieldCalculatorDocument({
    String? paymentFrequency,
    String? dividendAmount,
    String? sharePrice,
  }) {
    this.paymentFrequency = paymentFrequency ?? defaultFrequency.name;
    this.dividendAmount = assignValue(dividendAmount);
    this.sharePrice = assignValue(sharePrice);
  }

  @override
  MatexDividendYieldCalculatorDocument clone() => copyWith();

  factory MatexDividendYieldCalculatorDocument.fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexDividendYieldCalculatorDocument(
      dividendAmount: json['dividendAmount'] as String?,
      sharePrice: json['sharePrice'] as String?,
      paymentFrequency:
          json['paymentFrequency'] as String? ?? defaultFrequency.name,
    );
  }

  @override
  MatexDividendYieldCalculatorDocument copyWith({
    String? sharePrice,
    String? dividendAmount,
    String? paymentFrequency,
  }) {
    return MatexDividendYieldCalculatorDocument(
      paymentFrequency: paymentFrequency ?? this.paymentFrequency,
      dividendAmount: dividendAmount ?? this.dividendAmount,
      sharePrice: sharePrice ?? this.sharePrice,
    );
  }

  @override
  MatexDividendYieldCalculatorDocument copyWithDefaults({
    bool resetSharePrice = false,
    bool resetDividendAmount = false,
    bool resetPaymentFrequency = false,
  }) {
    return MatexDividendYieldCalculatorDocument(
      sharePrice: resetSharePrice ? null : sharePrice,
      dividendAmount: resetDividendAmount ? null : dividendAmount,
      paymentFrequency:
          resetPaymentFrequency ? defaultFrequency.name : paymentFrequency,
    );
  }

  @override
  MatexDividendYieldCalculatorDocument merge(
    covariant MatexDividendYieldCalculatorDocument model,
  ) {
    return copyWith(
      paymentFrequency: model.paymentFrequency,
      dividendAmount: model.dividendAmount,
      sharePrice: model.sharePrice,
    );
  }

  @override
  MatexDividendYieldCalculatorBlocFields toFields() {
    return MatexDividendYieldCalculatorBlocFields(
      paymentFrequency: parseFinancialFrequencyFromString(paymentFrequency),
      dividendAmount: dividendAmount,
      sharePrice: sharePrice,
    );
  }

  @override
  List<Object?> get props => [
        paymentFrequency,
        dividendAmount,
        sharePrice,
      ];

  @override
  Map<String, dynamic> toJson() {
    return {
      'paymentFrequency': paymentFrequency,
      'dividendAmount': dividendAmount,
      'sharePrice': sharePrice,
      ...super.toJson(),
    };
  }
}
