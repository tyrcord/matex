import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_forms/fastyle_forms.dart';
import 'package:matex_financial/financial.dart';

final String _kDefaultEntryFeeType = FastAmountSwitchFieldType.amount.name;
final String _kDefaultExitFeeType = FastAmountSwitchFieldType.amount.name;

class MatexProfitAndLossCalculatorDocument extends FastCalculatorDocument {
  late final String? expectedSaleUnits;
  late final String? buyingPrice;
  late final String? sellingPrice;
  late final String? operatingExpenses;
  late final String? buyingExpensePerUnitRate;
  late final String? buyingExpensePerUnitAmount;
  late final String? sellingExpensePerUnitRate;
  late final String? sellingExpensePerUnitAmount;
  late final String? taxRate;
  late final String? entryFeeType;
  late final String? exitFeeType;

  MatexProfitAndLossCalculatorDocument({
    String? expectedSaleUnits,
    String? buyingPrice,
    String? sellingPrice,
    String? operatingExpenses,
    String? buyingExpensePerUnitRate,
    String? buyingExpensePerUnitAmount,
    String? sellingExpensePerUnitRate,
    String? sellingExpensePerUnitAmount,
    String? taxRate,
    String? entryFeeType,
    String? exitFeeType,
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
    this.entryFeeType = assignValue(entryFeeType) ?? _kDefaultEntryFeeType;
    this.exitFeeType = assignValue(exitFeeType) ?? _kDefaultExitFeeType;
  }

  @override
  MatexProfitAndLossCalculatorDocument clone() => copyWith();

  @override
  MatexProfitAndLossCalculatorDocument copyWith({
    String? expectedSaleUnits,
    String? buyingPrice,
    String? sellingPrice,
    String? operatingExpenses,
    String? buyingExpensePerUnitRate,
    String? buyingExpensePerUnitAmount,
    String? sellingExpensePerUnitRate,
    String? sellingExpensePerUnitAmount,
    String? taxRate,
    String? entryFeeType,
    String? exitFeeType,
  }) {
    return MatexProfitAndLossCalculatorDocument(
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
      exitFeeType: exitFeeType ?? this.exitFeeType,
      entryFeeType: entryFeeType ?? this.entryFeeType,
    );
  }

  @override
  MatexProfitAndLossCalculatorDocument merge(
    covariant MatexProfitAndLossCalculatorDocument model,
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
      exitFeeType: model.exitFeeType,
      entryFeeType: model.entryFeeType,
    );
  }

  @override
  MatexProfitAndLossCalculatorBlocFields toFields() {
    return MatexProfitAndLossCalculatorBlocFields(
      taxRate: taxRate,
      entryFeeType: entryFeeType,
      exitFeeType: exitFeeType,
      expectedSaleUnits: expectedSaleUnits,
      buyingPrice: buyingPrice,
      sellingPrice: sellingPrice,
      operatingExpenses: operatingExpenses,
      buyingExpensePerUnitRate: buyingExpensePerUnitRate,
      buyingExpensePerUnitAmount: buyingExpensePerUnitAmount,
      sellingExpensePerUnitRate: sellingExpensePerUnitRate,
      sellingExpensePerUnitAmount: sellingExpensePerUnitAmount,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'entryFeeType': entryFeeType,
      'exitFeeType': exitFeeType,
      'taxRate': taxRate,
      'expectedSaleUnits': expectedSaleUnits,
      'buyingPrice': buyingPrice,
      'sellingPrice': sellingPrice,
      'operatingExpenses': operatingExpenses,
      'buyingExpensePerUnitRate': buyingExpensePerUnitRate,
      'buyingExpensePerUnitAmount': buyingExpensePerUnitAmount,
      'sellingExpensePerUnitRate': sellingExpensePerUnitRate,
      'sellingExpensePerUnitAmount': sellingExpensePerUnitAmount,
    };
  }

  static MatexProfitAndLossCalculatorDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexProfitAndLossCalculatorDocument(
      entryFeeType: json['entryFeeType'] as String?,
      exitFeeType: json['exitFeeType'] as String?,
      taxRate: json['taxRate'] as String?,
      expectedSaleUnits: json['expectedSaleUnits'] as String?,
      buyingPrice: json['buyingPrice'] as String?,
      sellingPrice: json['sellingPrice'] as String?,
      operatingExpenses: json['operatingExpenses'] as String?,
      buyingExpensePerUnitRate: json['buyingExpensePerUnitRate'] as String?,
      buyingExpensePerUnitAmount: json['buyingExpensePerUnitAmount'] as String?,
      sellingExpensePerUnitRate: json['sellingExpensePerUnitRate'] as String?,
      sellingExpensePerUnitAmount:
          json['sellingExpensePerUnitAmount'] as String?,
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
        entryFeeType,
        exitFeeType,
      ];
}
