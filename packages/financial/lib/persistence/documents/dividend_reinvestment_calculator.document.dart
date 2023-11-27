import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexDividendReinvestmentCalculatorDocument
    extends FastCalculatorDocument {
  static const defaultFrequency = MatexFinancialFrequency.annually;
  static const defaultDrip = true;

  late final MatexFinancialFrequency dividendPaymentFrequency;
  late final String? sharePrice;
  late final String? numberOfShares;
  late final String? dividendYield;
  late final String? yearsToGrow;
  late final String? annualContribution;
  late final String? annualSharePriceIncrease;
  late final String? annualDividendIncrease;
  late final String? taxRate;
  late final bool drip;

  MatexDividendReinvestmentCalculatorDocument({
    MatexFinancialFrequency? dividendPaymentFrequency,
    String? sharePrice,
    String? numberOfShares,
    String? dividendYield,
    String? yearsToGrow,
    String? annualContribution,
    String? annualSharePriceIncrease,
    String? annualDividendIncrease,
    String? taxRate,
    bool? drip,
  }) {
    this.sharePrice = assignValue(sharePrice);
    this.numberOfShares = assignValue(numberOfShares);
    this.dividendYield = assignValue(dividendYield);
    this.yearsToGrow = assignValue(yearsToGrow);
    this.annualContribution = assignValue(annualContribution);
    this.annualSharePriceIncrease = assignValue(annualSharePriceIncrease);
    this.annualDividendIncrease = assignValue(annualDividendIncrease);
    this.taxRate = assignValue(taxRate);
    this.drip = drip ?? defaultDrip;
    this.dividendPaymentFrequency =
        dividendPaymentFrequency ?? defaultFrequency;
  }

  @override
  MatexDividendReinvestmentCalculatorDocument clone() => copyWith();

  factory MatexDividendReinvestmentCalculatorDocument.fromJson(
      Map<String, dynamic> json) {
    return MatexDividendReinvestmentCalculatorDocument(
      dividendPaymentFrequency:
          json['dividendPaymentFrequency'] as MatexFinancialFrequency? ??
              defaultFrequency,
      sharePrice: json['sharePrice'] as String?,
      numberOfShares: json['numberOfShares'] as String?,
      dividendYield: json['dividendYield'] as String?,
      yearsToGrow: json['yearsToGrow'] as String?,
      annualContribution: json['annualContribution'] as String?,
      annualSharePriceIncrease: json['annualSharePriceIncrease'] as String?,
      annualDividendIncrease: json['annualDividendIncrease'] as String?,
      taxRate: json['taxRate'] as String?,
      drip: json['drip'] as bool? ?? defaultDrip,
    );
  }

  @override
  MatexDividendReinvestmentCalculatorDocument copyWithDefaults({
    bool resetDividendPaymentFrequency = false,
    bool resetSharePrice = false,
    bool resetNumberOfShares = false,
    bool resetDividendYield = false,
    bool resetYearsToGrow = false,
    bool resetAnnualContribution = false,
    bool resetAnnualSharePriceIncrease = false,
    bool resetAnnualDividendIncrease = false,
    bool resetTaxRate = false,
    bool resetDrip = false,
  }) {
    return MatexDividendReinvestmentCalculatorDocument(
      dividendPaymentFrequency: resetDividendPaymentFrequency
          ? defaultFrequency
          : dividendPaymentFrequency,
      sharePrice: resetSharePrice ? null : sharePrice,
      numberOfShares: resetNumberOfShares ? null : numberOfShares,
      dividendYield: resetDividendYield ? null : dividendYield,
      yearsToGrow: resetYearsToGrow ? null : yearsToGrow,
      annualContribution: resetAnnualContribution ? null : annualContribution,
      annualSharePriceIncrease:
          resetAnnualSharePriceIncrease ? null : annualSharePriceIncrease,
      annualDividendIncrease:
          resetAnnualDividendIncrease ? null : annualDividendIncrease,
      taxRate: resetTaxRate ? null : taxRate,
      drip: resetDrip ? defaultDrip : drip,
    );
  }

  @override
  MatexDividendReinvestmentCalculatorDocument copyWith({
    MatexFinancialFrequency? dividendPaymentFrequency,
    String? sharePrice,
    String? numberOfShares,
    String? dividendYield,
    String? yearsToGrow,
    String? annualContribution,
    String? annualSharePriceIncrease,
    String? annualDividendIncrease,
    String? taxRate,
    bool? drip,
  }) {
    return MatexDividendReinvestmentCalculatorDocument(
      dividendPaymentFrequency:
          dividendPaymentFrequency ?? this.dividendPaymentFrequency,
      sharePrice: sharePrice ?? this.sharePrice,
      numberOfShares: numberOfShares ?? this.numberOfShares,
      dividendYield: dividendYield ?? this.dividendYield,
      yearsToGrow: yearsToGrow ?? this.yearsToGrow,
      annualContribution: annualContribution ?? this.annualContribution,
      annualSharePriceIncrease:
          annualSharePriceIncrease ?? this.annualSharePriceIncrease,
      annualDividendIncrease:
          annualDividendIncrease ?? this.annualDividendIncrease,
      taxRate: taxRate ?? this.taxRate,
      drip: drip ?? this.drip,
    );
  }

  @override
  MatexDividendReinvestmentCalculatorDocument merge(
    covariant MatexDividendReinvestmentCalculatorDocument model,
  ) {
    return copyWith(
      dividendPaymentFrequency: model.dividendPaymentFrequency,
      sharePrice: model.sharePrice,
      numberOfShares: model.numberOfShares,
      dividendYield: model.dividendYield,
      yearsToGrow: model.yearsToGrow,
      annualContribution: model.annualContribution,
      annualSharePriceIncrease: model.annualSharePriceIncrease,
      annualDividendIncrease: model.annualDividendIncrease,
      taxRate: model.taxRate,
      drip: model.drip,
    );
  }

  @override
  MatexDividendReinvestmentCalculatorBlocFields toFields() {
    return MatexDividendReinvestmentCalculatorBlocFields(
      dividendPaymentFrequency: dividendPaymentFrequency,
      sharePrice: sharePrice,
      numberOfShares: numberOfShares,
      dividendYield: dividendYield,
      yearsToGrow: yearsToGrow,
      annualContribution: annualContribution,
      annualSharePriceIncrease: annualSharePriceIncrease,
      annualDividendIncrease: annualDividendIncrease,
      taxRate: taxRate,
      drip: drip,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'dividendPaymentFrequency': dividendPaymentFrequency,
      'sharePrice': sharePrice,
      'numberOfShares': numberOfShares,
      'dividendYield': dividendYield,
      'yearsToGrow': yearsToGrow,
      'annualContribution': annualContribution,
      'annualSharePriceIncrease': annualSharePriceIncrease,
      'annualDividendIncrease': annualDividendIncrease,
      'taxRate': taxRate,
      'drip': drip,
      ...super.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        dividendPaymentFrequency,
        sharePrice,
        numberOfShares,
        dividendYield,
        yearsToGrow,
        annualContribution,
        annualSharePriceIncrease,
        annualDividendIncrease,
        taxRate,
        drip,
      ];
}
