import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

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
    final slippage = state.slippagePercent ?? 0.0;
    final entryPrice = state.entryPrice ?? 0.0;
    final riskPercent = state.riskPercent ?? 0.0;
    final accountBalance = state.accountSize ?? 0.0;
    final entryFees = state.entryFees ?? 0.0;
    final exitFees = state.exitFees ?? 0.0;
    final stopLossPrice = state.stopLossPrice ?? 0.0;
    final rewardRisk = state.rewardRisk ?? 0.0;
    final slippageRate = slippage / 100;

    // Adjust for slippage
    final adjustedEntryPrice = entryPrice * (1 + slippageRate);
    final adjustedStopLossPrice = stopLossPrice * (1 - slippageRate);

    // Adjust for entry and exit fees
    final adjustedEntryPriceWithFees =
        adjustedEntryPrice * (1 + entryFees / 100);
    final adjustedStopLossPriceWithFees =
        adjustedStopLossPrice * (1 - exitFees / 100);

    final shares = getShareAmount(
      stopLossPrice: stopLossPrice,
      entryPrice: entryPrice,
      accountBalance: accountBalance,
      entryFees: entryFees,
      exitFees: exitFees,
      risk: riskPercent,
      slippage: slippage,
    );

    final positionAmount = shares * adjustedEntryPrice;

    final effectiveRisk = shares * adjustedEntryPriceWithFees -
        shares * adjustedStopLossPriceWithFees;

    // Calculate take profit price
    final takeProfitPrice =
        adjustedEntryPrice + (effectiveRisk / shares) * rewardRisk;

    return MatexStockPositionSizeCalculatorResults(
      toleratedRisk: accountBalance * (riskPercent / 100),
      involvedCapital: positionAmount / accountBalance,
      takeProfitAmount: effectiveRisk * rewardRisk,
      positionAmount: positionAmount,
      effectiveRisk: effectiveRisk,
      takeProfitPrice: takeProfitPrice,
      shares: shares,
    );
  }
}
