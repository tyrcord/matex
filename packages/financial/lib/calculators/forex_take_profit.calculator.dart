// Dart imports:
import 'dart:math';

// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

// TODO: can probably merge this with the take profit calculator

class MatexForexTakeProfitCalculator extends MatexCalculator<
    MatexForexStopLossTakeProfitCalculatorState, MatexForexTradeOutcome> {
  MatexForexTakeProfitCalculator({super.defaultState, super.state});

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

    return _computeTakeProfitLevels(pipValue);
  }

  MatexForexTradeOutcome _computeTakeProfitLevels(double pipValue) {
    final takeProfitAmount = state.takeProfitAmount ?? 0;
    final takeProfitPips = state.takeProfitPips ?? 0;
    final takeProfitPrice = state.takeProfitPrice ?? 0;
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
    double pipValue,
    double divider,
  ) {
    final dTakeProfitPips = takeProfitAmount / pipValue;

    return _buildTakeProfitResult(
      price: _computeTakeProfitPrice(dTakeProfitPips, divider),
      amount: takeProfitAmount,
      pips: dTakeProfitPips,
    );
  }

  MatexForexTradeOutcome _computeTakeProfitWithPrice(
    double takeProfitPrice,
    double pipValue,
    double divider,
  ) {
    final entryPrice = state.entryPrice ?? 0;
    final position = state.position;
    var takeProfitPips = 0.0;

    if (position == MatexPosition.long && takeProfitPrice > entryPrice) {
      takeProfitPips = (takeProfitPrice - entryPrice) * divider;
    }

    if (position == MatexPosition.short && takeProfitPrice < entryPrice) {
      takeProfitPips = (entryPrice - takeProfitPrice) * divider;
    }

    return _buildTakeProfitResult(
      amount: _computeTakeProfitAmount(takeProfitPips, pipValue),
      pips: takeProfitPips,
      price: takeProfitPrice,
    );
  }

  MatexForexTradeOutcome _computeTakeProfitWithPips(
    double takeProfitPips,
    double pipValue,
    double divider,
  ) {
    final takeProfitPrice = _computeTakeProfitPrice(takeProfitPips, divider);

    return _buildTakeProfitResult(
      amount: _computeTakeProfitAmount(takeProfitPips, pipValue),
      pips: takeProfitPips,
      price: takeProfitPrice,
    );
  }

  double _computeTakeProfitAmount(double takeProfitPips, double pipValue) {
    return takeProfitPips * pipValue;
  }

  double _computeTakeProfitPrice(double takeProfitPips, double divider) {
    final entryPrice = state.entryPrice ?? 0;
    final deltaPrice = (takeProfitPips / divider);
    final position = state.position;

    return position == MatexPosition.long
        ? entryPrice + deltaPrice
        : entryPrice - deltaPrice;
  }

  MatexForexTradeOutcome _buildTakeProfitResult({
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
