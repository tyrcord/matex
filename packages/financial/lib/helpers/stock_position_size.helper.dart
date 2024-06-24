double getShareAmount({
  required double accountBalance,
  required double risk,
  required double entryPrice,
  required double stopLossPrice,
  double entryFees = 0.0,
  double exitFees = 0.0,
  double slippage = 0.0,
  bool fractionalStocks = false,
  bool isShortPosition = false,
}) {
  if (accountBalance <= 0 ||
      risk <= 0 ||
      entryPrice <= 0 ||
      stopLossPrice < 0) {
    return 0.0;
  }

  // Calculate the maximum amount to risk based on the account balance and
  // risk percentage
  final maxRiskAmount = accountBalance * risk;

  // Adjust for slippage
  double adjustedEntryPrice = adjustEntryPriceForSlippage(
    entryPrice,
    slippage,
    isShortPosition: isShortPosition,
  );

  double adjustedStopLossPrice = adjustStopLossPriceForSlippage(
    stopLossPrice,
    slippage,
    isShortPosition: isShortPosition,
  );

  // Calculate the difference between the adjusted entry price and
  // adjusted stop loss
  double priceDifference = isShortPosition
      ? adjustedStopLossPrice - adjustedEntryPrice
      : adjustedEntryPrice - adjustedStopLossPrice;

  if (priceDifference <= 0) return 0.0;

  // Calculate the position size
  double positionSize = maxRiskAmount / priceDifference;

  // Adjust for entry and exit fees
  adjustedEntryPrice = adjustEntryPriceForFees(
    adjustedEntryPrice,
    entryFees,
    isShortPosition: isShortPosition,
  );

  adjustedStopLossPrice = adjustExitPriceForFees(
    adjustedStopLossPrice,
    exitFees,
    isShortPosition: isShortPosition,
  );

  // Recalculate price difference considering worst case scenario and
  // update positionSize
  priceDifference = isShortPosition
      ? adjustedStopLossPrice - adjustedEntryPrice
      : adjustedEntryPrice - adjustedStopLossPrice;

  if (priceDifference <= 0) {
    return 0.0;
  }

  positionSize = maxRiskAmount / priceDifference;

  // Adjust the position size for fractional stocks if enabled
  if (!fractionalStocks) {
    positionSize = positionSize.floor().toDouble();
  }

  return positionSize;
}

double adjustEntryPriceForSlippage(
  double price,
  double slippageRate, {
  bool isShortPosition = false,
}) {
  return isShortPosition
      ? price * (1 - slippageRate)
      : price * (1 + slippageRate);
}

double adjustStopLossPriceForSlippage(
  double price,
  double slippageRate, {
  bool isShortPosition = false,
}) {
  return isShortPosition
      ? price * (1 + slippageRate)
      : price * (1 - slippageRate);
}

double adjustEntryPriceForFees(
  double price,
  double fees, {
  bool isShortPosition = false,
}) {
  return isShortPosition ? price * (1 - fees) : price * (1 + fees);
}

double adjustExitPriceForFees(
  double price,
  double fees, {
  bool isShortPosition = false,
}) {
  return isShortPosition ? price * (1 + fees) : price * (1 - fees);
}
