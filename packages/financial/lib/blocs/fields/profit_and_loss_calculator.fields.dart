// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';

class MatexProfitAndLossCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  final String defaultEntryFeeType = 'amount';
  final String defaultExitFeeType = 'amount';

  late final String? sellingExpensePerUnitAmount;
  late final String? buyingExpensePerUnitAmount;
  late final String? sellingExpensePerUnitRate;
  late final String? buyingExpensePerUnitRate;
  late final String? sellingCostsPerUnitType;
  late final String? buyingCostsPerUnitType;
  late final String? operatingExpenses;
  late final String? expectedSaleUnits;
  late final String? sellingPrice;
  late final String? buyingPrice;
  late final String? taxRate;

  String get formattedBuyingPrice {
    final value = parseFieldValueToDouble(buyingPrice);

    return localizeCurrency(value: value);
  }

  String get formattedExpectedSaleUnits {
    final value = parseFieldValueToDouble(expectedSaleUnits);

    return localizeNumber(value: value);
  }

  String get formattedSellingPrice {
    final value = parseFieldValueToDouble(sellingPrice);

    return localizeCurrency(value: value);
  }

  String get formattedOperatingExpenses {
    final value = parseFieldValueToDouble(operatingExpenses);

    return localizeCurrency(value: value);
  }

  String get formattedBuyingExpensePerUnitRate {
    final value = parseFieldValueToDouble(buyingExpensePerUnitRate);

    return '${localizeNumber(value: value)}%';
  }

  String get formattedBuyingExpensePerUnitAmount {
    final value = parseFieldValueToDouble(buyingExpensePerUnitAmount);

    return localizeCurrency(value: value);
  }

  String get formattedSellingExpensePerUnitRate {
    final value = parseFieldValueToDouble(sellingExpensePerUnitRate);

    return '${localizeNumber(value: value)}%';
  }

  String get formattedSellingExpensePerUnitAmount {
    final value = parseFieldValueToDouble(sellingExpensePerUnitAmount);

    return localizeCurrency(value: value);
  }

  String get formattedTaxRate {
    final value = parseFieldValueToDouble(taxRate);

    return '${localizeNumber(value: value)}%';
  }

  MatexProfitAndLossCalculatorBlocFields({
    FastCalculatorBlocDelegate? delegate,
    String? sellingExpensePerUnitAmount,
    String? buyingExpensePerUnitAmount,
    String? sellingExpensePerUnitRate,
    String? buyingExpensePerUnitRate,
    String? sellingCostsPerUnitType,
    String? buyingCostsPerUnitType,
    String? expectedSaleUnits,
    String? operatingExpenses,
    String? sellingPrice,
    String? buyingPrice,
    String? taxRate,
  }) {
    this.sellingExpensePerUnitAmount = assignValue(sellingExpensePerUnitAmount);
    this.buyingExpensePerUnitAmount = assignValue(buyingExpensePerUnitAmount);
    this.sellingExpensePerUnitRate = assignValue(sellingExpensePerUnitRate);
    this.buyingExpensePerUnitRate = assignValue(buyingExpensePerUnitRate);
    this.expectedSaleUnits = assignValue(expectedSaleUnits);
    this.operatingExpenses = assignValue(operatingExpenses);
    this.sellingPrice = assignValue(sellingPrice);
    this.buyingPrice = assignValue(buyingPrice);
    this.taxRate = assignValue(taxRate);
    this.delegate = delegate;
    this.buyingCostsPerUnitType =
        assignValue(buyingCostsPerUnitType) ?? defaultEntryFeeType;
    this.sellingCostsPerUnitType =
        assignValue(sellingCostsPerUnitType) ?? defaultExitFeeType;
  }

  @override
  MatexProfitAndLossCalculatorBlocFields clone() => copyWith();

  @override
  MatexProfitAndLossCalculatorBlocFields copyWithDefaults({
    bool sellingExpensePerUnitAmount = false,
    bool buyingExpensePerUnitAmount = false,
    bool sellingExpensePerUnitRate = false,
    bool buyingExpensePerUnitRate = false,
    bool sellingCostsPerUnitType = false,
    bool buyingCostsPerUnitType = false,
    bool expectedSaleUnits = false,
    bool operatingExpenses = false,
    bool sellingPrice = false,
    bool buyingPrice = false,
    bool taxRate = false,
  }) {
    return MatexProfitAndLossCalculatorBlocFields(
      expectedSaleUnits: expectedSaleUnits ? null : this.expectedSaleUnits,
      operatingExpenses: operatingExpenses ? null : this.operatingExpenses,
      sellingPrice: sellingPrice ? null : this.sellingPrice,
      buyingPrice: buyingPrice ? null : this.buyingPrice,
      taxRate: taxRate ? null : this.taxRate,
      delegate: delegate,
      sellingExpensePerUnitAmount:
          sellingExpensePerUnitAmount ? null : this.sellingExpensePerUnitAmount,
      buyingExpensePerUnitAmount:
          buyingExpensePerUnitAmount ? null : this.buyingExpensePerUnitAmount,
      sellingExpensePerUnitRate:
          sellingExpensePerUnitRate ? null : this.sellingExpensePerUnitRate,
      buyingExpensePerUnitRate:
          buyingExpensePerUnitRate ? null : this.buyingExpensePerUnitRate,
      sellingCostsPerUnitType:
          sellingCostsPerUnitType ? null : this.sellingCostsPerUnitType,
      buyingCostsPerUnitType:
          buyingCostsPerUnitType ? null : this.buyingCostsPerUnitType,
    );
  }

  @override
  MatexProfitAndLossCalculatorBlocFields copyWith({
    FastCalculatorBlocDelegate? delegate,
    String? sellingExpensePerUnitAmount,
    String? buyingExpensePerUnitAmount,
    String? sellingExpensePerUnitRate,
    String? buyingExpensePerUnitRate,
    String? sellingCostsPerUnitType,
    String? buyingCostsPerUnitType,
    String? operatingExpenses,
    String? expectedSaleUnits,
    String? sellingPrice,
    String? buyingPrice,
    String? taxRate,
  }) {
    return MatexProfitAndLossCalculatorBlocFields(
      expectedSaleUnits: expectedSaleUnits ?? this.expectedSaleUnits,
      operatingExpenses: operatingExpenses ?? this.operatingExpenses,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      buyingPrice: buyingPrice ?? this.buyingPrice,
      delegate: delegate ?? this.delegate,
      taxRate: taxRate ?? this.taxRate,
      sellingExpensePerUnitAmount:
          sellingExpensePerUnitAmount ?? this.sellingExpensePerUnitAmount,
      buyingExpensePerUnitAmount:
          buyingExpensePerUnitAmount ?? this.buyingExpensePerUnitAmount,
      sellingExpensePerUnitRate:
          sellingExpensePerUnitRate ?? this.sellingExpensePerUnitRate,
      buyingExpensePerUnitRate:
          buyingExpensePerUnitRate ?? this.buyingExpensePerUnitRate,
      sellingCostsPerUnitType:
          sellingCostsPerUnitType ?? this.sellingCostsPerUnitType,
      buyingCostsPerUnitType:
          buyingCostsPerUnitType ?? this.buyingCostsPerUnitType,
    );
  }

  @override
  MatexProfitAndLossCalculatorBlocFields merge(
    covariant MatexProfitAndLossCalculatorBlocFields model,
  ) {
    return copyWith(
      sellingExpensePerUnitAmount: model.sellingExpensePerUnitAmount,
      buyingExpensePerUnitAmount: model.buyingExpensePerUnitAmount,
      sellingExpensePerUnitRate: model.sellingExpensePerUnitRate,
      buyingExpensePerUnitRate: model.buyingExpensePerUnitRate,
      sellingCostsPerUnitType: model.sellingCostsPerUnitType,
      buyingCostsPerUnitType: model.buyingCostsPerUnitType,
      expectedSaleUnits: model.expectedSaleUnits,
      operatingExpenses: model.operatingExpenses,
      sellingPrice: model.sellingPrice,
      buyingPrice: model.buyingPrice,
      delegate: model.delegate,
      taxRate: model.taxRate,
    );
  }

  @override
  List<Object?> get props => [
        sellingExpensePerUnitAmount,
        buyingExpensePerUnitAmount,
        sellingExpensePerUnitRate,
        buyingExpensePerUnitRate,
        sellingCostsPerUnitType,
        buyingCostsPerUnitType,
        operatingExpenses,
        expectedSaleUnits,
        sellingPrice,
        buyingPrice,
        taxRate,
      ];
}
