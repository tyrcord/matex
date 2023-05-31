import 'package:decimal/decimal.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

class MatexStockPositionSizeCalculator extends MatexCalculator<
    MatexStockPositionSizeCalculatorState,
    MatexStockPositionSizeCalculatorResults> {
  MatexStockPositionSizeCalculator({
    MatexStockPositionSizeCalculatorState? defaultState,
    MatexStockPositionSizeCalculatorState? state,
  }) : super(defaultState: defaultState, state: state);

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

  set stopLossAmount(double? value) {
    setState(state.copyWith(stopLossAmount: value));
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

  set riskPercent(double? value) {
    setState(state.copyWith(riskPercent: value));
  }

  set rewardRisk(double? value) {
    setState(state.copyWith(rewardRisk: value));
  }

  @override
  MatexStockPositionSizeCalculatorResults value() {
    Decimal riskPercent;

    final accountBalance = toDecimal((state.accountSize ?? 0.0))!;
    final stopLossAmount = toDecimal(state.stopLossAmount ?? 0)!;

    if (state.riskPercent != null) {
      riskPercent = toDecimal((state.riskPercent ?? 0.0))!;
    } else if (stopLossAmount != dZero && accountBalance != dZero) {
      final stopLossAmountRatio = decimalFromRational(
        stopLossAmount / accountBalance,
      );
      riskPercent = stopLossAmountRatio * dHundred;
    } else {
      throw Exception(
        'Either riskPercent should be provided or both stopLossAmount and '
        'accountSize should be provided',
      );
    }

    final slippage = toDecimal(state.slippagePercent ?? 0.0)!;
    final entryPrice = toDecimal((state.entryPrice ?? 0.0))!;
    final entryFees = toDecimal((state.entryFees ?? 0.0))!;
    final exitFees = toDecimal((state.exitFees ?? 0.0))!;
    final stopLossPrice = toDecimal((state.stopLossPrice ?? 0.0))!;
    final rewardRisk = toDecimal((state.rewardRisk ?? 0.0))!;
    final slippageRate = calculateSlippageRate(slippage);

    final adjustedEntryPrice = adjustEntryPriceForSlippage(
      entryPrice,
      slippageRate,
    );
    final adjustedStopLossPrice = adjustStopLossPriceForSlippage(
      stopLossPrice,
      slippageRate,
    );

    final adjustedEntryPriceWithFees = adjustEntryPriceForFees(
      adjustedEntryPrice,
      entryFees,
    );

    final adjustedStopLossPriceWithFees = adjustStopLossPriceForFees(
      adjustedStopLossPrice,
      exitFees,
    );

    final shares = calculateShares(
      stopLossPrice.toDouble(),
      entryPrice.toDouble(),
      accountBalance.toDouble(),
      entryFees.toDouble(),
      exitFees.toDouble(),
      riskPercent.toDouble(),
      slippage.toDouble(),
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
      rewardRisk,
    );

    return MatexStockPositionSizeCalculatorResults(
      stopLossPriceWithSlippage: adjustedStopLossPrice.toDouble(),
      entryPriceWithSlippage: adjustedEntryPrice.toDouble(),
      takeProfitPrice: takeProfitPrice.toDouble(),
      positionAmount: positionAmount.toDouble(),
      effectiveRisk: effectiveRisk.toDouble(),
      shares: shares.toDouble(),
      stopLossPercentWithSlippage: calculatePercentageDecrease(
        adjustedEntryPrice.toDouble(),
        adjustedStopLossPrice.toDouble(),
      ),
      stopLossPercent: calculatePercentageDecrease(
        entryPrice.toDouble(),
        stopLossPrice.toDouble(),
      ),
      toleratedRisk: calculateToleratedRisk(
        accountBalance,
        riskPercent,
      ).toDouble(),
      stopLossAmount: calculateStopLossAmount(
        positionAmount,
        accountBalance,
      ).toDouble(),
      takeProfitAmount: calculateTakeProfitAmount(
        effectiveRisk,
        rewardRisk,
      ).toDouble(),
    );
  }

  Decimal calculateSlippageRate(Decimal slippage) {
    return decimalFromRational(slippage / dHundred);
  }

  Decimal adjustEntryPriceForSlippage(Decimal price, Decimal slippageRate) {
    return price * (dOne + slippageRate);
  }

  Decimal adjustStopLossPriceForSlippage(Decimal price, Decimal slippageRate) {
    return price * (dOne - slippageRate);
  }

  Decimal adjustEntryPriceForFees(Decimal price, Decimal fees) {
    final feesRate = decimalFromRational(fees / dHundred);

    return price * (dOne + feesRate);
  }

  Decimal adjustStopLossPriceForFees(Decimal price, Decimal fees) {
    final feesRate = decimalFromRational(fees / dHundred);

    return price * (dOne - feesRate);
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
      stopLossPrice: stopLossPrice,
      entryPrice: entryPrice,
      accountBalance: accountBalance,
      entryFees: entryFees,
      exitFees: exitFees,
      risk: riskPercent,
      slippage: slippage,
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
    return shares * entryPriceWithFees - shares * stopLossPriceWithFees;
  }

  Decimal calculateTakeProfitPrice(
    Decimal adjustedEntryPrice,
    Decimal effectiveRisk,
    Decimal shares,
    Decimal rewardRisk,
  ) {
    final riskPerShare = decimalFromRational(effectiveRisk / shares);

    return adjustedEntryPrice + riskPerShare * rewardRisk;
  }

  Decimal calculateToleratedRisk(Decimal accountBalance, Decimal riskPercent) {
    final riskRate = decimalFromRational(riskPercent / dHundred);

    return accountBalance * riskRate;
  }

  Decimal calculateStopLossAmount(
    Decimal positionAmount,
    Decimal accountBalance,
  ) {
    return decimalFromRational(positionAmount / accountBalance);
  }

  Decimal calculateTakeProfitAmount(Decimal effectiveRisk, Decimal rewardRisk) {
    return effectiveRisk * rewardRisk;
  }
}
