import 'package:matex_core/core.dart';

class MatexProfitAndLossCalculatorState extends MatexCalculatorState {
  final double? expectedSaleUnits;
  final double? buyingPrice;
  final double? sellingPrice;
  final double? operatingExpenses;
  final double? buyingExpensePerUnitRate;
  final double? sellingExpensePerUnitAmount;
  final double? sellingExpensePerUnitRate;
  final double? buyingExpensePerUnitAmount;
  final double? taxRate;

  const MatexProfitAndLossCalculatorState({
    this.expectedSaleUnits,
    this.buyingPrice,
    this.sellingPrice,
    this.operatingExpenses,
    this.buyingExpensePerUnitRate,
    this.sellingExpensePerUnitAmount,
    this.sellingExpensePerUnitRate,
    this.buyingExpensePerUnitAmount,
    this.taxRate,
  });

  @override
  MatexProfitAndLossCalculatorState clone() => copyWith();

  @override
  MatexProfitAndLossCalculatorState copyWith({
    double? expectedSaleUnits,
    double? buyingPrice,
    double? sellingPrice,
    double? operatingExpenses,
    double? buyingExpensePerUnitRate,
    double? sellingExpensePerUnitAmount,
    double? sellingExpensePerUnitRate,
    double? buyingExpensePerUnitAmount,
    double? taxRate,
  }) {
    return MatexProfitAndLossCalculatorState(
      expectedSaleUnits: expectedSaleUnits ?? this.expectedSaleUnits,
      buyingPrice: buyingPrice ?? this.buyingPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      operatingExpenses: operatingExpenses ?? this.operatingExpenses,
      buyingExpensePerUnitRate:
          buyingExpensePerUnitRate ?? this.buyingExpensePerUnitRate,
      sellingExpensePerUnitAmount:
          sellingExpensePerUnitAmount ?? this.sellingExpensePerUnitAmount,
      sellingExpensePerUnitRate:
          sellingExpensePerUnitRate ?? this.sellingExpensePerUnitRate,
      buyingExpensePerUnitAmount:
          buyingExpensePerUnitAmount ?? this.buyingExpensePerUnitAmount,
      taxRate: taxRate ?? this.taxRate,
    );
  }

  @override
  MatexProfitAndLossCalculatorState merge(
    covariant MatexProfitAndLossCalculatorState model,
  ) {
    return copyWith(
      expectedSaleUnits: model.expectedSaleUnits,
      buyingPrice: model.buyingPrice,
      sellingPrice: model.sellingPrice,
      operatingExpenses: model.operatingExpenses,
      buyingExpensePerUnitRate: model.buyingExpensePerUnitRate,
      sellingExpensePerUnitAmount: model.sellingExpensePerUnitAmount,
      sellingExpensePerUnitRate: model.sellingExpensePerUnitRate,
      buyingExpensePerUnitAmount: model.buyingExpensePerUnitAmount,
      taxRate: model.taxRate,
    );
  }

  @override
  List<Object?> get props => [
        expectedSaleUnits,
        buyingPrice,
        sellingPrice,
        operatingExpenses,
        buyingExpensePerUnitRate,
        sellingExpensePerUnitAmount,
        sellingExpensePerUnitRate,
        buyingExpensePerUnitAmount,
        taxRate,
      ];
}
