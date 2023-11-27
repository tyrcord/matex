import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexDividendYieldCalculatorDocument extends FastCalculatorDocument {
  static const defaultFrequency = MatexFinancialFrequency.annually;

  late final String? sharePrice;
  late final String? totalDividend;
  late final MatexFinancialFrequency dividendPaymentFrequency;

  MatexDividendYieldCalculatorDocument({
    String? sharePrice,
    String? totalDividend,
    MatexFinancialFrequency? dividendPaymentFrequency,
  }) {
    this.sharePrice = assignValue(sharePrice);
    this.totalDividend = assignValue(totalDividend);
    this.dividendPaymentFrequency =
        dividendPaymentFrequency ?? defaultFrequency;
  }

  @override
  MatexDividendYieldCalculatorDocument clone() => copyWith();

  factory MatexDividendYieldCalculatorDocument.fromJson(
      Map<String, dynamic> json) {
    return MatexDividendYieldCalculatorDocument(
      sharePrice: json['sharePrice'] as String?,
      totalDividend: json['totalDividend'] as String?,
      dividendPaymentFrequency:
          json['dividendPaymentFrequency'] as MatexFinancialFrequency? ??
              defaultFrequency,
    );
  }

  @override
  MatexDividendYieldCalculatorDocument copyWith({
    String? sharePrice,
    String? totalDividend,
    MatexFinancialFrequency? dividendPaymentFrequency,
  }) {
    return MatexDividendYieldCalculatorDocument(
      sharePrice: sharePrice ?? this.sharePrice,
      totalDividend: totalDividend ?? this.totalDividend,
      dividendPaymentFrequency:
          dividendPaymentFrequency ?? this.dividendPaymentFrequency,
    );
  }

  @override
  MatexDividendYieldCalculatorDocument copyWithDefaults({
    bool resetSharePrice = false,
    bool resetTotalDividend = false,
    bool resetDividendPaymentFrequency = false,
  }) {
    return MatexDividendYieldCalculatorDocument(
      sharePrice: resetSharePrice ? null : sharePrice,
      totalDividend: resetTotalDividend ? null : totalDividend,
      dividendPaymentFrequency: resetDividendPaymentFrequency
          ? defaultFrequency
          : dividendPaymentFrequency,
    );
  }

  @override
  MatexDividendYieldCalculatorDocument merge(
    covariant MatexDividendYieldCalculatorDocument model,
  ) {
    return copyWith(
      sharePrice: model.sharePrice,
      totalDividend: model.totalDividend,
      dividendPaymentFrequency: model.dividendPaymentFrequency,
    );
  }

  @override
  MatexDividendYieldCalculatorBlocFields toFields() {
    return MatexDividendYieldCalculatorBlocFields(
      sharePrice: sharePrice,
      totalDividend: totalDividend,
      dividendPaymentFrequency: dividendPaymentFrequency,
    );
  }

  @override
  List<Object?> get props => [
        sharePrice,
        totalDividend,
        dividendPaymentFrequency,
      ];

  @override
  Map<String, dynamic> toJson() {
    return {
      'sharePrice': sharePrice,
      'totalDividend': totalDividend,
      'dividendPaymentFrequency': dividendPaymentFrequency,
      ...super.toJson(),
    };
  }
}
