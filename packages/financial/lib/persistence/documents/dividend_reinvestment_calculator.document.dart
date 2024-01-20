// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexDividendReinvestmentCalculatorDocument
    extends FastCalculatorDocument {
  static final defaultFrequency = MatexFinancialFrequency.annually.name;
  static const defaultDrip = true;

  /// The version of the document.
  @override
  int get version => 1;

  late final String? annualSharePriceIncrease;
  late final String? annualDividendIncrease;
  late final String? annualContribution;
  late final String paymentFrequency;
  late final String? numberOfShares;
  late final String? dividendYield;
  late final String? yearsToGrow;
  late final String? sharePrice;
  late final String? taxRate;
  late final bool drip;

  MatexDividendReinvestmentCalculatorDocument({
    String? annualSharePriceIncrease,
    String? annualDividendIncrease,
    String? annualContribution,
    String? paymentFrequency,
    String? numberOfShares,
    String? dividendYield,
    String? yearsToGrow,
    String? sharePrice,
    String? taxRate,
    bool? drip,
  }) {
    this.annualSharePriceIncrease = assignValue(annualSharePriceIncrease);
    this.annualDividendIncrease = assignValue(annualDividendIncrease);
    this.paymentFrequency = paymentFrequency ?? defaultFrequency;
    this.annualContribution = assignValue(annualContribution);
    this.numberOfShares = assignValue(numberOfShares);
    this.dividendYield = assignValue(dividendYield);
    this.yearsToGrow = assignValue(yearsToGrow);
    this.sharePrice = assignValue(sharePrice);
    this.taxRate = assignValue(taxRate);
    this.drip = drip ?? defaultDrip;
  }

  @override
  MatexDividendReinvestmentCalculatorDocument clone() => copyWith();

  factory MatexDividendReinvestmentCalculatorDocument.fromJson(
      Map<String, dynamic> json) {
    return MatexDividendReinvestmentCalculatorDocument(
      annualSharePriceIncrease: json['annualSharePriceIncrease'] as String?,
      annualDividendIncrease: json['annualDividendIncrease'] as String?,
      annualContribution: json['annualContribution'] as String?,
      paymentFrequency: json['paymentFrequency'] as String?,
      numberOfShares: json['numberOfShares'] as String?,
      dividendYield: json['dividendYield'] as String?,
      yearsToGrow: json['yearsToGrow'] as String?,
      sharePrice: json['sharePrice'] as String?,
      taxRate: json['taxRate'] as String?,
      drip: json['drip'] as bool?,
    );
  }

  @override
  MatexDividendReinvestmentCalculatorDocument copyWith({
    String? annualSharePriceIncrease,
    String? annualDividendIncrease,
    String? annualContribution,
    String? paymentFrequency,
    String? numberOfShares,
    String? dividendYield,
    String? yearsToGrow,
    String? sharePrice,
    String? taxRate,
    bool? drip,
  }) {
    return MatexDividendReinvestmentCalculatorDocument(
      annualContribution: annualContribution ?? this.annualContribution,
      paymentFrequency: paymentFrequency ?? paymentFrequency,
      numberOfShares: numberOfShares ?? this.numberOfShares,
      dividendYield: dividendYield ?? this.dividendYield,
      yearsToGrow: yearsToGrow ?? this.yearsToGrow,
      sharePrice: sharePrice ?? this.sharePrice,
      taxRate: taxRate ?? this.taxRate,
      drip: drip ?? this.drip,
      annualSharePriceIncrease:
          annualSharePriceIncrease ?? this.annualSharePriceIncrease,
      annualDividendIncrease:
          annualDividendIncrease ?? this.annualDividendIncrease,
    );
  }

  @override
  MatexDividendReinvestmentCalculatorDocument copyWithDefaults({
    bool resetAnnualSharePriceIncrease = false,
    bool resetAnnualDividendIncrease = false,
    bool resetAnnualContribution = false,
    bool resetPaymentFrequency = false,
    bool resetNumberOfShares = false,
    bool resetDividendYield = false,
    bool resetYearsToGrow = false,
    bool resetSharePrice = false,
    bool resetTaxRate = false,
    bool resetDrip = false,
  }) {
    return MatexDividendReinvestmentCalculatorDocument(
      annualContribution: resetAnnualContribution ? null : annualContribution,
      paymentFrequency: resetPaymentFrequency ? null : paymentFrequency,
      numberOfShares: resetNumberOfShares ? null : numberOfShares,
      dividendYield: resetDividendYield ? null : dividendYield,
      yearsToGrow: resetYearsToGrow ? null : yearsToGrow,
      sharePrice: resetSharePrice ? null : sharePrice,
      taxRate: resetTaxRate ? null : taxRate,
      drip: resetDrip ? null : drip,
      annualSharePriceIncrease:
          resetAnnualSharePriceIncrease ? null : annualSharePriceIncrease,
      annualDividendIncrease:
          resetAnnualDividendIncrease ? null : annualDividendIncrease,
    );
  }

  @override
  MatexDividendReinvestmentCalculatorDocument merge(
    covariant MatexDividendReinvestmentCalculatorDocument model,
  ) {
    return copyWith(
      annualSharePriceIncrease: model.annualSharePriceIncrease,
      annualDividendIncrease: model.annualDividendIncrease,
      annualContribution: model.annualContribution,
      paymentFrequency: model.paymentFrequency,
      numberOfShares: model.numberOfShares,
      dividendYield: model.dividendYield,
      yearsToGrow: model.yearsToGrow,
      sharePrice: model.sharePrice,
      taxRate: model.taxRate,
      drip: model.drip,
    );
  }

  @override
  MatexDividendReinvestmentCalculatorBlocFields toFields() {
    return MatexDividendReinvestmentCalculatorBlocFields(
      paymentFrequency: MatexFinancialFrequencyX.fromName(paymentFrequency),
      annualSharePriceIncrease: annualSharePriceIncrease,
      annualDividendIncrease: annualDividendIncrease,
      annualContribution: annualContribution,
      numberOfShares: numberOfShares,
      dividendYield: dividendYield,
      yearsToGrow: yearsToGrow,
      sharePrice: sharePrice,
      taxRate: taxRate,
      drip: drip,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'annualSharePriceIncrease': annualSharePriceIncrease,
      'annualDividendIncrease': annualDividendIncrease,
      'annualContribution': annualContribution,
      'paymentFrequency': paymentFrequency,
      'numberOfShares': numberOfShares,
      'dividendYield': dividendYield,
      'yearsToGrow': yearsToGrow,
      'sharePrice': sharePrice,
      'taxRate': taxRate,
      'drip': drip,
      ...super.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        annualSharePriceIncrease,
        annualDividendIncrease,
        annualContribution,
        paymentFrequency,
        numberOfShares,
        dividendYield,
        yearsToGrow,
        sharePrice,
        taxRate,
        drip,
      ];
}
