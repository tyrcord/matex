import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_forms/fastyle_forms.dart';

final String _kDefaultEntryFeeType = FastAmountSwitchFieldType.amount.name;
final String _kDefaultExitFeeType = FastAmountSwitchFieldType.amount.name;

class MatexProfitAndLossCalculatorBlocFields extends FastCalculatorFields {
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
  MatexProfitAndLossCalculatorBlocFields clone() => copyWith();

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
      exitFeeType: sellingCostsPerUnitType ?? this.exitFeeType,
      entryFeeType: buyingCostsPerUnitType ?? this.entryFeeType,
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
      sellingCostsPerUnitType: model.exitFeeType,
      buyingCostsPerUnitType: model.entryFeeType,
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
        exitFeeType,
        entryFeeType,
      ];
}
