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
  double? get stopLossPrice => state.stopLossPrice;
  double? get riskAmount => state.riskAmount;
  double? get riskPercent => state.riskPercent;
  double? get stopLossPips => state.stopLossPips;
  double? get entryPrice => state.entryPrice;
  double? get accountSize => state.accountSize;

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

  set stopLossPrice(double? value) {
    setState(state.copyWith(stopLossPrice: value));
  }

  set riskAmount(double? value) {
    setState(state.copyWith(riskAmount: value));
  }

  set riskPercent(double? value) {
    setState(state.copyWith(riskPercent: value));
  }

  set stopLossPips(double? value) {
    setState(state.copyWith(stopLossPips: value));
  }

  set entryPrice(double? value) {
    setState(state.copyWith(entryPrice: value));
  }

  set accountSize(double? value) {
    setState(state.copyWith(accountSize: value));
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
