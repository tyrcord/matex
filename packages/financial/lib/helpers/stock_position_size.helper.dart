double getShareAmount({
  required double accountBalance,
  required double risk,
  required double entryPrice,
  required double stopLossPrice,
  double entryFees = 0.0,
  double exitFees = 0.0,
  double slippage = 0.0,
  bool fractionalStocks = false,
}) {
  if (accountBalance <= 0 ||
      risk <= 0 ||
      entryPrice <= 0 ||
      stopLossPrice <= 0) {
    return 0;
  }

  // Calculate the maximum amount to risk based on the account balance and
  // risk percentage
  double maxRiskAmount = accountBalance * (risk / 100);

  // Adjust for slippage
  double adjustedEntryPrice = entryPrice * (1 + slippage / 100);
  double adjustedStopLossPrice = stopLossPrice * (1 - slippage / 100);

  // Calculate the difference between the adjusted entry price and
  // adjusted stop loss
  double priceDifference = adjustedEntryPrice - adjustedStopLossPrice;

  if (priceDifference <= 0) {
    return 0;
  }

  // Calculate the position size
  double positionSize = maxRiskAmount / priceDifference;

  // Adjust for entry and exit fees
  adjustedEntryPrice = adjustedEntryPrice * (1 + entryFees / 100);
  adjustedStopLossPrice = adjustedStopLossPrice * (1 - exitFees / 100);

  // Recalculate price difference considering worst case scenario and
  // update positionSize
  priceDifference = adjustedEntryPrice - adjustedStopLossPrice;

  if (priceDifference <= 0) {
    return 0;
  }

  positionSize = maxRiskAmount / priceDifference;

  // Adjust the position size for fractional stocks if enabled
  if (!fractionalStocks) {
    positionSize = positionSize.floor().toDouble();
  }

  return positionSize;
}
