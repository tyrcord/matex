import 'package:decimal/decimal.dart';
import 'package:t_helpers/helpers.dart';
import 'package:tenhance/decimal.dart';

Decimal computeRevenue({
  double? expectedSaleUnits = 0,
  double? sellingPrice = 0,
}) {
  final dExpectedSaleUnits = toDecimalOrDefault(expectedSaleUnits);
  final dSellingPrice = toDecimalOrDefault(sellingPrice);

  return dExpectedSaleUnits * dSellingPrice;
}

Decimal computeCostOfGoodsSold({
  double? buyingExpensePerUnitAmount = 0,
  double? buyingExpensePerUnitRate = 0,
  double? expectedSaleUnits = 0,
  double? buyingPrice = 0,
}) {
  final dExpectedSaleUnits = toDecimalOrDefault(expectedSaleUnits);
  final dBuyingPrice = toDecimalOrDefault(buyingPrice);
  final dBuyingExpensePerUnitAmount =
      toDecimalOrDefault(buyingExpensePerUnitAmount);
  final dBuyingExpensePerUnitRate =
      toDecimalOrDefault(buyingExpensePerUnitRate);

  // Calculate the total buying expense per unit.
  final totalBuyingExpensePerUnit =
      dBuyingExpensePerUnitAmount + (dBuyingPrice * dBuyingExpensePerUnitRate);

  if (totalBuyingExpensePerUnit == dZero) {
    return dExpectedSaleUnits * dBuyingPrice;
  }

  return dExpectedSaleUnits * (dBuyingPrice + totalBuyingExpensePerUnit);
}

Decimal computeGrossProfit({
  double? costOfGoodsSold = 0,
  double? revenue = 0,
}) {
  final dCostOfGoodsSold = toDecimalOrDefault(costOfGoodsSold);
  final dRevenue = toDecimalOrDefault(revenue);

  return dRevenue - dCostOfGoodsSold;
}

// Calculates selling expenses
Decimal computSellingExpenses({
  double? sellingExpensePerUnitAmount = 0,
  double? sellingExpensePerUnitRate = 0,
  double? operatingExpenses = 0,
  double? expectedSaleUnits = 0,
  double? sellingPrice = 0,
}) {
  final dOperatingExpenses = toDecimalOrDefault(operatingExpenses);
  final dExpectedSaleUnits = toDecimalOrDefault(expectedSaleUnits);
  // The selling price is not required for calculating selling expenses
  // so it is removed from here.

  final dSellingExpensePerUnitAmount =
      toDecimalOrDefault(sellingExpensePerUnitAmount);
  final dSellingExpensePerUnitRate =
      toDecimalOrDefault(sellingExpensePerUnitRate);
  // This will be used for rate calculation.
  final dSellingPrice = toDecimalOrDefault(sellingPrice);

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

  return totalSellingExpenses + dOperatingExpenses;
}

// Calculates operating profit
Decimal computeOperatingProfit({
  double? grossProfit = 0,
  double? sellingExpenses = 0,
}) {
  final dGrossProfit = toDecimalOrDefault(grossProfit);
  final dSellingExpenses = toDecimalOrDefault(sellingExpenses);

  return dGrossProfit - dSellingExpenses;
}

// Calculates the tax amount
Decimal computeTaxAmount({
  double? operatingProfit = 0,
  double? taxRate = 0,
}) {
  final dOperatingProfit = toDecimalOrDefault(operatingProfit);
  final dTaxRate = toDecimalOrDefault(taxRate);

  if (dOperatingProfit <= dZero) return dZero; // Prevent negative tax amount

  return dOperatingProfit * dTaxRate;
}

// Calculates net profit
Decimal computeNetProfit({
  double? operatingProfit = 0,
  double? taxAmount = 0,
}) {
  final dOperatingProfit = toDecimalOrDefault(operatingProfit);
  final dTaxAmount = toDecimalOrDefault(taxAmount);

  return dOperatingProfit - dTaxAmount;
}

Decimal computeCostOfInvestment({
  double? sellingExpenses = 0,
  double? costOfGoodsSold = 0,
}) {
  final dSellingExpenses = toDecimalOrDefault(sellingExpenses);
  final dCostOfGoodsSold = toDecimalOrDefault(costOfGoodsSold);

  return dSellingExpenses + dCostOfGoodsSold;
}

// Calculates the return on investment
Decimal computeReturnOnInvestment({
  double? costOfInvestment = 0,
  double? netProfit = 0,
}) {
  if (costOfInvestment == 0) return dZero; // Prevent division by zero

  final dCostOfInvestment = toDecimalOrDefault(costOfInvestment);
  final dNetProfit = toDecimalOrDefault(netProfit);

  return decimalFromRational(dNetProfit / dCostOfInvestment);
}

// Calculates Gross Profit Margin
Decimal computeGrossProfitMargin({
  double? grossProfit = 0,
  double? revenue = 0,
}) {
  if (revenue == 0) return dZero; // Prevent division by zero

  final dGrossProfit = toDecimalOrDefault(grossProfit);
  final dRevenue = toDecimalOrDefault(revenue);

  return decimalFromRational((dGrossProfit / dRevenue));
}

// Calculates Net Profit Margin
Decimal computeNetProfitMargin({
  double? netProfit = 0,
  double? revenue = 0,
}) {
  if (revenue == 0) return dZero; // Prevent division by zero

  final dNetProfit = toDecimalOrDefault(netProfit);
  final dRevenue = toDecimalOrDefault(revenue);

  return decimalFromRational((dNetProfit / dRevenue));
}

// Calculates the break-even units
Decimal computeBreakEvenUnits({
  double? sellingExpensePerUnitAmount = 0,
  double? buyingExpensePerUnitAmount = 0,
  double? sellingExpensePerUnitRate = 0,
  double? buyingExpensePerUnitRate = 0,
  double? operatingExpenses = 0,
  double? sellingPrice = 0,
  double? buyingPrice = 0,
}) {
  final dOperatingExpenses = toDecimalOrDefault(operatingExpenses);
  final dFixedCosts = dOperatingExpenses; // Total fixed costs
  final dSellingPrice = toDecimalOrDefault(sellingPrice);
  final dBuyingPrice = toDecimalOrDefault(buyingPrice);
  final dBuyingExpensePerUnitAmount =
      toDecimalOrDefault(buyingExpensePerUnitAmount);
  final dBuyingExpensePerUnitRate =
      toDecimalOrDefault(buyingExpensePerUnitRate);
  final dSellingExpensePerUnitAmount =
      toDecimalOrDefault(sellingExpensePerUnitAmount);
  final dSellingExpensePerUnitRate =
      toDecimalOrDefault(sellingExpensePerUnitRate);

  // Calculate the total buying expense per unit.
  final totalBuyingExpensePerUnit =
      dBuyingExpensePerUnitAmount + (dBuyingPrice * dBuyingExpensePerUnitRate);

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

double computeRiskRewardRatio({
  double? rewardAmount,
  double? riskAmount,
}) {
  final dStopLossAmount = toDecimalOrDefault(riskAmount);
  final dTakeProfitAmount = toDecimalOrDefault(rewardAmount);
  var ratio = 0.0;

  if (dStopLossAmount == dZero) return ratio; // Prevent division by zero

  if (dTakeProfitAmount != dStopLossAmount) {
    ratio =
        decimalFromRational(dTakeProfitAmount / dStopLossAmount).toSafeDouble();
  } else {
    ratio = 1.0;
  }

  return ratio;
}
