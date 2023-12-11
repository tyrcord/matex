// Package imports:
import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

// TODO: can probably merge this with the take profit calculator

class MatexForexStopLossCalculator extends MatexCalculator<
    MatexForexStopLossTakeProfitCalculatorState, MatexForexTradeOutcome> {
  MatexForexStopLossCalculator({
    super.defaultState,
    super.state,
  });

  @override
  MatexForexStopLossTakeProfitCalculatorState initializeState() =>
      const MatexForexStopLossTakeProfitCalculatorState();

  @override
  MatexForexStopLossTakeProfitCalculatorState initializeDefaultState() =>
      initializeState();

  static const defaultResults = MatexForexTradeOutcome();

  @override
  MatexForexTradeOutcome value({Decimal? pipValue}) {
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

  MatexForexTradeOutcome _computeStopLossLevels(Decimal pipValue) {
    final stopLossAmount = state.stopLossAmount!;
    final stopLossPips = state.stopLossPips!;
    final stopLossPrice = state.stopLossPrice!;
    final divider = pow(10, state.pipDecimalPlaces).toDouble();

    if (stopLossAmount > 0) {
      return _computeStopLossWithAmount(stopLossAmount, pipValue, divider);
    } else if (stopLossPips > 0) {
      return _computeStopLossWithPips(stopLossPips, pipValue, divider);
    } else if (stopLossPrice > 0) {
      return _computeStopLossWithPrice(stopLossPrice, pipValue, divider);
    }

    return _buildStopLossResult();
  }

  MatexForexTradeOutcome _computeStopLossWithAmount(
    double stopLossAmount,
    Decimal pipValue,
    double divider,
  ) {
    final dStopLossAmount = toDecimalOrDefault(stopLossAmount);
    final stopLossPips = (dStopLossAmount / pipValue).toDouble();

    return _buildStopLossResult(
      amount: stopLossAmount,
      pips: stopLossPips,
      price: _computeStopLossPrice(stopLossPips, divider),
    );
  }

  MatexForexTradeOutcome _computeStopLossWithPrice(
    double stopLossPrice,
    Decimal pipValue,
    double divider,
  ) {
    final dStopLossPrice = toDecimalOrDefault(stopLossPrice);
    final dEntryPrice = toDecimalOrDefault(state.entryPrice);
    final dDivider = toDecimalOrDefault(divider);
    final position = state.position;
    var stopLossPips = 0.0;

    if (position == MatexPosition.long && dStopLossPrice < dEntryPrice) {
      stopLossPips = ((dEntryPrice - dStopLossPrice) * dDivider).toDouble();
    }

    if (position == MatexPosition.short && dStopLossPrice > dEntryPrice) {
      stopLossPips = ((dStopLossPrice - dEntryPrice) * dDivider).toDouble();
    }

    return _buildStopLossResult(
      amount: _computeStopLossAmount(stopLossPips, pipValue),
      pips: stopLossPips,
      price: stopLossPrice,
    );
  }

  MatexForexTradeOutcome _computeStopLossWithPips(
    double stopLossPips,
    Decimal pipValue,
    double divider,
  ) {
    final stopLossPrice = _computeStopLossPrice(stopLossPips, divider);

    return _buildStopLossResult(
      amount: _computeStopLossAmount(stopLossPips, pipValue),
      pips: stopLossPips,
      price: stopLossPrice,
    );
  }

  double _computeStopLossAmount(double stopLossPips, Decimal pipValue) {
    final dStopLossPips = toDecimalOrDefault(stopLossPips);

    return (dStopLossPips * pipValue).toDouble();
  }

  double _computeStopLossPrice(double stopLossPips, double divider) {
    final dEntryPrice = toDecimalOrDefault(state.entryPrice);
    final dDivider = toDecimalOrDefault(divider);
    final dStopLossPips = toDecimalOrDefault(stopLossPips);
    final deltaPrice = decimalFromRational(dStopLossPips / dDivider);
    final position = state.position;

    return (position == MatexPosition.long
            ? dEntryPrice - deltaPrice
            : dEntryPrice + deltaPrice)
        .toDouble();
  }

  MatexForexTradeOutcome _buildStopLossResult({
    double amount = 0,
    double pips = 0,
    double price = 0,
  }) {
    return MatexForexTradeOutcome(amount: amount, pips: pips, price: price);
  }
}
