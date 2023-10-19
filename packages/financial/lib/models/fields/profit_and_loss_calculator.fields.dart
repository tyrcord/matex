import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_forms/fastyle_forms.dart';

final String _kDefaultEntryFeeType = FastAmountSwitchFieldType.amount.name;
final String _kDefaultExitFeeType = FastAmountSwitchFieldType.amount.name;

class MatexProfitAndLossCalculatorBlocFields extends FastCalculatorFields {
  late final String? expectedUnitSales;
  late final String? buyPrice;
  late final String? sellPrice;
  late final String? fixedCosts;
  late final String? buyFeeRate;
  late final String? buyFeeAmount;
  late final String? sellFeeAmountPerUnit;
  late final String? sellFeeRatePerUnit;
  late final String? taxRate;
  late final String? entryFeeType;
  late final String? exitFeeType;

  MatexProfitAndLossCalculatorBlocFields({
    String? expectedUnitSales,
    String? buyPrice,
    String? sellPrice,
    String? fixedCosts,
    String? buyFeeRate,
    String? buyFeeAmount,
    String? sellFeeAmountPerUnit,
    String? sellFeeRatePerUnit,
    String? taxRate,
    String? entryFeeType,
    String? exitFeeType,
  }) {
    this.expectedUnitSales = assignValue(expectedUnitSales);
    this.buyPrice = assignValue(buyPrice);
    this.sellPrice = assignValue(sellPrice);
    this.fixedCosts = assignValue(fixedCosts);
    this.buyFeeRate = assignValue(buyFeeRate);
    this.buyFeeAmount = assignValue(buyFeeAmount);
    this.sellFeeAmountPerUnit = assignValue(sellFeeAmountPerUnit);
    this.sellFeeRatePerUnit = assignValue(sellFeeRatePerUnit);
    this.taxRate = assignValue(taxRate);
    this.entryFeeType = assignValue(entryFeeType) ?? _kDefaultEntryFeeType;
    this.exitFeeType = assignValue(exitFeeType) ?? _kDefaultExitFeeType;
  }

  @override
  MatexProfitAndLossCalculatorBlocFields clone() => copyWith();

  @override
  MatexProfitAndLossCalculatorBlocFields copyWith({
    String? expectedUnitSales,
    String? buyPrice,
    String? sellPrice,
    String? fixedCosts,
    String? buyFeeRate,
    String? buyFeeAmount,
    String? sellFeeAmountPerUnit,
    String? sellFeeRatePerUnit,
    String? taxRate,
    String? entryFeeType,
    String? exitFeeType,
  }) {
    return MatexProfitAndLossCalculatorBlocFields(
      expectedUnitSales: expectedUnitSales ?? this.expectedUnitSales,
      buyPrice: buyPrice ?? this.buyPrice,
      sellPrice: sellPrice ?? this.sellPrice,
      fixedCosts: fixedCosts ?? this.fixedCosts,
      buyFeeRate: buyFeeRate ?? this.buyFeeRate,
      buyFeeAmount: buyFeeAmount ?? this.buyFeeAmount,
      sellFeeAmountPerUnit: sellFeeAmountPerUnit ?? this.sellFeeAmountPerUnit,
      sellFeeRatePerUnit: sellFeeRatePerUnit ?? this.sellFeeRatePerUnit,
      taxRate: taxRate ?? this.taxRate,
      exitFeeType: exitFeeType ?? this.exitFeeType,
      entryFeeType: entryFeeType ?? this.entryFeeType,
    );
  }

  @override
  MatexProfitAndLossCalculatorBlocFields merge(
    covariant MatexProfitAndLossCalculatorBlocFields model,
  ) {
    return copyWith(
      expectedUnitSales: model.expectedUnitSales,
      buyPrice: model.buyPrice,
      sellPrice: model.sellPrice,
      fixedCosts: model.fixedCosts,
      buyFeeRate: model.buyFeeRate,
      buyFeeAmount: model.buyFeeAmount,
      sellFeeAmountPerUnit: model.sellFeeAmountPerUnit,
      sellFeeRatePerUnit: model.sellFeeRatePerUnit,
      taxRate: model.taxRate,
      exitFeeType: model.exitFeeType,
      entryFeeType: model.entryFeeType,
    );
  }

  @override
  List<Object?> get props => [
        expectedUnitSales,
        buyPrice,
        sellPrice,
        fixedCosts,
        buyFeeRate,
        buyFeeAmount,
        sellFeeAmountPerUnit,
        sellFeeRatePerUnit,
        taxRate,
        exitFeeType,
        entryFeeType,
      ];
}
