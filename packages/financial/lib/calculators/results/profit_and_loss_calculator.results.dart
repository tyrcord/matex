import 'package:matex_core/core.dart';

class MatexProfitAndLossCalculatorResults extends MatexCalculatorState {
  final double? revenue;
  final double? grossProfit;
  final double? operatingProfit;
  final double? netProfit;
  final double? taxAmount;
  final double? sellingExpenses;
  final double? returnOnInvestment;
  final int? breakEvenUnits;
  final double? costOfGoodsSold;

  const MatexProfitAndLossCalculatorResults({
    this.revenue,
    this.operatingProfit,
    this.grossProfit,
    this.netProfit,
    this.taxAmount,
    this.sellingExpenses,
    this.returnOnInvestment,
    this.breakEvenUnits,
    this.costOfGoodsSold,
  });

  @override
  MatexProfitAndLossCalculatorResults clone() => copyWith();

  @override
  MatexProfitAndLossCalculatorResults copyWith({
    double? revenue,
    double? grossProfit,
    double? operatingProfit,
    double? netProfit,
    double? taxAmount,
    double? sellingExpenses,
    double? returnOnInvestment,
    int? breakEvenUnits,
    double? costOfGoodsSold,
  }) {
    return MatexProfitAndLossCalculatorResults(
      returnOnInvestment: returnOnInvestment ?? this.returnOnInvestment,
      sellingExpenses: sellingExpenses ?? this.sellingExpenses,
      operatingProfit: operatingProfit ?? this.operatingProfit,
      breakEvenUnits: breakEvenUnits ?? this.breakEvenUnits,
      grossProfit: grossProfit ?? this.grossProfit,
      netProfit: netProfit ?? this.netProfit,
      taxAmount: taxAmount ?? this.taxAmount,
      revenue: revenue ?? this.revenue,
      costOfGoodsSold: costOfGoodsSold ?? this.costOfGoodsSold,
    );
  }

  @override
  MatexProfitAndLossCalculatorResults merge(
    covariant MatexProfitAndLossCalculatorResults model,
  ) {
    return copyWith(
      revenue: model.revenue,
      operatingProfit: model.operatingProfit,
      grossProfit: model.grossProfit,
      netProfit: model.netProfit,
      taxAmount: model.taxAmount,
      sellingExpenses: model.sellingExpenses,
      returnOnInvestment: model.returnOnInvestment,
      breakEvenUnits: model.breakEvenUnits,
      costOfGoodsSold: model.costOfGoodsSold,
    );
  }

  @override
  List<Object?> get props => [
        revenue,
        operatingProfit,
        grossProfit,
        netProfit,
        taxAmount,
        sellingExpenses,
        returnOnInvestment,
        breakEvenUnits,
        costOfGoodsSold,
      ];
}
