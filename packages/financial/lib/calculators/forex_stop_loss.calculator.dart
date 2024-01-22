// Dart imports:
import 'dart:math';

// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

// TODO: can probably merge this with the take profit calculator

class MatexForexStopLossCalculator extends MatexCalculator<
    MatexForexStopLossTakeProfitCalculatorState, MatexForexTradeOutcome> {
  MatexForexStopLossCalculator({super.defaultState, super.state});

  @override
  MatexForexStopLossTakeProfitCalculatorState initializeState() =>
      const MatexForexStopLossTakeProfitCalculatorState();

  @override
  MatexForexStopLossTakeProfitCalculatorState initializeDefaultState() =>
      initializeState();

  static const defaultResults = MatexForexTradeOutcome();

  @override
  MatexForexTradeOutcome value({double? pipValue}) {
    if (!isValid) return defaultResults;

    pipValue ??= computePipValue(
      counterToAccountCurrencyRate: state.counterToAccountCurrencyRate,
      isAccountCurrencyCounter: state.isAccountCurrencyCounter,
      instrumentPairRate: state.instrumentPairRate,
      pipDecimalPlaces: state.pipDecimalPlaces,
      positionSize: state.positionSize,
    );

    return _computeStopLossLevels(pipValue);
  }

  MatexForexTradeOutcome _computeStopLossLevels(double pipValue) {
    final dStopLossAmount = state.stopLossAmount ?? 0;
    final dStopLossPips = state.stopLossPips ?? 0;
    final dStopLossPrice = state.stopLossPrice ?? 0;
    final divider = pow(10, state.pipDecimalPlaces).toDouble();

    if (dStopLossAmount > 0) {
      return _computeStopLossWithAmount(dStopLossAmount, pipValue, divider);
    } else if (dStopLossPips > 0) {
      return _computeStopLossWithPips(dStopLossPips, pipValue, divider);
    } else if (dStopLossPrice > 0) {
      return _computeStopLossWithPrice(dStopLossPrice, pipValue, divider);
    }

    return _buildStopLossResult();
  }

  MatexForexTradeOutcome _computeStopLossWithAmount(
    double stopLossAmount,
    double pipValue,
    double divider,
  ) {
    final stopLossPips = (stopLossAmount / pipValue);

    return _buildStopLossResult(
      price: _computeStopLossPrice(stopLossPips, divider),
      amount: stopLossAmount,
      pips: stopLossPips,
    );
  }

  MatexForexTradeOutcome _computeStopLossWithPrice(
    double stopLossPrice,
    double pipValue,
    double divider,
  ) {
    final dEntryPrice = state.entryPrice ?? 0;
    final position = state.position;
    var stopLossPips = 0.0;

    if (position == MatexPosition.long && stopLossPrice < dEntryPrice) {
      stopLossPips = (dEntryPrice - stopLossPrice) * divider;
    }

    if (position == MatexPosition.short && stopLossPrice > dEntryPrice) {
      stopLossPips = (stopLossPrice - dEntryPrice) * divider;
    }

    return _buildStopLossResult(
      amount: _computeStopLossAmount(stopLossPips, pipValue),
      pips: stopLossPips,
      price: stopLossPrice,
    );
  }

  MatexForexTradeOutcome _computeStopLossWithPips(
    double stopLossPips,
    double pipValue,
    double divider,
  ) {
    final stopLossPrice = _computeStopLossPrice(stopLossPips, divider);

    return _buildStopLossResult(
      amount: _computeStopLossAmount(stopLossPips, pipValue),
      pips: stopLossPips,
      price: stopLossPrice,
    );
  }

  double _computeStopLossAmount(double stopLossPips, double pipValue) {
    return stopLossPips * pipValue;
  }

  double _computeStopLossPrice(double stopLossPips, double divider) {
    final dEntryPrice = state.entryPrice ?? 0;
    final deltaPrice = stopLossPips / divider;
    final position = state.position;

    return position == MatexPosition.long
        ? dEntryPrice - deltaPrice
        : dEntryPrice + deltaPrice;
  }

  MatexForexTradeOutcome _buildStopLossResult({
    double? amount,
    double? pips,
    double? price,
  }) {
    return MatexForexTradeOutcome(
      amount: amount ?? 0,
      price: price ?? 0,
      pips: pips ?? 0,
    );
  }
}
