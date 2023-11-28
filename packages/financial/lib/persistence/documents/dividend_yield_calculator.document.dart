import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexDividendYieldCalculatorDocument extends FastCalculatorDocument {
  static const defaultFrequency = MatexFinancialFrequency.annually;

  late final String? paymentFrequency;
  late final String? totalDividends;
  late final String? sharePrice;

  MatexDividendYieldCalculatorDocument({
    String? paymentFrequency,
    String? totalDividends,
    String? sharePrice,
  }) {
    this.paymentFrequency = paymentFrequency ?? defaultFrequency.name;
    this.totalDividends = assignValue(totalDividends);
    this.sharePrice = assignValue(sharePrice);
  }

  @override
  MatexDividendYieldCalculatorDocument clone() => copyWith();

  factory MatexDividendYieldCalculatorDocument.fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexDividendYieldCalculatorDocument(
      totalDividends: json['totalDividends'] as String?,
      sharePrice: json['sharePrice'] as String?,
      paymentFrequency:
          json['dividendPaymentFrequency'] as String? ?? defaultFrequency.name,
    );
  }

  @override
  MatexDividendYieldCalculatorDocument copyWith({
    String? sharePrice,
    String? totalDividends,
    String? paymentFrequency,
  }) {
    return MatexDividendYieldCalculatorDocument(
      paymentFrequency: paymentFrequency ?? this.paymentFrequency,
      totalDividends: totalDividends ?? this.totalDividends,
      sharePrice: sharePrice ?? this.sharePrice,
    );
  }

  @override
  MatexDividendYieldCalculatorDocument copyWithDefaults({
    bool resetSharePrice = false,
    bool resetTotalDividend = false,
    bool resetPaymentFrequency = false,
  }) {
    return MatexDividendYieldCalculatorDocument(
      sharePrice: resetSharePrice ? null : sharePrice,
      totalDividends: resetTotalDividend ? null : totalDividends,
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
      totalDividends: model.totalDividends,
      sharePrice: model.sharePrice,
    );
  }

  @override
  MatexDividendYieldCalculatorBlocFields toFields() {
    return MatexDividendYieldCalculatorBlocFields(
      paymentFrequency: parseFinancialFrequencyFromString(paymentFrequency),
      totalDividends: totalDividends,
      sharePrice: sharePrice,
    );
  }

  @override
  List<Object?> get props => [
        paymentFrequency,
        totalDividends,
        sharePrice,
      ];

  @override
  Map<String, dynamic> toJson() {
    return {
      'paymentFrequency': paymentFrequency,
      'totalDividends': totalDividends,
      'sharePrice': sharePrice,
      ...super.toJson(),
    };
  }
}
