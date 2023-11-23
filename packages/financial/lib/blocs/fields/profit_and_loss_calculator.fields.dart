// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_forms/fastyle_forms.dart';
import 'package:matex_core/core.dart';

final String _kDefaultEntryFeeType = FastAmountSwitchFieldType.amount.name;
final String _kDefaultExitFeeType = FastAmountSwitchFieldType.amount.name;

class MatexProfitAndLossCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  late final String? expectedSaleUnits;
  late final String? buyingPrice;
  late final String? sellingPrice;
  late final String? operatingExpenses;
  late final String? buyingExpensePerUnitRate;
  late final String? buyingExpensePerUnitAmount;
  late final String? sellingExpensePerUnitRate;
  late final String? sellingExpensePerUnitAmount;
  late final String? taxRate;
  late final String? buyingCostsPerUnitType;
  late final String? sellingCostsPerUnitType;

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
    String? expectedSaleUnits,
    String? buyingPrice,
    String? sellingPrice,
    String? operatingExpenses,
    String? buyingExpensePerUnitRate,
    String? buyingExpensePerUnitAmount,
    String? sellingExpensePerUnitRate,
    String? sellingExpensePerUnitAmount,
    String? taxRate,
    String? buyingCostsPerUnitType,
    String? sellingCostsPerUnitType,
    FastCalculatorBlocDelegate? delegate,
  }) {
    this.expectedSaleUnits = assignValue(expectedSaleUnits);
    this.buyingPrice = assignValue(buyingPrice);
    this.sellingPrice = assignValue(sellingPrice);
    this.operatingExpenses = assignValue(operatingExpenses);
    this.buyingExpensePerUnitRate = assignValue(buyingExpensePerUnitRate);
    this.buyingExpensePerUnitAmount = assignValue(buyingExpensePerUnitAmount);
    this.sellingExpensePerUnitRate = assignValue(sellingExpensePerUnitRate);
    this.sellingExpensePerUnitAmount = assignValue(sellingExpensePerUnitAmount);
    this.taxRate = assignValue(taxRate);
    this.buyingCostsPerUnitType =
        assignValue(buyingCostsPerUnitType) ?? _kDefaultEntryFeeType;
    this.sellingCostsPerUnitType =
        assignValue(sellingCostsPerUnitType) ?? _kDefaultExitFeeType;
    this.delegate = delegate;
  }

  @override
  MatexProfitAndLossCalculatorBlocFields clone() => copyWith();

  @override
  MatexProfitAndLossCalculatorBlocFields copyWithDefaults({
    bool expectedSaleUnits = false,
    bool buyingPrice = false,
    bool sellingPrice = false,
    bool operatingExpenses = false,
    bool buyingExpensePerUnitRate = false,
    bool buyingExpensePerUnitAmount = false,
    bool sellingExpensePerUnitRate = false,
    bool sellingExpensePerUnitAmount = false,
    bool taxRate = false,
    bool buyingCostsPerUnitType = false,
    bool sellingCostsPerUnitType = false,
  }) {
    return MatexProfitAndLossCalculatorBlocFields(
      expectedSaleUnits: expectedSaleUnits ? null : this.expectedSaleUnits,
      buyingPrice: buyingPrice ? null : this.buyingPrice,
      sellingPrice: sellingPrice ? null : this.sellingPrice,
      operatingExpenses: operatingExpenses ? null : this.operatingExpenses,
      buyingExpensePerUnitRate:
          buyingExpensePerUnitRate ? null : this.buyingExpensePerUnitRate,
      buyingExpensePerUnitAmount:
          buyingExpensePerUnitAmount ? null : this.buyingExpensePerUnitAmount,
      sellingExpensePerUnitRate:
          sellingExpensePerUnitRate ? null : this.sellingExpensePerUnitRate,
      sellingExpensePerUnitAmount:
          sellingExpensePerUnitAmount ? null : this.sellingExpensePerUnitAmount,
      taxRate: taxRate ? null : this.taxRate,
      buyingCostsPerUnitType: buyingCostsPerUnitType
          ? _kDefaultEntryFeeType
          : this.buyingCostsPerUnitType,
      sellingCostsPerUnitType: sellingCostsPerUnitType
          ? _kDefaultExitFeeType
          : this.sellingCostsPerUnitType,
      delegate: delegate,
    );
  }

  @override
  MatexProfitAndLossCalculatorBlocFields copyWith({
    String? expectedSaleUnits,
    String? buyingPrice,
    String? sellingPrice,
    String? operatingExpenses,
    String? buyingExpensePerUnitRate,
    String? buyingExpensePerUnitAmount,
    String? sellingExpensePerUnitRate,
    String? sellingExpensePerUnitAmount,
    String? taxRate,
    String? buyingCostsPerUnitType,
    String? sellingCostsPerUnitType,
    FastCalculatorBlocDelegate? delegate,
  }) {
    return MatexProfitAndLossCalculatorBlocFields(
      expectedSaleUnits: expectedSaleUnits ?? this.expectedSaleUnits,
      buyingPrice: buyingPrice ?? this.buyingPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      operatingExpenses: operatingExpenses ?? this.operatingExpenses,
      buyingExpensePerUnitRate:
          buyingExpensePerUnitRate ?? this.buyingExpensePerUnitRate,
      buyingExpensePerUnitAmount:
          buyingExpensePerUnitAmount ?? this.buyingExpensePerUnitAmount,
      sellingExpensePerUnitRate:
          sellingExpensePerUnitRate ?? this.sellingExpensePerUnitRate,
      sellingExpensePerUnitAmount:
          sellingExpensePerUnitAmount ?? this.sellingExpensePerUnitAmount,
      taxRate: taxRate ?? this.taxRate,
      sellingCostsPerUnitType:
          sellingCostsPerUnitType ?? this.sellingCostsPerUnitType,
      buyingCostsPerUnitType:
          buyingCostsPerUnitType ?? this.buyingCostsPerUnitType,
      delegate: delegate ?? this.delegate,
    );
  }

  @override
  MatexProfitAndLossCalculatorBlocFields merge(
    covariant MatexProfitAndLossCalculatorBlocFields model,
  ) {
    return copyWith(
      expectedSaleUnits: model.expectedSaleUnits,
      buyingPrice: model.buyingPrice,
      sellingPrice: model.sellingPrice,
      operatingExpenses: model.operatingExpenses,
      buyingExpensePerUnitRate: model.buyingExpensePerUnitRate,
      buyingExpensePerUnitAmount: model.buyingExpensePerUnitAmount,
      sellingExpensePerUnitRate: model.sellingExpensePerUnitRate,
      sellingExpensePerUnitAmount: model.sellingExpensePerUnitAmount,
      taxRate: model.taxRate,
      sellingCostsPerUnitType: model.sellingCostsPerUnitType,
      buyingCostsPerUnitType: model.buyingCostsPerUnitType,
      delegate: model.delegate,
    );
  }

  @override
  List<Object?> get props => [
        expectedSaleUnits,
        buyingPrice,
        sellingPrice,
        operatingExpenses,
        buyingExpensePerUnitRate,
        buyingExpensePerUnitAmount,
        sellingExpensePerUnitRate,
        sellingExpensePerUnitAmount,
        taxRate,
        sellingCostsPerUnitType,
        buyingCostsPerUnitType,
        delegate,
      ];
}
