import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexDividendReinvestmentCalculatorState extends MatexCalculatorState {
  static const defaultFrequency = MatexFinancialFrequency.annually;
  static const defaultDrip = true;

  final MatexFinancialFrequency dividendPaymentFrequency;
  final double? sharePrice;
  final double? numberOfShares;
  final double? dividendYield;
  final int? yearsToGrow;
  final double? annualContribution;
  final double? annualSharePriceIncrease;
  final double? annualDividendIncrease;
  final double? taxRate;
  final bool drip;

  const MatexDividendReinvestmentCalculatorState({
    MatexFinancialFrequency? dividendPaymentFrequency,
    this.sharePrice,
    this.numberOfShares,
    this.dividendYield,
    this.yearsToGrow,
    this.annualContribution,
    this.annualSharePriceIncrease,
    this.annualDividendIncrease,
    this.taxRate,
    this.drip = true,
  }) : dividendPaymentFrequency = dividendPaymentFrequency ?? defaultFrequency;

  @override
  MatexDividendReinvestmentCalculatorState clone() => copyWith();

  factory MatexDividendReinvestmentCalculatorState.fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexDividendReinvestmentCalculatorState(
      dividendPaymentFrequency:
          json['dividendPaymentFrequency'] as MatexFinancialFrequency? ??
              defaultFrequency,
      sharePrice: json['sharePrice'] as double?,
      numberOfShares: json['numberOfShares'] as double?,
      dividendYield: json['dividendYield'] as double?,
      yearsToGrow: json['yearsToGrow'] as int?,
      annualContribution: json['annualContribution'] as double?,
      annualSharePriceIncrease: json['annualSharePriceIncrease'] as double?,
      annualDividendIncrease: json['annualDividendIncrease'] as double?,
      taxRate: json['taxRate'] as double?,
      drip: json['drip'] as bool? ?? defaultDrip,
    );
  }

  @override
  MatexDividendReinvestmentCalculatorState copyWith({
    MatexFinancialFrequency? paymentFrequency,
    double? sharePrice,
    double? numberOfShares,
    double? dividendYield,
    int? yearsToGrow,
    double? annualContribution,
    double? annualSharePriceIncrease,
    double? annualDividendIncrease,
    double? taxRate,
    bool? drip,
  }) {
    return MatexDividendReinvestmentCalculatorState(
      dividendPaymentFrequency: paymentFrequency ?? dividendPaymentFrequency,
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
  MatexDividendReinvestmentCalculatorState copyWithDefaults({
    bool resetPaymentFrequency = false,
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
    return MatexDividendReinvestmentCalculatorState(
      dividendPaymentFrequency:
          resetPaymentFrequency ? defaultFrequency : dividendPaymentFrequency,
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
      drip: resetDrip ? false : drip,
    );
  }

  @override
  MatexDividendReinvestmentCalculatorState merge(
      covariant MatexDividendReinvestmentCalculatorState model) {
    return copyWith(
      paymentFrequency: model.dividendPaymentFrequency,
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
