// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexProfitAndLossCalculatorDocument extends FastCalculatorDocument {
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

  MatexProfitAndLossCalculatorDocument({
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
    this.buyingCostsPerUnitType = assignValue(buyingCostsPerUnitType);
    this.sellingCostsPerUnitType = assignValue(sellingCostsPerUnitType);
  }

  @override
  MatexProfitAndLossCalculatorDocument clone() => copyWith();

  @override
  MatexProfitAndLossCalculatorDocument copyWithDefaults({
    bool resetSellingExpensePerUnitAmount = false,
    bool resetBuyingExpensePerUnitAmount = false,
    bool resetSellingExpensePerUnitRate = false,
    bool resetBuyingExpensePerUnitRate = false,
    bool resetSellingCostsPerUnitType = false,
    bool resetBuyingCostsPerUnitType = false,
    bool resetExpectedSaleUnits = false,
    bool resetOperatingExpenses = false,
    bool resetSellingPrice = false,
    bool resetBuyingPrice = false,
    bool resetTaxRate = false,
  }) {
    return MatexProfitAndLossCalculatorDocument(
      expectedSaleUnits: resetExpectedSaleUnits ? null : expectedSaleUnits,
      operatingExpenses: resetOperatingExpenses ? null : operatingExpenses,
      sellingPrice: resetSellingPrice ? null : sellingPrice,
      buyingPrice: resetBuyingPrice ? null : buyingPrice,
      taxRate: resetTaxRate ? null : taxRate,
      sellingExpensePerUnitAmount:
          resetSellingExpensePerUnitAmount ? null : sellingExpensePerUnitAmount,
      buyingExpensePerUnitAmount:
          resetBuyingExpensePerUnitAmount ? null : buyingExpensePerUnitAmount,
      sellingExpensePerUnitRate:
          resetSellingExpensePerUnitRate ? null : sellingExpensePerUnitRate,
      buyingExpensePerUnitRate:
          resetBuyingExpensePerUnitRate ? null : buyingExpensePerUnitRate,
      sellingCostsPerUnitType:
          resetSellingCostsPerUnitType ? null : sellingCostsPerUnitType,
      buyingCostsPerUnitType:
          resetBuyingCostsPerUnitType ? null : buyingCostsPerUnitType,
    );
  }

  @override
  MatexProfitAndLossCalculatorDocument copyWith({
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
    return MatexProfitAndLossCalculatorDocument(
      expectedSaleUnits: expectedSaleUnits ?? this.expectedSaleUnits,
      operatingExpenses: operatingExpenses ?? this.operatingExpenses,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      buyingPrice: buyingPrice ?? this.buyingPrice,
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
  MatexProfitAndLossCalculatorDocument merge(
    covariant MatexProfitAndLossCalculatorDocument model,
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
      taxRate: model.taxRate,
    );
  }

  @override
  MatexProfitAndLossCalculatorBlocFields toFields() {
    return MatexProfitAndLossCalculatorBlocFields(
      sellingExpensePerUnitAmount: sellingExpensePerUnitAmount,
      buyingExpensePerUnitAmount: buyingExpensePerUnitAmount,
      sellingExpensePerUnitRate: sellingExpensePerUnitRate,
      buyingExpensePerUnitRate: buyingExpensePerUnitRate,
      sellingCostsPerUnitType: sellingCostsPerUnitType,
      buyingCostsPerUnitType: buyingCostsPerUnitType,
      expectedSaleUnits: expectedSaleUnits,
      operatingExpenses: operatingExpenses,
      sellingPrice: sellingPrice,
      buyingPrice: buyingPrice,
      taxRate: taxRate,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'sellingExpensePerUnitAmount': sellingExpensePerUnitAmount,
      'buyingExpensePerUnitAmount': buyingExpensePerUnitAmount,
      'sellingExpensePerUnitRate': sellingExpensePerUnitRate,
      'buyingExpensePerUnitRate': buyingExpensePerUnitRate,
      'sellingCostsPerUnitType': sellingCostsPerUnitType,
      'buyingCostsPerUnitType': buyingCostsPerUnitType,
      'expectedSaleUnits': expectedSaleUnits,
      'operatingExpenses': operatingExpenses,
      'sellingPrice': sellingPrice,
      'buyingPrice': buyingPrice,
      'taxRate': taxRate,
      ...super.toJson(),
    };
  }

  static MatexProfitAndLossCalculatorDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexProfitAndLossCalculatorDocument(
      buyingExpensePerUnitAmount: json['buyingExpensePerUnitAmount'] as String?,
      sellingExpensePerUnitRate: json['sellingExpensePerUnitRate'] as String?,
      buyingExpensePerUnitRate: json['buyingExpensePerUnitRate'] as String?,
      sellingCostsPerUnitType: json['sellingCostsPerUnitType'] as String?,
      buyingCostsPerUnitType: json['buyingCostsPerUnitType'] as String?,
      expectedSaleUnits: json['expectedSaleUnits'] as String?,
      operatingExpenses: json['operatingExpenses'] as String?,
      sellingPrice: json['sellingPrice'] as String?,
      buyingPrice: json['buyingPrice'] as String?,
      taxRate: json['taxRate'] as String?,
      sellingExpensePerUnitAmount:
          json['sellingExpensePerUnitAmount'] as String?,
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
