// Package imports:
import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';
import 'package:tenhance/decimal.dart';

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
    final dTakeProfitAmount = toDecimalOrDefault(state.takeProfitAmount);
    final dTakeProfitPips = toDecimalOrDefault(state.takeProfitPips);
    final dTakeProfitPrice = toDecimalOrDefault(state.takeProfitPrice);
    final divider = pow(10, state.pipDecimalPlaces).toDouble();
    final dDivider = toDecimalOrDefault(divider);

    if (dTakeProfitAmount > dZero) {
      return _computeTakeProfitWithAmount(
        dTakeProfitAmount,
        pipValue,
        dDivider,
      );
    } else if (dTakeProfitPips > dZero) {
      return _computeTakeProfitWithPips(dTakeProfitPips, pipValue, dDivider);
    } else if (dTakeProfitPrice > dZero) {
      return _computeTakeProfitWithPrice(dTakeProfitPrice, pipValue, dDivider);
    }

    return _buildTakeProfitResult();
  }

  MatexForexTradeOutcome _computeTakeProfitWithAmount(
    Decimal takeProfitAmount,
    Decimal pipValue,
    Decimal divider,
  ) {
    final dTakeProfitAmount = toDecimalOrDefault(takeProfitAmount);
    final dTakeProfitPips = decimalFromRational(dTakeProfitAmount / pipValue);

    return _buildTakeProfitResult(
      price: _computeTakeProfitPrice(dTakeProfitPips, divider),
      amount: takeProfitAmount,
      pips: dTakeProfitPips,
    );
  }

  MatexForexTradeOutcome _computeTakeProfitWithPrice(
    Decimal takeProfitPrice,
    Decimal pipValue,
    Decimal divider,
  ) {
    final dEntryPrice = toDecimalOrDefault(state.entryPrice);
    final position = state.position;
    var takeProfitPips = dZero;

    if (position == MatexPosition.long && takeProfitPrice > dEntryPrice) {
      takeProfitPips = (takeProfitPrice - dEntryPrice) * divider;
    }

    if (position == MatexPosition.short && takeProfitPrice < dEntryPrice) {
      takeProfitPips = (dEntryPrice - takeProfitPrice) * divider;
    }

    return _buildTakeProfitResult(
      amount: _computeTakeProfitAmount(takeProfitPips, pipValue),
      pips: takeProfitPips,
      price: takeProfitPrice,
    );
  }

  MatexForexTradeOutcome _computeTakeProfitWithPips(
    Decimal takeProfitPips,
    Decimal pipValue,
    Decimal divider,
  ) {
    final takeProfitPrice = _computeTakeProfitPrice(takeProfitPips, divider);

    return _buildTakeProfitResult(
      amount: _computeTakeProfitAmount(takeProfitPips, pipValue),
      pips: takeProfitPips,
      price: takeProfitPrice,
    );
  }

  Decimal _computeTakeProfitAmount(Decimal takeProfitPips, Decimal pipValue) {
    return takeProfitPips * pipValue;
  }

  Decimal _computeTakeProfitPrice(Decimal takeProfitPips, Decimal divider) {
    final dEntryPrice = toDecimalOrDefault(state.entryPrice);
    final deltaPrice = decimalFromRational(takeProfitPips / divider);
    final position = state.position;

    return position == MatexPosition.long
        ? dEntryPrice + deltaPrice
        : dEntryPrice - deltaPrice;
  }

  MatexForexTradeOutcome _buildTakeProfitResult({
    Decimal? amount,
    Decimal? pips,
    Decimal? price,
  }) {
    return MatexForexTradeOutcome(
      amount: toDecimalOrDefault(amount).toSafeDouble(),
      pips: toDecimalOrDefault(pips).toSafeDouble(),
      price: toDecimalOrDefault(price).toSafeDouble(),
    );
  }
}
