// Package imports:
import 'package:decimal/decimal.dart';
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
  Decimal get revenue {
    return computeRevenue(
      expectedSaleUnits: state.expectedSaleUnits,
      sellingPrice: state.sellingPrice,
    );
  }

  // Calculates the cost of goods sold
  Decimal get costOfGoodsSold {
    return computeCostOfGoodsSold(
      buyingExpensePerUnitAmount: state.buyingExpensePerUnitAmount,
      buyingExpensePerUnitRate: state.buyingExpensePerUnitRate,
      expectedSaleUnits: state.expectedSaleUnits,
      buyingPrice: state.buyingPrice,
    );
  }

  // Calculates gross profit
  Decimal get grossProfit {
    return computeGrossProfit(
      costOfGoodsSold: costOfGoodsSold.toDouble(),
      revenue: revenue.toDouble(),
    );
  }

  // Calculates selling expenses
  Decimal get sellingExpenses {
    return computSellingExpenses(
      sellingExpensePerUnitAmount: state.sellingExpensePerUnitAmount,
      sellingExpensePerUnitRate: state.sellingExpensePerUnitRate,
      operatingExpenses: state.operatingExpenses,
      expectedSaleUnits: state.expectedSaleUnits,
      sellingPrice: state.sellingPrice,
    );
  }

  // Calculates operating profit
  Decimal get operatingProfit {
    return computeOperatingProfit(
      sellingExpenses: sellingExpenses.toDouble(),
      grossProfit: grossProfit.toDouble(),
    );
  }

  // Calculates the tax amount
  Decimal get taxAmount {
    return computeTaxAmount(
      operatingProfit: operatingProfit.toDouble(),
      taxRate: state.taxRate,
    );
  }

  // Calculates net profit
  Decimal get netProfit {
    return computeNetProfit(
      operatingProfit: operatingProfit.toDouble(),
      taxAmount: taxAmount.toDouble(),
    );
  }

  Decimal get costOfInvestment {
    return computeCostOfInvestment(
      sellingExpenses: sellingExpenses.toDouble(),
      costOfGoodsSold: costOfGoodsSold.toDouble(),
    );
  }

  // Calculates the return on investment
  Decimal get returnOnInvestment {
    return computeReturnOnInvestment(
      costOfInvestment: costOfInvestment.toDouble(),
      netProfit: netProfit.toDouble(),
    );
  }

  // Calculates the break-even units
  Decimal get breakEvenUnits {
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
  Decimal get grossProfitMargin {
    return computeGrossProfitMargin(
      grossProfit: grossProfit.toDouble(),
      revenue: revenue.toDouble(),
    );
  }

  // Calculates Net Profit Margin
  Decimal get netProfitMargin {
    return computeNetProfitMargin(
      netProfit: netProfit.toDouble(),
      revenue: revenue.toDouble(),
    );
  }

  @override
  MatexProfitAndLossCalculatorResults value() {
    if (!isValid) return defaultResults;

    return MatexProfitAndLossCalculatorResults(
      returnOnInvestment: returnOnInvestment.toDouble(),
      breakEvenUnits: breakEvenUnits.toDouble().ceil(),
      grossProfitMargin: grossProfitMargin.toDouble(),
      costOfInvestment: costOfInvestment.toDouble(),
      costOfGoodsSold: costOfGoodsSold.toDouble(),
      sellingExpenses: sellingExpenses.toDouble(),
      netProfitMargin: netProfitMargin.toDouble(),
      operatingProfit: operatingProfit.toDouble(),
      grossProfit: grossProfit.toDouble(),
      netProfit: netProfit.toDouble(),
      taxAmount: taxAmount.toDouble(),
      revenue: revenue.toDouble(),
    );
  }
}
