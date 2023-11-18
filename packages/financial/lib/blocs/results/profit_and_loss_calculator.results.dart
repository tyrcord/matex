// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexProfitAndLossCalculatorBlocResults extends FastCalculatorResults {
  final double? revenue;
  final double? grossProfit;
  final double? operatingProfit;
  final double? taxAmount;
  final double? sellingExpenses;
  final double? netProfit;
  final double? returnOnInvestment;
  final int? breakEvenUnits;
  final double? costOfGoodsSold;

  final String? formattedRevenue;
  final String? formattedGrossProfit;
  final String? formattedOperatingProfit;
  final String? formattedTaxAmount;
  final String? formattedSellingExpenses;
  final String? formattedNetProfit;
  final String? formattedReturnOnInvestment;
  final String? formattedBreakEvenUnits;
  final String? formattedCostOfGoodsSold;

  const MatexProfitAndLossCalculatorBlocResults({
    this.revenue,
    this.grossProfit,
    this.operatingProfit,
    this.taxAmount,
    this.sellingExpenses,
    this.netProfit,
    this.returnOnInvestment,
    this.breakEvenUnits,
    this.costOfGoodsSold,
    this.formattedRevenue,
    this.formattedGrossProfit,
    this.formattedOperatingProfit,
    this.formattedTaxAmount,
    this.formattedSellingExpenses,
    this.formattedNetProfit,
    this.formattedReturnOnInvestment,
    this.formattedBreakEvenUnits,
    this.formattedCostOfGoodsSold,
  });

  @override
  MatexProfitAndLossCalculatorBlocResults clone() => copyWith();

  @override
  MatexProfitAndLossCalculatorBlocResults copyWith({
    double? revenue,
    double? grossProfit,
    double? operatingProfit,
    double? taxAmount,
    double? sellingExpenses,
    double? netProfit,
    double? returnOnInvestment,
    int? breakEvenUnits,
    double? costOfGoodsSold,
    String? formattedRevenue,
    String? formattedGrossProfit,
    String? formattedOperatingProfit,
    String? formattedTaxAmount,
    String? formattedSellingExpenses,
    String? formattedNetProfit,
    String? formattedReturnOnInvestment,
    String? formattedBreakEvenUnits,
    String? formattedCostOfGoodsSold,
  }) {
    return MatexProfitAndLossCalculatorBlocResults(
      revenue: revenue ?? this.revenue,
      grossProfit: grossProfit ?? this.grossProfit,
      operatingProfit: operatingProfit ?? this.operatingProfit,
      taxAmount: taxAmount ?? this.taxAmount,
      sellingExpenses: sellingExpenses ?? this.sellingExpenses,
      netProfit: netProfit ?? this.netProfit,
      returnOnInvestment: returnOnInvestment ?? this.returnOnInvestment,
      breakEvenUnits: breakEvenUnits ?? this.breakEvenUnits,
      costOfGoodsSold: costOfGoodsSold ?? this.costOfGoodsSold,
      formattedRevenue: formattedRevenue ?? this.formattedRevenue,
      formattedGrossProfit: formattedGrossProfit ?? this.formattedGrossProfit,
      formattedOperatingProfit:
          formattedOperatingProfit ?? this.formattedOperatingProfit,
      formattedTaxAmount: formattedTaxAmount ?? this.formattedTaxAmount,
      formattedSellingExpenses:
          formattedSellingExpenses ?? this.formattedSellingExpenses,
      formattedNetProfit: formattedNetProfit ?? this.formattedNetProfit,
      formattedReturnOnInvestment:
          formattedReturnOnInvestment ?? this.formattedReturnOnInvestment,
      formattedBreakEvenUnits:
          formattedBreakEvenUnits ?? this.formattedBreakEvenUnits,
      formattedCostOfGoodsSold:
          formattedCostOfGoodsSold ?? this.formattedCostOfGoodsSold,
    );
  }

  @override
  MatexProfitAndLossCalculatorBlocResults merge(
    covariant MatexProfitAndLossCalculatorBlocResults model,
  ) {
    return copyWith(
      revenue: model.revenue,
      grossProfit: model.grossProfit,
      operatingProfit: model.operatingProfit,
      taxAmount: model.taxAmount,
      sellingExpenses: model.sellingExpenses,
      netProfit: model.netProfit,
      returnOnInvestment: model.returnOnInvestment,
      breakEvenUnits: model.breakEvenUnits,
      costOfGoodsSold: model.costOfGoodsSold,
      formattedRevenue: model.formattedRevenue,
      formattedGrossProfit: model.formattedGrossProfit,
      formattedOperatingProfit: model.formattedOperatingProfit,
      formattedTaxAmount: model.formattedTaxAmount,
      formattedSellingExpenses: model.formattedSellingExpenses,
      formattedNetProfit: model.formattedNetProfit,
      formattedReturnOnInvestment: model.formattedReturnOnInvestment,
      formattedBreakEvenUnits: model.formattedBreakEvenUnits,
      formattedCostOfGoodsSold: model.formattedCostOfGoodsSold,
    );
  }

  @override
  List<Object?> get props => [
        revenue,
        grossProfit,
        operatingProfit,
        taxAmount,
        sellingExpenses,
        netProfit,
        returnOnInvestment,
        breakEvenUnits,
        costOfGoodsSold,
        formattedRevenue,
        formattedGrossProfit,
        formattedOperatingProfit,
        formattedTaxAmount,
        formattedSellingExpenses,
        formattedNetProfit,
        formattedReturnOnInvestment,
        formattedBreakEvenUnits,
        formattedCostOfGoodsSold,
      ];
}
