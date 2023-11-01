// Package imports:
import 'package:decimal/decimal.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';

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
    final dExpectedSaleUnits = toDecimal(state.expectedSaleUnits) ?? dZero;
    final dSellingPrice = toDecimal(state.sellingPrice) ?? dZero;

    return dExpectedSaleUnits * dSellingPrice;
  }

// Calculates the cost of goods sold
  Decimal get costOfGoodsSold {
    final dExpectedSaleUnits = toDecimal(state.expectedSaleUnits) ?? dZero;
    final dBuyingPrice = toDecimal(state.buyingPrice) ?? dZero;
    final dBuyingExpensePerUnitAmount =
        toDecimal(state.buyingExpensePerUnitAmount) ?? dZero;
    final dBuyingExpensePerUnitRate =
        toDecimal(state.buyingExpensePerUnitRate) ?? dZero;

    // Calculate the total buying expense per unit.
    final totalBuyingExpensePerUnit = dBuyingExpensePerUnitAmount +
        (dBuyingPrice * dBuyingExpensePerUnitRate);

    if (totalBuyingExpensePerUnit == dZero) {
      return dExpectedSaleUnits * dBuyingPrice;
    }

    return dExpectedSaleUnits * (dBuyingPrice + totalBuyingExpensePerUnit);
  }

// Calculates gross profit
  Decimal get grossProfit => revenue - costOfGoodsSold;

// Calculates selling expenses
  Decimal get sellingExpenses {
    final operatingExpenses = toDecimal(state.operatingExpenses) ?? dZero;
    final dExpectedSaleUnits = toDecimal(state.expectedSaleUnits) ?? dZero;
    // The selling price is not required for calculating selling expenses
    // so it is removed from here.

    final dSellingExpensePerUnitAmount =
        toDecimal(state.sellingExpensePerUnitAmount) ?? dZero;
    final dSellingExpensePerUnitRate =
        toDecimal(state.sellingExpensePerUnitRate) ?? dZero;
    final dSellingPrice = toDecimal(state.sellingPrice) ??
        dZero; // This will be used for rate calculation.

    // Calculate the total selling expense per unit, considering both a fixed
    // amount and a rate.
    final totalSellingExpensePerUnitAmount = dSellingExpensePerUnitAmount;
    final totalSellingExpensePerUnitRate =
        dSellingPrice * dSellingExpensePerUnitRate;

    // Total selling expenses are the sum of the fixed and rate-based expenses
    // for each unit sold. It is not related to the selling price,
    // so we should not add it to the selling price.
    final totalSellingExpenses = dExpectedSaleUnits *
        (totalSellingExpensePerUnitAmount + totalSellingExpensePerUnitRate);

    return totalSellingExpenses + operatingExpenses;
  }

// Calculates operating profit
  Decimal get operatingProfit => grossProfit - sellingExpenses;

// Calculates the tax amount
  Decimal get taxAmount {
    final dTaxRate = toDecimal(state.taxRate) ?? dZero;

    return operatingProfit * dTaxRate;
  }

// Calculates net profit
  Decimal get netProfit {
    return operatingProfit - taxAmount;
  }

  Decimal get totalExpenses => sellingExpenses + costOfGoodsSold;

// Calculates the return on investment
  Decimal get returnOnInvestment {
    final costOfInvestment = totalExpenses + taxAmount;

    if (costOfInvestment == dZero) return dZero; // Prevent division by zero

    return decimalFromRational(netProfit / costOfInvestment);
  }

// Calculates the break-even units
  Decimal get breakEvenUnits {
    final operatingExpenses = toDecimal(state.operatingExpenses) ?? dZero;
    final dFixedCosts = operatingExpenses; // Total fixed costs
    final dSellingPrice = toDecimal(state.sellingPrice) ?? dZero;
    final dBuyingPrice = toDecimal(state.buyingPrice) ?? dZero;
    final dBuyingExpensePerUnitAmount =
        toDecimal(state.buyingExpensePerUnitAmount) ?? dZero;
    final dBuyingExpensePerUnitRate =
        toDecimal(state.buyingExpensePerUnitRate) ?? dZero;
    final dSellingExpensePerUnitAmount =
        toDecimal(state.sellingExpensePerUnitAmount) ?? dZero;
    final dSellingExpensePerUnitRate =
        toDecimal(state.sellingExpensePerUnitRate) ?? dZero;

    // Calculate the total buying expense per unit.
    final totalBuyingExpensePerUnit = dBuyingExpensePerUnitAmount +
        (dBuyingPrice * dBuyingExpensePerUnitRate);

    // Calculate the total selling expense per unit.
    final totalSellingExpensePerUnit = dSellingExpensePerUnitAmount +
        (dSellingPrice * dSellingExpensePerUnitRate);

    // Calculate total variable cost per unit.
    final totalVariableCostPerUnit =
        dBuyingPrice + totalBuyingExpensePerUnit + totalSellingExpensePerUnit;

// Prevent division by zero
    if (dSellingPrice - totalVariableCostPerUnit == dZero) return dZero;

    // The formula for break-even units is: Fixed Costs / (Selling Price - Variable Cost per Unit)
    return decimalFromRational(
      dFixedCosts / (dSellingPrice - totalVariableCostPerUnit),
    );
  }

  @override
  MatexProfitAndLossCalculatorResults value() {
    if (!isValid) return defaultResults;

    return MatexProfitAndLossCalculatorResults(
      costOfGoodsSold: costOfGoodsSold.toDouble(),
      revenue: revenue.toDouble(),
      grossProfit: grossProfit.toDouble(),
      operatingProfit: operatingProfit.toDouble(),
      netProfit: netProfit.toDouble(),
      taxAmount: taxAmount.toDouble(),
      sellingExpenses: sellingExpenses.toDouble(),
      returnOnInvestment: returnOnInvestment.toDouble(),
      breakEvenUnits: breakEvenUnits.toDouble().ceil(),
    );
  }
}
