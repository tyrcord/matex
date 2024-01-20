// Package imports:
import 'package:decimal/decimal.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';
import 'package:tenhance/decimal.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexStockPositionSizeCalculator extends MatexCalculator<
    MatexStockPositionSizeCalculatorState,
    MatexStockPositionSizeCalculatorResults> {
  MatexStockPositionSizeCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: stockPositionSizeValidators);

  @override
  MatexStockPositionSizeCalculatorState initializeState() =>
      const MatexStockPositionSizeCalculatorState();

  @override
  MatexStockPositionSizeCalculatorState initializeDefaultState() =>
      initializeState();

  set accountSize(double? value) {
    setState(state.copyWith(accountSize: value));
  }

  set entryPrice(double? value) {
    setState(state.copyWith(entryPrice: value));
  }

  set stopLossPrice(double? value) {
    setState(state.copyWith(stopLossPrice: value));
  }

  set entryFees(double? value) {
    setState(state.copyWith(entryFees: value));
  }

  set exitFees(double? value) {
    setState(state.copyWith(exitFees: value));
  }

  set slippagePercent(double? value) {
    setState(state.copyWith(slippagePercent: value));
  }

  set stopLossAmount(double? value) {
    setState(state.copyWith(stopLossAmount: value, riskPercent: 0));
  }

  set riskPercent(double? value) {
    setState(state.copyWith(riskPercent: value, stopLossAmount: 0));
  }

  set riskReward(double? value) {
    setState(state.copyWith(riskReward: value));
  }

  set isShortPosition(bool? value) {
    setState(state.copyWith(isShortPosition: value));
  }

  bool get isShortPosition => state.isShortPosition;

  static const defaultResults = MatexStockPositionSizeCalculatorResults(
    shares: 0,
    positionAmount: 0,
  );

  @override
  MatexStockPositionSizeCalculatorResults value() {
    if (!isValid) return defaultResults;

    final accountBalance = toDecimal(state.accountSize) ?? dZero;
    final stopLossAmount = toDecimal(state.stopLossAmount) ?? dZero;
    Decimal riskPercent;

    if (state.riskPercent != null && state.riskPercent != 0) {
      riskPercent = toDecimal(state.riskPercent) ?? dZero;
    } else if (stopLossAmount != dZero && accountBalance != dZero) {
      riskPercent = decimalFromRational(
        stopLossAmount / accountBalance,
      );
    } else {
      return defaultResults;
    }

    final slippage = toDecimal(state.slippagePercent) ?? dZero;
    final entryPrice = toDecimal(state.entryPrice) ?? dZero;
    final entryFees = toDecimal(state.entryFees) ?? dZero;
    final exitFees = toDecimal(state.exitFees) ?? dZero;
    final stopLossPrice = toDecimal(state.stopLossPrice) ?? dZero;
    final riskReward = toDecimal(state.riskReward) ?? dZero;

    final adjustedEntryPrice = adjustEntryPriceForSlippage(
      entryPrice,
      slippage,
      isShortPosition: isShortPosition,
    );

    final adjustedStopLossPrice = adjustStopLossPriceForSlippage(
      stopLossPrice,
      slippage,
      isShortPosition: isShortPosition,
    );

    final adjustedEntryPriceWithFees = adjustEntryPriceForFees(
      adjustedEntryPrice,
      entryFees,
      isShortPosition: isShortPosition,
    );

    final adjustedStopLossPriceWithFees = adjustExitPriceForFees(
      adjustedStopLossPrice,
      exitFees,
      isShortPosition: isShortPosition,
    );

    final shares = calculateShares(
      stopLossPrice.toSafeDouble(),
      entryPrice.toSafeDouble(),
      accountBalance.toSafeDouble(),
      entryFees.toSafeDouble(),
      exitFees.toSafeDouble(),
      riskPercent.toSafeDouble(),
      slippage.toSafeDouble(),
    );

    final positionAmount = calculatePositionAmount(shares, adjustedEntryPrice);

    final effectiveRisk = calculateEffectiveRisk(
      shares,
      adjustedEntryPriceWithFees,
      adjustedStopLossPriceWithFees,
    );

    final takeProfitPrice = calculateTakeProfitPrice(
      adjustedEntryPrice,
      effectiveRisk,
      shares,
      riskReward,
    );

    final adjustedTakeProfitPrice = adjustExitPriceForFees(
      takeProfitPrice,
      exitFees,
      isShortPosition: isShortPosition,
    );

    final takeProfitAmount = calculateTakeProfitAmount(
      effectiveRisk,
      riskReward,
    );

    // Calculate the total fees based on adjusted prices
    final entryFeeAmount = isShortPosition
        ? shares * (adjustedEntryPrice - adjustedEntryPriceWithFees)
        : shares * (adjustedEntryPriceWithFees - adjustedEntryPrice);
    final stopLossFeeAmount = isShortPosition
        ? shares * (adjustedStopLossPriceWithFees - adjustedStopLossPrice)
        : shares * (adjustedStopLossPrice - adjustedStopLossPriceWithFees);
    final takeProfitFeeAmount = isShortPosition
        ? shares * (adjustedTakeProfitPrice - takeProfitPrice)
        : shares * (takeProfitPrice - adjustedTakeProfitPrice);

    final totalFeesForLossPosition = entryFeeAmount + stopLossFeeAmount;
    final totalFeesForProfitPosition = entryFeeAmount + takeProfitFeeAmount;
    final adjustedTakeProfitAmount = takeProfitAmount - takeProfitFeeAmount;

    return MatexStockPositionSizeCalculatorResults(
      stopLossPriceWithSlippage: adjustedStopLossPrice.toSafeDouble(),
      entryPriceWithSlippage: adjustedEntryPrice.toSafeDouble(),
      takeProfitAmount: takeProfitAmount.toSafeDouble(),
      takeProfitAmountAfterFee: adjustedTakeProfitAmount.toSafeDouble(),
      takeProfitPrice: takeProfitPrice.toSafeDouble(),
      takeProfitPriceWithSlippage: adjustedTakeProfitPrice.toSafeDouble(),
      entryFeeAmount: entryFeeAmount.toSafeDouble(),
      stopLossFeeAmount: stopLossFeeAmount.toSafeDouble(),
      takeProfitFeeAmount: takeProfitFeeAmount.toSafeDouble(),
      totalFeesForLossPosition: totalFeesForLossPosition.toSafeDouble(),
      totalFeesForProfitPosition: totalFeesForProfitPosition.toSafeDouble(),
      positionAmount: positionAmount.toSafeDouble(),
      effectiveRisk: effectiveRisk.toSafeDouble(),
      riskPercent: riskPercent.toSafeDouble(),
      shares: shares.toSafeDouble(),
      stopLossPercentWithSlippage: calculatePercentageDecrease(
        adjustedEntryPrice.toSafeDouble(),
        adjustedStopLossPrice.toSafeDouble(),
      ).abs(),
      stopLossPercent: calculatePercentageDecrease(
        entryPrice.toSafeDouble(),
        stopLossPrice.toSafeDouble(),
      ).abs(),
      toleratedRisk: calculateToleratedRisk(
        accountBalance,
        riskPercent,
      ).toSafeDouble(),
      involvedCapital: calculateStopLossAmount(
        positionAmount,
        accountBalance,
      ).toSafeDouble(),
    );
  }

  Decimal calculateShares(
    double stopLossPrice,
    double entryPrice,
    double accountBalance,
    double entryFees,
    double exitFees,
    double riskPercent,
    double slippage,
  ) {
    final shares = getShareAmount(
      isShortPosition: isShortPosition,
      accountBalance: accountBalance,
      stopLossPrice: stopLossPrice,
      entryPrice: entryPrice,
      entryFees: entryFees,
      slippage: slippage,
      exitFees: exitFees,
      risk: riskPercent,
    );

    return decimalFromDouble(shares)!;
  }

  Decimal calculatePositionAmount(Decimal shares, Decimal adjustedEntryPrice) {
    return shares * adjustedEntryPrice;
  }

  Decimal calculateEffectiveRisk(
    Decimal shares,
    Decimal entryPriceWithFees,
    Decimal stopLossPriceWithFees,
  ) {
    return isShortPosition
        ? shares * stopLossPriceWithFees - shares * entryPriceWithFees
        : shares * entryPriceWithFees - shares * stopLossPriceWithFees;
  }

  Decimal calculateTakeProfitPrice(
    Decimal adjustedEntryPrice,
    Decimal effectiveRisk,
    Decimal shares,
    Decimal riskReward,
  ) {
    if (shares == dZero) return adjustedEntryPrice;

    final riskPerShare = decimalFromRational(effectiveRisk / shares);

    return isShortPosition
        ? adjustedEntryPrice - riskPerShare * riskReward
        : adjustedEntryPrice + riskPerShare * riskReward;
  }

  Decimal calculateToleratedRisk(Decimal accountBalance, Decimal riskPercent) {
    return accountBalance * riskPercent;
  }

  Decimal calculateStopLossAmount(
    Decimal positionAmount,
    Decimal accountBalance,
  ) {
    if (accountBalance == dZero) return dZero;

    return decimalFromRational(positionAmount / accountBalance);
  }

  Decimal calculateTakeProfitAmount(Decimal effectiveRisk, Decimal riskReward) {
    return effectiveRisk * riskReward;
  }
}
