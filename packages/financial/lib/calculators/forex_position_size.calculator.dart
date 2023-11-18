// Dart imports:
import 'dart:math';

// Package imports:
import 'package:decimal/decimal.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexPositionSizeCalculator extends MatexCalculator<
    MatexForexPositionSizeCalculatorState,
    MatexForexPositionSizeCalculatorResults> {
  MatexForexPositionSizeCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: forexPositionSizeValidators);

  @override
  MatexForexPositionSizeCalculatorState initializeState() =>
      const MatexForexPositionSizeCalculatorState();

  @override
  MatexForexPositionSizeCalculatorState initializeDefaultState() =>
      initializeState();

  bool? get isAccountCurrencyCounter => state.isAccountCurrencyCounter;
  double? get instrumentPairRate => state.instrumentPairRate;
  int? get pipDecimalPlaces => state.pipDecimalPlaces;
  double? get positionSize => state.positionSize;
  double? get standardLot => state.standardLot;
  double? get microLot => state.microLot;
  double? get miniLot => state.miniLot;
  double? get nanoLot => state.nanoLot;

  double? get counterToAccountCurrencyRate {
    return state.counterToAccountCurrencyRate;
  }

  set positionSize(double? value) {
    setState(state.copyWith(positionSize: value));
  }

  set pipDecimalPlaces(int? value) {
    setState(state.copyWith(pipDecimalPlaces: value));
  }

  set isAccountCurrencyCounter(bool? value) {
    setState(state.copyWith(isAccountCurrencyCounter: value));
  }

  set counterToAccountCurrencyRate(double? value) {
    setState(state.copyWith(counterToAccountCurrencyRate: value));
  }

  set instrumentPairRate(double? value) {
    setState(state.copyWith(instrumentPairRate: value));
  }

  set standardLot(double? lot) {
    setState(state.copyWith(standardLot: lot));
  }

  set microLot(double? microLot) {
    setState(state.copyWith(standardLot: microLot));
  }

  set miniLot(double? miniLot) {
    setState(state.copyWith(standardLot: miniLot));
  }

  set nanoLot(double? nanoLot) {
    setState(state.copyWith(standardLot: nanoLot));
  }

  static const defaultResults = MatexForexPositionSizeCalculatorResults(
    pipValue: 0,
  );

  @override
  MatexForexPositionSizeCalculatorResults value() {
    if (!isValid) return defaultResults;

    final pipValue = computePipValue();

    return MatexForexPositionSizeCalculatorResults(
      pipValue: pipValue.toDouble(),
    );
  }

  Decimal computePipValue() {
    final counterToAccountCurrencyRate = state.counterToAccountCurrencyRate;
    final isAccountCurrencyCounter = state.isAccountCurrencyCounter;
    final dPositionSize = toDecimal(state.positionSize) ?? dZero;
    final pipDecimalPlaces = state.pipDecimalPlaces ?? 0;
    final decimalMultiplicator = pow(10, pipDecimalPlaces);
    final dDecimalMultiplicator = toDecimal(decimalMultiplicator)!;
    final dDecimalPip = decimalFromRational(dOne / dDecimalMultiplicator);
    final pipValue = dPositionSize * dDecimalPip;

    if (isAccountCurrencyCounter) return pipValue;

    if (counterToAccountCurrencyRate == 0) {
      final dInstrumentPairRate = toDecimal(state.instrumentPairRate) ?? dOne;

      return decimalFromRational(pipValue / dInstrumentPairRate);
    }

    final dCounterToAccountCurrencyRate =
        toDecimal(counterToAccountCurrencyRate) ?? dOne;

    return pipValue * dCounterToAccountCurrencyRate;
  }
}
