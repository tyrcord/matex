import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexDividendYieldCalculatorDocument extends FastCalculatorDocument {
  static const defaultFrequency = MatexFinancialFrequency.annually;

  late final String? paymentFrequency;
  late final String? dividendAmount;
  late final String? sharePrice;

  /// The version of the document.
  @override
  int get version => 1;

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
      paymentFrequency: json['paymentFrequency'] as String?,
      dividendAmount: json['dividendAmount'] as String?,
      sharePrice: json['sharePrice'] as String?,
    );
  }

  @override
  MatexDividendYieldCalculatorDocument copyWith({
    String? paymentFrequency,
    String? dividendAmount,
    String? sharePrice,
  }) {
    return MatexDividendYieldCalculatorDocument(
      paymentFrequency: paymentFrequency ?? this.paymentFrequency,
      dividendAmount: dividendAmount ?? this.dividendAmount,
      sharePrice: sharePrice ?? this.sharePrice,
    );
  }

  @override
  MatexDividendYieldCalculatorDocument copyWithDefaults({
    bool resetPaymentFrequency = false,
    bool resetDividendAmount = false,
    bool resetSharePrice = false,
  }) {
    return MatexDividendYieldCalculatorDocument(
      paymentFrequency: resetPaymentFrequency ? null : paymentFrequency,
      dividendAmount: resetDividendAmount ? null : dividendAmount,
      sharePrice: resetSharePrice ? null : sharePrice,
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
      paymentFrequency: MatexFinancialFrequencyX.fromName(paymentFrequency),
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
