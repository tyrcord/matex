// Package imports:
import 'package:tmodel/tmodel.dart';

class MatexProfitAndLossCalculatorResults extends TModel {
  final double? revenue;
  final double? grossProfit;
  final double? operatingProfit;
  final double? netProfit;
  final double? taxAmount;
  final double? sellingExpenses;
  final double? returnOnInvestment;
  final int? breakEvenUnits;
  final double? costOfGoodsSold;
  final double? costOfInvestment;
  final double? grossProfitMargin;
  final double? netProfitMargin;

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
    this.costOfInvestment,
    this.grossProfitMargin,
    this.netProfitMargin,
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
    double? costOfInvestment,
    double? grossProfitMargin,
    double? netProfitMargin,
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
      costOfInvestment: costOfInvestment ?? this.costOfInvestment,
      grossProfitMargin: grossProfitMargin ?? this.grossProfitMargin,
      netProfitMargin: netProfitMargin ?? this.netProfitMargin,
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
      costOfInvestment: model.costOfInvestment,
      grossProfitMargin: model.grossProfitMargin,
      netProfitMargin: model.netProfitMargin,
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
        costOfInvestment,
        grossProfitMargin,
        netProfitMargin,
      ];
}
