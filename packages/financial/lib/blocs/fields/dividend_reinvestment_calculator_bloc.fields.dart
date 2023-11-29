import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';
import 'package:easy_localization/easy_localization.dart';

class MatexDividendReinvestmentCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  static const defaultFrequency = MatexFinancialFrequency.annually;
  static const defaultDrip = true;

  late final MatexFinancialFrequency paymentFrequency;
  late final String? sharePrice;
  late final String? numberOfShares;
  late final String? dividendYield;
  late final String? yearsToGrow;
  late final String? annualContribution;
  late final String? annualSharePriceIncrease;
  late final String? annualDividendIncrease;
  late final String? taxRate;
  late final bool drip;

  String get formattedSharePrice {
    final value = parseFieldValueToDouble(sharePrice);

    return localizeCurrency(value: value);
  }

  String get formattedPaymentFrequency {
    return getLocaleKeyForFinancialFrequency(paymentFrequency).tr();
  }

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
    MatexFinancialFrequency? paymentFrequency,
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
    this.paymentFrequency = paymentFrequency ?? defaultFrequency;
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
      paymentFrequency: paymentFrequency ?? paymentFrequency,
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
      paymentFrequency:
          resetPaymentFrequency ? defaultFrequency : paymentFrequency,
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
      annualSharePriceIncrease: model.annualSharePriceIncrease,
      annualDividendIncrease: model.annualDividendIncrease,
      annualContribution: model.annualContribution,
      paymentFrequency: model.paymentFrequency,
      numberOfShares: model.numberOfShares,
      dividendYield: model.dividendYield,
      yearsToGrow: model.yearsToGrow,
      sharePrice: model.sharePrice,
      delegate: model.delegate,
      taxRate: model.taxRate,
      drip: model.drip,
    );
  }

  @override
  List<Object?> get props => [
        paymentFrequency,
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
