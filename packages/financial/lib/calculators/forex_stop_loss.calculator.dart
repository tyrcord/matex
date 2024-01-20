// Dart imports:
import 'dart:math';

// Package imports:
import 'package:decimal/decimal.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';
import 'package:tenhance/decimal.dart';

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
    final dStopLossAmount = toDecimalOrDefault(state.stopLossAmount);
    final dStopLossPips = toDecimalOrDefault(state.stopLossPips);
    final dStopLossPrice = toDecimalOrDefault(state.stopLossPrice);
    final divider = pow(10, state.pipDecimalPlaces).toDouble();
    final dDivider = toDecimalOrDefault(divider);

    if (dStopLossAmount > dZero) {
      return _computeStopLossWithAmount(dStopLossAmount, pipValue, dDivider);
    } else if (dStopLossPips > dZero) {
      return _computeStopLossWithPips(dStopLossPips, pipValue, dDivider);
    } else if (dStopLossPrice > dZero) {
      return _computeStopLossWithPrice(dStopLossPrice, pipValue, dDivider);
    }

    return _buildStopLossResult();
  }

  MatexForexTradeOutcome _computeStopLossWithAmount(
    Decimal stopLossAmount,
    Decimal pipValue,
    Decimal divider,
  ) {
    final dStopLossAmount = toDecimalOrDefault(stopLossAmount);
    final dStopLossPips = decimalFromRational(dStopLossAmount / pipValue);

    return _buildStopLossResult(
      price: _computeStopLossPrice(dStopLossPips, divider),
      amount: stopLossAmount,
      pips: dStopLossPips,
    );
  }

  MatexForexTradeOutcome _computeStopLossWithPrice(
    Decimal stopLossPrice,
    Decimal pipValue,
    Decimal divider,
  ) {
    final dEntryPrice = toDecimalOrDefault(state.entryPrice);
    final dDivider = toDecimalOrDefault(divider);
    final position = state.position;
    var stopLossPips = dZero;

    if (position == MatexPosition.long && stopLossPrice < dEntryPrice) {
      stopLossPips = (dEntryPrice - stopLossPrice) * dDivider;
    }

    if (position == MatexPosition.short && stopLossPrice > dEntryPrice) {
      stopLossPips = (stopLossPrice - dEntryPrice) * dDivider;
    }

    return _buildStopLossResult(
      amount: _computeStopLossAmount(stopLossPips, pipValue),
      pips: stopLossPips,
      price: stopLossPrice,
    );
  }

  MatexForexTradeOutcome _computeStopLossWithPips(
    Decimal stopLossPips,
    Decimal pipValue,
    Decimal divider,
  ) {
    final stopLossPrice = _computeStopLossPrice(stopLossPips, divider);

    return _buildStopLossResult(
      amount: _computeStopLossAmount(stopLossPips, pipValue),
      pips: stopLossPips,
      price: stopLossPrice,
    );
  }

  Decimal _computeStopLossAmount(Decimal stopLossPips, Decimal pipValue) {
    return stopLossPips * pipValue;
  }

  Decimal _computeStopLossPrice(Decimal stopLossPips, Decimal divider) {
    final dEntryPrice = toDecimalOrDefault(state.entryPrice);
    final deltaPrice = decimalFromRational(stopLossPips / divider);
    final position = state.position;

    return position == MatexPosition.long
        ? dEntryPrice - deltaPrice
        : dEntryPrice + deltaPrice;
  }

  MatexForexTradeOutcome _buildStopLossResult({
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
