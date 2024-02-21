// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:lingua_core/generated/locale_keys.g.dart';
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexDividendReinvestmentCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  static const defaultFrequency = MatexFinancialFrequency.annually;
  static const defaultDrip = true;

  late final MatexFinancialFrequency paymentFrequency;
  late final String? annualSharePriceIncrease;
  late final String? annualDividendIncrease;
  late final String? annualContribution;
  late final String? numberOfShares;
  late final String? dividendYield;
  late final String? yearsToGrow;
  late final String? sharePrice;
  late final String? taxRate;
  late final bool drip;

  String get formattedSharePrice {
    final value = parseStringToDouble(sharePrice);

    return localizeCurrency(value: value);
  }

  String get formattedPaymentFrequency => paymentFrequency.localizedName;

  String get formattedNumberOfShares {
    final value = parseStringToDouble(numberOfShares);

    return localizeNumber(value: value);
  }

  String get formattedDividendYield {
    final value = parseStringToDouble(dividendYield);

    return '${localizeNumber(value: value)}%';
  }

  String get formattedYearsToGrow {
    final value = parseStringToDouble(yearsToGrow);

    return localizeNumber(value: value);
  }

  String get formattedAnnualContribution {
    final value = parseStringToDouble(annualContribution);

    return localizeCurrency(value: value);
  }

  String get formattedAnnualSharePriceIncrease {
    final value = parseStringToDouble(annualSharePriceIncrease);

    return '${localizeNumber(value: value)}%';
  }

  String get formattedAnnualDividendIncrease {
    final value = parseStringToDouble(annualDividendIncrease);

    return '${localizeNumber(value: value)}%';
  }

  String get formattedTaxRate {
    final value = parseStringToDouble(taxRate);

    return '${localizeNumber(value: value)}%';
  }

  String get formattedDrip {
    return drip
        ? CoreLocaleKeys.core_label_yes.tr()
        : CoreLocaleKeys.core_label_no.tr();
  }

  MatexDividendReinvestmentCalculatorBlocFields({
    MatexFinancialFrequency? paymentFrequency,
    FastCalculatorBlocDelegate? delegate,
    String? annualSharePriceIncrease,
    String? annualDividendIncrease,
    String? annualContribution,
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
    this.delegate = delegate;
  }

  @override
  MatexDividendReinvestmentCalculatorBlocFields clone() => copyWith();

  @override
  MatexDividendReinvestmentCalculatorBlocFields copyWith({
    MatexFinancialFrequency? paymentFrequency,
    FastCalculatorBlocDelegate? delegate,
    String? annualSharePriceIncrease,
    String? annualDividendIncrease,
    String? annualContribution,
    String? numberOfShares,
    String? dividendYield,
    String? yearsToGrow,
    String? sharePrice,
    String? taxRate,
    bool? drip,
  }) {
    return MatexDividendReinvestmentCalculatorBlocFields(
      annualContribution: annualContribution ?? this.annualContribution,
      paymentFrequency: paymentFrequency ?? paymentFrequency,
      numberOfShares: numberOfShares ?? this.numberOfShares,
      dividendYield: dividendYield ?? this.dividendYield,
      yearsToGrow: yearsToGrow ?? this.yearsToGrow,
      sharePrice: sharePrice ?? this.sharePrice,
      delegate: delegate ?? this.delegate,
      taxRate: taxRate ?? this.taxRate,
      drip: drip ?? this.drip,
      annualSharePriceIncrease:
          annualSharePriceIncrease ?? this.annualSharePriceIncrease,
      annualDividendIncrease:
          annualDividendIncrease ?? this.annualDividendIncrease,
    );
  }

  @override
  MatexDividendReinvestmentCalculatorBlocFields copyWithDefaults({
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
    return MatexDividendReinvestmentCalculatorBlocFields(
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

  @override
  Map<String, dynamic> toJson() {
    return {
      'annualSharePriceIncrease': annualSharePriceIncrease,
      'annualDividendIncrease': annualDividendIncrease,
      'annualContribution': annualContribution,
      'paymentFrequency': paymentFrequency.name,
      'numberOfShares': numberOfShares,
      'dividendYield': dividendYield,
      'yearsToGrow': yearsToGrow,
      'sharePrice': sharePrice,
      'taxRate': taxRate,
      'drip': drip,
    };
  }
}
