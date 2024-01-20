// Package imports:
import 'package:decimal/decimal.dart';
import 'package:matex_core/core.dart';
import 'package:tenhance/decimal.dart';

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
      costOfGoodsSold: costOfGoodsSold.toSafeDouble(),
      revenue: revenue.toSafeDouble(),
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
      sellingExpenses: sellingExpenses.toSafeDouble(),
      grossProfit: grossProfit.toSafeDouble(),
    );
  }

  // Calculates the tax amount
  Decimal get taxAmount {
    return computeTaxAmount(
      operatingProfit: operatingProfit.toSafeDouble(),
      taxRate: state.taxRate,
    );
  }

  // Calculates net profit
  Decimal get netProfit {
    return computeNetProfit(
      operatingProfit: operatingProfit.toSafeDouble(),
      taxAmount: taxAmount.toSafeDouble(),
    );
  }

  Decimal get costOfInvestment {
    return computeCostOfInvestment(
      sellingExpenses: sellingExpenses.toSafeDouble(),
      costOfGoodsSold: costOfGoodsSold.toSafeDouble(),
    );
  }

  // Calculates the return on investment
  Decimal get returnOnInvestment {
    return computeReturnOnInvestment(
      costOfInvestment: costOfInvestment.toSafeDouble(),
      netProfit: netProfit.toSafeDouble(),
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
      grossProfit: grossProfit.toSafeDouble(),
      revenue: revenue.toSafeDouble(),
    );
  }

  // Calculates Net Profit Margin
  Decimal get netProfitMargin {
    return computeNetProfitMargin(
      netProfit: netProfit.toSafeDouble(),
      revenue: revenue.toSafeDouble(),
    );
  }

  @override
  MatexProfitAndLossCalculatorResults value() {
    if (!isValid) return defaultResults;

    return MatexProfitAndLossCalculatorResults(
      returnOnInvestment: returnOnInvestment.toSafeDouble(),
      breakEvenUnits: breakEvenUnits.toSafeDouble().ceil(),
      grossProfitMargin: grossProfitMargin.toSafeDouble(),
      costOfInvestment: costOfInvestment.toSafeDouble(),
      costOfGoodsSold: costOfGoodsSold.toSafeDouble(),
      sellingExpenses: sellingExpenses.toSafeDouble(),
      netProfitMargin: netProfitMargin.toSafeDouble(),
      operatingProfit: operatingProfit.toSafeDouble(),
      grossProfit: grossProfit.toSafeDouble(),
      netProfit: netProfit.toSafeDouble(),
      taxAmount: taxAmount.toSafeDouble(),
      revenue: revenue.toSafeDouble(),
    );
  }
}
