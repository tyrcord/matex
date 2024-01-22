double computeRevenue({
  double? expectedSaleUnits = 0,
  double? sellingPrice = 0,
}) {
  expectedSaleUnits ??= 0;
  sellingPrice ??= 0;

  return expectedSaleUnits * sellingPrice;
}

double computeCostOfGoodsSold({
  double? buyingExpensePerUnitAmount = 0,
  double? buyingExpensePerUnitRate = 0,
  double? expectedSaleUnits = 0,
  double? buyingPrice = 0,
}) {
  buyingExpensePerUnitAmount ??= 0;
  buyingExpensePerUnitRate ??= 0;
  expectedSaleUnits ??= 0;
  buyingPrice ??= 0;

  // Calculate the total buying expense per unit.
  final totalBuyingExpensePerUnit =
      buyingExpensePerUnitAmount + (buyingPrice * buyingExpensePerUnitRate);

  if (totalBuyingExpensePerUnit == 0) {
    return expectedSaleUnits * buyingPrice;
  }

  return expectedSaleUnits * (buyingPrice + totalBuyingExpensePerUnit);
}

double computeGrossProfit({
  double? costOfGoodsSold = 0,
  double? revenue = 0,
}) {
  costOfGoodsSold ??= 0;
  revenue ??= 0;

  return revenue - costOfGoodsSold;
}

// Calculates selling expenses
double computSellingExpenses({
  double? sellingExpensePerUnitAmount = 0,
  double? sellingExpensePerUnitRate = 0,
  double? operatingExpenses = 0,
  double? expectedSaleUnits = 0,
  double? sellingPrice = 0,
}) {
  sellingExpensePerUnitAmount ??= 0;
  sellingExpensePerUnitRate ??= 0;
  operatingExpenses ??= 0;
  expectedSaleUnits ??= 0;
  sellingPrice ??= 0;

  // Calculate the total selling expense per unit, considering both a fixed
  // amount and a rate.
  final totalSellingExpensePerUnitAmount = sellingExpensePerUnitAmount;
  final totalSellingExpensePerUnitRate =
      sellingPrice * sellingExpensePerUnitRate;

  // Total selling expenses are the sum of the fixed and rate-based expenses
  // for each unit sold. It is not related to the selling price,
  // so we should not add it to the selling price.
  final totalSellingExpenses = expectedSaleUnits *
      (totalSellingExpensePerUnitAmount + totalSellingExpensePerUnitRate);

  return totalSellingExpenses + operatingExpenses;
}

// Calculates operating profit
double computeOperatingProfit({
  double? grossProfit = 0,
  double? sellingExpenses = 0,
}) {
  grossProfit ??= 0;
  sellingExpenses ??= 0;

  return grossProfit - sellingExpenses;
}

// Calculates the tax amount
double computeTaxAmount({
  double? operatingProfit = 0,
  double? taxRate = 0,
}) {
  operatingProfit ??= 0;
  taxRate ??= 0;

  if (operatingProfit <= 0) return 0; // Prevent negative tax amount

  return operatingProfit * taxRate;
}

// Calculates net profit
double computeNetProfit({
  double? operatingProfit = 0,
  double? taxAmount = 0,
}) {
  operatingProfit ??= 0;
  taxAmount ??= 0;

  return operatingProfit - taxAmount;
}

double computeCostOfInvestment({
  double? sellingExpenses = 0,
  double? costOfGoodsSold = 0,
}) {
  sellingExpenses ??= 0;
  costOfGoodsSold ??= 0;

  return sellingExpenses + costOfGoodsSold;
}

// Calculates the return on investment
double computeReturnOnInvestment({
  double? costOfInvestment = 0,
  double? netProfit = 0,
}) {
  costOfInvestment ??= 0;
  netProfit ??= 0;

  if (costOfInvestment == 0) return 0; // Prevent division by zero

  return netProfit / costOfInvestment;
}

// Calculates Gross Profit Margin
double computeGrossProfitMargin({
  double? grossProfit = 0,
  double? revenue = 0,
}) {
  grossProfit ??= 0;
  revenue ??= 0;

  if (revenue == 0) return 0; // Prevent division by zero

  return grossProfit / revenue;
}

// Calculates Net Profit Margin
double computeNetProfitMargin({
  double? netProfit = 0,
  double? revenue = 0,
}) {
  netProfit ??= 0;
  revenue ??= 0;

  if (revenue == 0) return 0; // Prevent division by zero

  return netProfit / revenue;
}

// Calculates the break-even units
double computeBreakEvenUnits({
  double? sellingExpensePerUnitAmount = 0,
  double? buyingExpensePerUnitAmount = 0,
  double? sellingExpensePerUnitRate = 0,
  double? buyingExpensePerUnitRate = 0,
  double? operatingExpenses = 0,
  double? sellingPrice = 0,
  double? buyingPrice = 0,
}) {
  operatingExpenses ??= 0;
  final fixedCosts = operatingExpenses; // Total fixed costs

  sellingExpensePerUnitAmount ??= 0;
  sellingExpensePerUnitRate ??= 0;
  buyingExpensePerUnitAmount ??= 0;
  buyingExpensePerUnitRate ??= 0;
  sellingPrice ??= 0;
  buyingPrice ??= 0;

  // Calculate the total buying expense per unit.
  final totalBuyingExpensePerUnit =
      buyingExpensePerUnitAmount + (buyingPrice * buyingExpensePerUnitRate);

  // Calculate the total selling expense per unit.
  final totalSellingExpensePerUnit =
      sellingExpensePerUnitAmount + (sellingPrice * sellingExpensePerUnitRate);

  // Calculate total variable cost per unit.
  final totalVariableCostPerUnit =
      buyingPrice + totalBuyingExpensePerUnit + totalSellingExpensePerUnit;

  // Prevent division by zero
  if (sellingPrice - totalVariableCostPerUnit == 0) return 0;

  // The formula for break-even units is: Fixed Costs / (Selling Price - Variable Cost per Unit)
  return fixedCosts / (sellingPrice - totalVariableCostPerUnit);
}

double computeRiskRewardRatio({
  double? rewardAmount,
  double? riskAmount,
}) {
  riskAmount ??= 0;
  rewardAmount ??= 0;
  var ratio = 0.0;

  if (riskAmount == 0) return ratio; // Prevent division by zero

  if (rewardAmount != riskAmount) {
    ratio = (rewardAmount / riskAmount);
  } else {
    ratio = 1.0;
  }

  return ratio;
}
