// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:matex_core/core.dart';

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
  double? get stopLossPrice => state.stopLossPrice;
  double? get riskAmount => state.riskAmount;
  double? get riskPercent => state.riskPercent;
  double? get stopLossPips => state.stopLossPips;
  double? get entryPrice => state.entryPrice;
  double? get accountSize => state.accountSize;

  double? get counterToAccountCurrencyRate {
    return state.counterToAccountCurrencyRate;
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
    setState(state.copyWith(stopLossPrice: value, stopLossPips: 0));
  }

  set riskAmount(double? value) {
    setState(state.copyWith(riskAmount: value, riskPercent: 0));
  }

  set riskPercent(double? value) {
    setState(state.copyWith(riskPercent: value, riskAmount: 0));
  }

  set stopLossPips(double? value) {
    setState(state.copyWith(
      stopLossPips: value,
      stopLossPrice: 0,
      entryPrice: 0,
    ));
  }

  set entryPrice(double? value) {
    setState(state.copyWith(entryPrice: value, stopLossPips: 0));
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

    final stopLossPips = computeStopLossPip(state.pipDecimalPlaces);
    var stopLossPrice = state.stopLossPrice ?? 0.0;

    if (stopLossPrice <= 0) {
      stopLossPrice = computeStopPrice(state.pipDecimalPlaces);
    }

    final amountAtRisk = computeAmountAtRisk();
    final riskRatio = computeRiskPercent(amountAtRisk, state.accountSize);
    final pipValue = computePipValue(
      counterToAccountCurrencyRate: state.counterToAccountCurrencyRate,
      isAccountCurrencyCounter: state.isAccountCurrencyCounter,
      instrumentPairRate: state.instrumentPairRate,
      pipDecimalPlaces: state.pipDecimalPlaces,
      positionSize: 1,
    );

    final size = pipValue > 0 && stopLossPips > 0
        ? computePositionSize(
            amountAtRisk,
            pipValue,
            stopLossPips,
          )
        : 0.0;

    return (result = MatexForexPositionSizeCalculatorResults(
      stopLossPrice: stopLossPrice,
      amountAtRisk: amountAtRisk,
      stopLossPips: stopLossPips,
      pipValue: pipValue * size,
      riskPercent: riskRatio,
      positionSize: size,
    ));
  }

  @protected
  double computePositionSize(
    double amountAtRisk,
    double pipValue,
    double stopLossPip,
  ) {
    final divider = pipValue * stopLossPip;

    if (divider == 0) return 0;

    return amountAtRisk / divider;
  }

  @protected
  double computeRiskPercent(double amountAtRisk, double? accountSize) {
    final riskPercent = state.riskPercent ?? 0.0;

    if (accountSize == null || accountSize <= 0) return 0;
    if (riskPercent > 0 && amountAtRisk <= 0) return riskPercent;

    return amountAtRisk / accountSize;
  }

  @protected
  double computeAmountAtRisk() {
    final riskAmount = state.riskAmount ?? 0.0;

    if (riskAmount > 0) return riskAmount;

    final riskRatio = state.riskPercent;
    final accountSize = state.accountSize;

    if (accountSize == null ||
        riskRatio == null ||
        accountSize < 0 ||
        riskRatio < 0 ||
        riskRatio > 1) return 0;

    return riskRatio * accountSize;
  }

  @protected
  double computeStopPrice(int? pipDecimalPlaces) {
    if (pipDecimalPlaces == null) return 0;

    final dStopLossPips = state.stopLossPips ?? 0.0;
    final dEntryPrice = state.instrumentPairRate;
    // fixme: add support for short positions
    const isBuyPosition = true;

    if (dEntryPrice <= 0 || dStopLossPips <= 0 || pipDecimalPlaces < 0) {
      return 0;
    }

    final decimalMultiplicator = 1 / pow(10, pipDecimalPlaces);

    if (isBuyPosition) {
      // For a buy position, the stop price is below the entry price
      return dEntryPrice - (dStopLossPips * decimalMultiplicator);
    }

    // fixme: add support for short positions
    // ignore: dead_code
    return dEntryPrice + (dStopLossPips * decimalMultiplicator);
  }

  @protected
  double computeStopLossPip(int? pipDecimalPlaces) {
    if (pipDecimalPlaces == null) return 0;

    final stopLossPips = state.stopLossPips ?? 0.0;

    if (stopLossPips > 0) return stopLossPips;

    final stopLossPrice = state.stopLossPrice ?? 0.0;
    final entryPrice = state.entryPrice ?? 0.0;

    if (entryPrice <= 0 || stopLossPrice <= 0) return 0;

    final decimalMultiplicator = pow(10, pipDecimalPlaces);
    final deltaPrice = (entryPrice - stopLossPrice).abs();

    return deltaPrice * decimalMultiplicator;
  }
}
