// Package imports:
import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

// TODO: can probably merge this with the take profit calculator

class MatexForexTakeProfitCalculator extends MatexCalculator<
    MatexForexStopLossTakeProfitCalculatorState, MatexForexTradeOutcome> {
  MatexForexTakeProfitCalculator({
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

    return _computeTakeProfitLevels(pipValue);
  }

  MatexForexTradeOutcome _computeTakeProfitLevels(Decimal pipValue) {
    final takeProfitAmount = state.takeProfitAmount!;
    final takeProfitPips = state.takeProfitPips!;
    final takeProfitPrice = state.takeProfitPrice!;
    final divider = pow(10, state.pipDecimalPlaces).toDouble();

    if (takeProfitAmount > 0) {
      return _computeTakeProfitWithAmount(takeProfitAmount, pipValue, divider);
    } else if (takeProfitPips > 0) {
      return _computeTakeProfitWithPips(takeProfitPips, pipValue, divider);
    } else if (takeProfitPrice > 0) {
      return _computeTakeProfitWithPrice(takeProfitPrice, pipValue, divider);
    }

    return _buildTakeProfitResult();
  }

  MatexForexTradeOutcome _computeTakeProfitWithAmount(
    double takeProfitAmount,
    Decimal pipValue,
    double divider,
  ) {
    final dTakeProfitAmount = toDecimalOrDefault(takeProfitAmount);
    final takeProfitPips = (dTakeProfitAmount / pipValue).toDouble();

    return _buildTakeProfitResult(
      price: _computeTakeProfitPrice(takeProfitPips, divider),
      amount: takeProfitAmount,
      pips: takeProfitPips,
    );
  }

  MatexForexTradeOutcome _computeTakeProfitWithPrice(
    double takeProfitPrice,
    Decimal pipValue,
    double divider,
  ) {
    final dTakeProfitPrice = toDecimalOrDefault(takeProfitPrice);
    final dEntryPrice = toDecimalOrDefault(state.entryPrice);
    final dDivider = toDecimalOrDefault(divider);
    final position = state.position;
    var takeProfitPips = 0.0;

    if (position == MatexPosition.long && dTakeProfitPrice > dEntryPrice) {
      takeProfitPips = ((dTakeProfitPrice - dEntryPrice) * dDivider).toDouble();
    }

    if (position == MatexPosition.short && dTakeProfitPrice < dEntryPrice) {
      takeProfitPips = ((dEntryPrice - dTakeProfitPrice) * dDivider).toDouble();
    }

    return _buildTakeProfitResult(
      amount: _computeTakeProfitAmount(takeProfitPips, pipValue),
      pips: takeProfitPips,
      price: takeProfitPrice,
    );
  }

  MatexForexTradeOutcome _computeTakeProfitWithPips(
    double takeProfitPips,
    Decimal pipValue,
    double divider,
  ) {
    final takeProfitPrice = _computeTakeProfitPrice(takeProfitPips, divider);

    return _buildTakeProfitResult(
      amount: _computeTakeProfitAmount(takeProfitPips, pipValue),
      pips: takeProfitPips,
      price: takeProfitPrice,
    );
  }

  double _computeTakeProfitAmount(double takeProfitPips, Decimal pipValue) {
    final dTakeProfitPips = toDecimalOrDefault(takeProfitPips);

    return (dTakeProfitPips * pipValue).toDouble();
  }

  double _computeTakeProfitPrice(double takeProfitPips, double divider) {
    final dEntryPrice = toDecimalOrDefault(state.entryPrice);
    final dTakeProfitPips = toDecimalOrDefault(takeProfitPips);
    final dDivider = toDecimalOrDefault(divider);
    final deltaPrice = decimalFromRational(dTakeProfitPips / dDivider);
    final position = state.position;

    return (position == MatexPosition.long
            ? dEntryPrice + deltaPrice
            : dEntryPrice - deltaPrice)
        .toDouble();
  }

  MatexForexTradeOutcome _buildTakeProfitResult({
    double amount = 0,
    double pips = 0,
    double price = 0,
  }) {
    return MatexForexTradeOutcome(amount: amount, pips: pips, price: price);
  }
}
