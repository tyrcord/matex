import 'package:decimal/decimal.dart';
import 'package:t_helpers/helpers.dart';

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
  final dAccountBalance = toDecimal(accountBalance)!;
  final dRisk = toDecimal(risk)!;
  final dEntryPrice = toDecimal(entryPrice)!;
  final dStopLossPrice = toDecimal(stopLossPrice)!;
  final dEntryFees = toDecimal(entryFees)!;
  final dExitFees = toDecimal(exitFees)!;
  final dSlippage = toDecimal(slippage)!;

  if (dAccountBalance <= Decimal.zero ||
      dRisk <= Decimal.zero ||
      dEntryPrice <= Decimal.zero ||
      dStopLossPrice <= Decimal.zero) {
    return 0.0;
  }

  // Calculate the maximum amount to risk based on the account balance and
  // risk percentage
  final maxRiskAmount = dAccountBalance * dRisk;

  // Adjust for slippage
  Decimal adjustedEntryPrice = dEntryPrice * (dOne + dSlippage);
  Decimal adjustedStopLossPrice = dStopLossPrice * (dOne - dSlippage);

  // Calculate the difference between the adjusted entry price and
  // adjusted stop loss
  Decimal priceDifference = adjustedEntryPrice - adjustedStopLossPrice;

  if (priceDifference <= Decimal.zero) {
    return 0.0;
  }

  // Calculate the position size
  Decimal positionSize = decimalFromRational(maxRiskAmount / priceDifference);

  // Adjust for entry and exit fees
  adjustedEntryPrice = adjustedEntryPrice * (dOne + dEntryFees);
  adjustedStopLossPrice = adjustedStopLossPrice * (dOne - dExitFees);

  // Recalculate price difference considering worst case scenario and
  // update positionSize
  priceDifference = adjustedEntryPrice - adjustedStopLossPrice;

  if (priceDifference <= Decimal.zero) {
    return 0.0;
  }

  positionSize = decimalFromRational(maxRiskAmount / priceDifference);

  // Adjust the position size for fractional stocks if enabled
  if (!fractionalStocks) {
    positionSize = Decimal.parse(positionSize.floor().toString());
  }

  return positionSize.toDouble();
}
