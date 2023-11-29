import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexDividendReinvestmentCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
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

  MatexDividendReinvestmentCalculatorBlocFields({
    String? sharePrice,
    String? numberOfShares,
    String? dividendYield,
    String? yearsToGrow,
    String? annualContribution,
    String? annualSharePriceIncrease,
    String? annualDividendIncrease,
    String? taxRate,
    bool? drip = defaultDrip,
    MatexFinancialFrequency? dividendPaymentFrequency,
    FastCalculatorBlocDelegate? delegate,
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
    this.delegate = delegate;
  }

  @override
  MatexDividendReinvestmentCalculatorBlocFields clone() => copyWith();

  @override
  MatexDividendReinvestmentCalculatorBlocFields copyWith({
    MatexFinancialFrequency? paymentFrequency,
    String? sharePrice,
    String? numberOfShares,
    String? dividendYield,
    String? yearsToGrow,
    String? annualContribution,
    String? annualSharePriceIncrease,
    String? annualDividendIncrease,
    String? taxRate,
    bool? drip,
    FastCalculatorBlocDelegate? delegate,
  }) {
    return MatexDividendReinvestmentCalculatorBlocFields(
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
      delegate: delegate ?? this.delegate,
    );
  }

  @override
  MatexDividendReinvestmentCalculatorBlocFields copyWithDefaults({
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
    return MatexDividendReinvestmentCalculatorBlocFields(
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
      drip: resetDrip ? defaultDrip : drip,
    );
  }

  @override
  MatexDividendReinvestmentCalculatorBlocFields merge(
    covariant MatexDividendReinvestmentCalculatorBlocFields model,
  ) {
    return copyWith(
      sharePrice: model.sharePrice,
      numberOfShares: model.numberOfShares,
      dividendYield: model.dividendYield,
      yearsToGrow: model.yearsToGrow,
      annualContribution: model.annualContribution,
      annualSharePriceIncrease: model.annualSharePriceIncrease,
      annualDividendIncrease: model.annualDividendIncrease,
      taxRate: model.taxRate,
      drip: model.drip,
      paymentFrequency: model.dividendPaymentFrequency,
      delegate: model.delegate,
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
        delegate,
      ];
}
