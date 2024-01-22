// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexProfitAndLossCalculator extends MatexCalculator<
    MatexProfitAndLossCalculatorState, MatexProfitAndLossCalculatorResults> {
  MatexProfitAndLossCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: profitAndLossValidators);

  @override
  MatexProfitAndLossCalculatorState initializeState() =>
      const MatexProfitAndLossCalculatorState();

  @override
  MatexProfitAndLossCalculatorState initializeDefaultState() =>
      initializeState();

  set expectedSaleUnits(double? value) {
    setState(state.copyWith(expectedSaleUnits: value));
  }

  set buyingPrice(double? value) {
    setState(state.copyWith(buyingPrice: value));
  }

  set sellingPrice(double? value) {
    setState(state.copyWith(sellingPrice: value));
  }

  set operatingExpenses(double? value) {
    setState(state.copyWith(operatingExpenses: value));
  }

  set buyingExpensePerUnitAmount(double? value) {
    setState(state.copyWith(buyingExpensePerUnitAmount: value));
  }

  set buyingExpensePerUnitRate(double? value) {
    setState(state.copyWith(buyingExpensePerUnitRate: value));
  }

  set sellingExpensePerUnitAmount(double? value) {
    setState(state.copyWith(sellingExpensePerUnitAmount: value));
  }

  set sellingExpensePerUnitRate(double? value) {
    setState(state.copyWith(sellingExpensePerUnitRate: value));
  }

  set taxRate(double? value) {
    setState(state.copyWith(taxRate: value));
  }

  static const defaultResults = MatexProfitAndLossCalculatorResults(
    returnOnInvestment: 0,
    netProfit: 0,
  );

  // Calculates the total revenue
  double get revenue {
    return computeRevenue(
      expectedSaleUnits: state.expectedSaleUnits,
      sellingPrice: state.sellingPrice,
    );
  }

  // Calculates the cost of goods sold
  double get costOfGoodsSold {
    return computeCostOfGoodsSold(
      buyingExpensePerUnitAmount: state.buyingExpensePerUnitAmount,
      buyingExpensePerUnitRate: state.buyingExpensePerUnitRate,
      expectedSaleUnits: state.expectedSaleUnits,
      buyingPrice: state.buyingPrice,
    );
  }

  // Calculates gross profit
  double get grossProfit {
    return computeGrossProfit(
      costOfGoodsSold: costOfGoodsSold,
      revenue: revenue,
    );
  }

  // Calculates selling expenses
  double get sellingExpenses {
    return computSellingExpenses(
      sellingExpensePerUnitAmount: state.sellingExpensePerUnitAmount,
      sellingExpensePerUnitRate: state.sellingExpensePerUnitRate,
      operatingExpenses: state.operatingExpenses,
      expectedSaleUnits: state.expectedSaleUnits,
      sellingPrice: state.sellingPrice,
    );
  }

  // Calculates operating profit
  double get operatingProfit {
    return computeOperatingProfit(
      sellingExpenses: sellingExpenses,
      grossProfit: grossProfit,
    );
  }

  // Calculates the tax amount
  double get taxAmount {
    return computeTaxAmount(
      operatingProfit: operatingProfit,
      taxRate: state.taxRate,
    );
  }

  // Calculates net profit
  double get netProfit {
    return computeNetProfit(
      operatingProfit: operatingProfit,
      taxAmount: taxAmount,
    );
  }

  double get costOfInvestment {
    return computeCostOfInvestment(
      sellingExpenses: sellingExpenses,
      costOfGoodsSold: costOfGoodsSold,
    );
  }

  // Calculates the return on investment
  double get returnOnInvestment {
    return computeReturnOnInvestment(
      costOfInvestment: costOfInvestment,
      netProfit: netProfit,
    );
  }

  // Calculates the break-even units
  double get breakEvenUnits {
    return computeBreakEvenUnits(
      sellingExpensePerUnitAmount: state.sellingExpensePerUnitAmount,
      buyingExpensePerUnitAmount: state.buyingExpensePerUnitAmount,
      sellingExpensePerUnitRate: state.sellingExpensePerUnitRate,
      buyingExpensePerUnitRate: state.buyingExpensePerUnitRate,
      operatingExpenses: state.operatingExpenses,
      sellingPrice: state.sellingPrice,
      buyingPrice: state.buyingPrice,
    );
  }

  // Calculates Gross Profit Margin
  double get grossProfitMargin {
    return computeGrossProfitMargin(grossProfit: grossProfit, revenue: revenue);
  }

  // Calculates Net Profit Margin
  double get netProfitMargin {
    return computeNetProfitMargin(netProfit: netProfit, revenue: revenue);
  }

  @override
  MatexProfitAndLossCalculatorResults value() {
    if (!isValid) return defaultResults;

    return MatexProfitAndLossCalculatorResults(
      returnOnInvestment: returnOnInvestment,
      breakEvenUnits: breakEvenUnits.ceil(),
      grossProfitMargin: grossProfitMargin,
      costOfInvestment: costOfInvestment,
      costOfGoodsSold: costOfGoodsSold,
      sellingExpenses: sellingExpenses,
      netProfitMargin: netProfitMargin,
      operatingProfit: operatingProfit,
      grossProfit: grossProfit,
      netProfit: netProfit,
      taxAmount: taxAmount,
      revenue: revenue,
    );
  }
}
