// Package imports:
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';

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
    setState(state.copyWith(riskReward: value, takeProfitPrice: 0));
  }

  set takeProfitPrice(double? value) {
    setState(state.copyWith(takeProfitPrice: value, riskReward: 0));
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

    final accountBalance = (state.accountSize) ?? 0.0;
    final stopLossAmount = (state.stopLossAmount) ?? 0.0;
    double riskPercent;

    // If the risk percent is provided, use it
    if (state.riskPercent != null && state.riskPercent != 0) {
      riskPercent = (state.riskPercent) ?? 0.0;
    } else if (stopLossAmount != 0.0 && accountBalance != 0.0) {
      // If the stop loss amount is provided, calculate the risk percent
      // based on the account balance and stop loss amount.
      riskPercent = (stopLossAmount / accountBalance);
    } else {
      return defaultResults;
    }

    final slippage = (state.slippagePercent) ?? 0.0;
    final entryPrice = (state.entryPrice) ?? 0.0;
    final entryFees = (state.entryFees) ?? 0.0;
    final exitFees = (state.exitFees) ?? 0.0;
    final stopLossPrice = (state.stopLossPrice) ?? 0.0;

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
      stopLossPrice,
      entryPrice,
      accountBalance,
      entryFees,
      exitFees,
      riskPercent,
      slippage,
    );

    final positionAmount = calculatePositionAmount(shares, adjustedEntryPrice);

    final effectiveRisk = calculateEffectiveRisk(
      shares,
      adjustedEntryPriceWithFees,
      adjustedStopLossPriceWithFees,
    );

    double takeProfitPrice = 0.0;
    double riskReward = 0.0;

    if (state.riskReward != null && state.riskReward! > 0) {
      riskReward = state.riskReward!;
      takeProfitPrice = calculateTakeProfitPrice(
        adjustedEntryPrice,
        effectiveRisk,
        shares,
        riskReward,
      );
    } else if (state.takeProfitPrice != null && state.takeProfitPrice! > 0) {
      takeProfitPrice = state.takeProfitPrice!;
      riskReward = calculateRiskReward(
        adjustedEntryPrice,
        takeProfitPrice,
        effectiveRisk,
        shares,
      );
    }

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

    final returnOnCapital = calculateReturnOnCapital(
      adjustedTakeProfitAmount,
      accountBalance,
    );

    return MatexStockPositionSizeCalculatorResults(
      totalFeesForProfitPosition: totalFeesForProfitPosition,
      takeProfitPriceWithSlippage: adjustedTakeProfitPrice,
      totalFeesForLossPosition: totalFeesForLossPosition,
      takeProfitAmountAfterFee: adjustedTakeProfitAmount,
      stopLossPriceWithSlippage: adjustedStopLossPrice,
      entryPriceWithSlippage: adjustedEntryPrice,
      takeProfitFeeAmount: takeProfitFeeAmount,
      returnOnCapital: returnOnCapital,
      stopLossFeeAmount: stopLossFeeAmount,
      takeProfitAmount: takeProfitAmount,
      takeProfitPrice: takeProfitPrice,
      entryFeeAmount: entryFeeAmount,
      positionAmount: positionAmount,
      effectiveRisk: effectiveRisk,
      riskPercent: riskPercent,
      riskReward: riskReward,
      shares: shares,
      stopLossPercentWithSlippage: calculatePercentageDecrease(
        adjustedEntryPrice,
        adjustedStopLossPrice,
      ).abs(),
      stopLossPercent: calculatePercentageDecrease(
        entryPrice,
        stopLossPrice,
      ).abs(),
      toleratedRisk: calculateToleratedRisk(
        accountBalance,
        riskPercent,
      ),
      involvedCapital: calculateStopLossAmount(
        positionAmount,
        accountBalance,
      ),
    );
  }

  double calculateShares(
    double stopLossPrice,
    double entryPrice,
    double accountBalance,
    double entryFees,
    double exitFees,
    double riskPercent,
    double slippage,
  ) {
    return getShareAmount(
      isShortPosition: isShortPosition,
      accountBalance: accountBalance,
      stopLossPrice: stopLossPrice,
      entryPrice: entryPrice,
      entryFees: entryFees,
      slippage: slippage,
      exitFees: exitFees,
      risk: riskPercent,
    );
  }

  double calculatePositionAmount(double shares, double adjustedEntryPrice) {
    return shares * adjustedEntryPrice;
  }

  double calculateEffectiveRisk(
    double shares,
    double entryPriceWithFees,
    double stopLossPriceWithFees,
  ) {
    return isShortPosition
        ? shares * stopLossPriceWithFees - shares * entryPriceWithFees
        : shares * entryPriceWithFees - shares * stopLossPriceWithFees;
  }

  double calculateTakeProfitPrice(
    double adjustedEntryPrice,
    double effectiveRisk,
    double shares,
    double riskReward,
  ) {
    if (shares == 0.0) return adjustedEntryPrice;

    final riskPerShare = (effectiveRisk / shares);

    return isShortPosition
        ? adjustedEntryPrice - riskPerShare * riskReward
        : adjustedEntryPrice + riskPerShare * riskReward;
  }

  double calculateToleratedRisk(double accountBalance, double riskPercent) {
    return accountBalance * riskPercent;
  }

  double calculateStopLossAmount(
    double positionAmount,
    double accountBalance,
  ) {
    if (accountBalance == 0.0) return 0.0;

    return (positionAmount / accountBalance);
  }

  double calculateTakeProfitAmount(double effectiveRisk, double riskReward) {
    return effectiveRisk * riskReward;
  }

  double calculateRiskReward(
    double adjustedEntryPrice,
    double takeProfitPrice,
    double effectiveRisk,
    double shares,
  ) {
    if (shares == 0.0 || effectiveRisk == 0.0) return 0.0;

    final profitPerShare = isShortPosition
        ? adjustedEntryPrice - takeProfitPrice
        : takeProfitPrice - adjustedEntryPrice;

    return (profitPerShare * shares) / effectiveRisk;
  }

  double calculateReturnOnCapital(
    double takeProfitAmount,
    double accountBalance,
  ) {
    if (accountBalance == 0.0) return 0.0;

    return takeProfitAmount / accountBalance;
  }
}
