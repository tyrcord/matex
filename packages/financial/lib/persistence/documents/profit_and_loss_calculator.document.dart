import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_forms/fastyle_forms.dart';
import 'package:matex_financial/financial.dart';

final String _kDefaultEntryFeeType = FastAmountSwitchFieldType.amount.name;
final String _kDefaultExitFeeType = FastAmountSwitchFieldType.amount.name;

class MatexProfitAndLossCalculatorDocument extends FastCalculatorDocument {
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

  MatexProfitAndLossCalculatorDocument({
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
  MatexProfitAndLossCalculatorDocument clone() => copyWith();

  @override
  MatexProfitAndLossCalculatorDocument copyWith({
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
    return MatexProfitAndLossCalculatorDocument(
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
  MatexProfitAndLossCalculatorDocument merge(
    covariant MatexProfitAndLossCalculatorDocument model,
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
  MatexProfitAndLossCalculatorBlocFields toFields() {
    return MatexProfitAndLossCalculatorBlocFields(
      expectedUnitSales: expectedUnitSales,
      buyPrice: buyPrice,
      sellPrice: sellPrice,
      fixedCosts: fixedCosts,
      buyFeeRate: buyFeeRate,
      buyFeeAmount: buyFeeAmount,
      sellFeeAmountPerUnit: sellFeeAmountPerUnit,
      sellFeeRatePerUnit: sellFeeRatePerUnit,
      taxRate: taxRate,
      entryFeeType: entryFeeType,
      exitFeeType: exitFeeType,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'buyFeeRate': buyFeeRate,
      'entryFeeType': entryFeeType,
      'exitFeeType': exitFeeType,
      'sellFeeRatePerUnit': sellFeeRatePerUnit,
      'buyFeeAmount': buyFeeAmount,
      'sellFeeAmountPerUnit': sellFeeAmountPerUnit,
      'expectedUnitSales': expectedUnitSales,
      'fixedCosts': fixedCosts,
      'buyPrice': buyPrice,
      'sellPrice': sellPrice,
      'taxRate': taxRate,
    };
  }

  static MatexProfitAndLossCalculatorDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexProfitAndLossCalculatorDocument(
      entryFeeType: json['entryFeeType'] as String?,
      exitFeeType: json['exitFeeType'] as String?,
      expectedUnitSales: json['expectedUnitSales'] as String?,
      buyPrice: json['buyPrice'] as String?,
      sellPrice: json['sellPrice'] as String?,
      fixedCosts: json['fixedCosts'] as String?,
      buyFeeRate: json['buyFeeRate'] as String?,
      buyFeeAmount: json['buyFeeAmount'] as String?,
      sellFeeAmountPerUnit: json['sellFeeAmountPerUnit'] as String?,
      sellFeeRatePerUnit: json['sellFeeRatePerUnit'] as String?,
      taxRate: json['taxRate'] as String?,
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
        entryFeeType,
        exitFeeType,
      ];
}
