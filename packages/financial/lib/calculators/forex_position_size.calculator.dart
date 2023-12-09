// Dart imports:
import 'dart:math';

// Package imports:
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
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

    final dStopLossPips = computeStopLossPip(state.pipDecimalPlaces);
    final stopLossPips = dStopLossPips.toDouble();
    var stopLossPrice = state.stopLossPrice ?? 0.0;

    if (stopLossPrice <= 0) {
      stopLossPrice = computeStopPrice(state.pipDecimalPlaces).toDouble();
    }

    final dAmountAtRisk = computeAmountAtRisk();
    final amountAtRisk = dAmountAtRisk.toDouble();
    final dRiskRatio = computeRiskPercent(amountAtRisk, state.accountSize);
    final dPipValue = computePipValue(
      counterToAccountCurrencyRate: state.counterToAccountCurrencyRate,
      isAccountCurrencyCounter: state.isAccountCurrencyCounter,
      instrumentPairRate: state.instrumentPairRate,
      pipDecimalPlaces: state.pipDecimalPlaces,
      positionSize: 1,
    );

    final size = dPipValue > dZero && stopLossPips > 0
        ? computePositionSize(amountAtRisk, dPipValue.toDouble(), stopLossPips)
        : dZero;

    return (result = MatexForexPositionSizeCalculatorResults(
      pipValue: (dPipValue * size).toDouble(),
      riskPercent: dRiskRatio.toDouble(),
      positionSize: size.toDouble(),
      amountAtRisk: amountAtRisk,
      stopLossPips: stopLossPips,
      stopLossPrice: stopLossPrice,
    ));
  }

  @protected
  Decimal computePositionSize(
    double amountAtRisk,
    double pipValue,
    double stopLossPip,
  ) {
    final dPipValue = toDecimal(pipValue) ?? dZero;
    final dStopLossPip = toDecimal(stopLossPip) ?? dZero;
    final divider = dPipValue * dStopLossPip;

    if (divider == dZero) return dZero;

    final dAmountAtRisk = toDecimal(amountAtRisk) ?? dZero;

    return decimalFromRational(dAmountAtRisk / divider);
  }

  @protected
  Decimal computeRiskPercent(double amountAtRisk, double? accountSize) {
    final riskPercent = state.riskPercent ?? 0.0;

    if (accountSize == null || accountSize <= 0) return dZero;
    if (riskPercent > 0) return toDecimal(riskPercent)!;

    final dAccountSize = toDecimal(accountSize) ?? dZero;

    if (dAccountSize == dZero) return dZero;

    final dAmountAtRisk = toDecimal(amountAtRisk) ?? dZero;

    return decimalFromRational(dAmountAtRisk / dAccountSize);
  }

  @protected
  Decimal computeAmountAtRisk() {
    final riskAmount = state.riskAmount ?? 0.0;

    if (riskAmount > 0) return toDecimal(riskAmount)!;

    final riskRatio = state.riskPercent;
    final accountSize = state.accountSize;

    if (accountSize == null ||
        riskRatio == null ||
        accountSize < 0 ||
        riskRatio < 0 ||
        riskRatio > 1) return dZero;

    final dRiskRatio = toDecimal(riskRatio) ?? dZero;
    final dAccountSize = toDecimal(accountSize) ?? dZero;

    return dRiskRatio * dAccountSize;
  }

  @protected
  Decimal computeStopPrice(int? pipDecimalPlaces) {
    if (pipDecimalPlaces == null) return dZero;

    final dPipDecimalPlaces = toDecimal(pipDecimalPlaces) ?? dZero;
    final dEntryPrice = toDecimal(state.instrumentPairRate) ?? dZero;
    final dStopLossPips = toDecimal(state.stopLossPips) ?? dZero;
    // fixme: add support for short positions
    const isBuyPosition = true;

    if (dEntryPrice <= dZero ||
        dStopLossPips <= dZero ||
        dPipDecimalPlaces < dZero) {
      return dZero;
    }

    final decimalMultiplicator = 1 / pow(10, pipDecimalPlaces);
    final dDecimalMultiplicator = toDecimal(decimalMultiplicator)!;

    if (isBuyPosition) {
      // For a buy position, the stop price is below the entry price
      return dEntryPrice - (dStopLossPips * dDecimalMultiplicator);
    }

    // ignore: dead_code
    return dEntryPrice + (dStopLossPips * dDecimalMultiplicator);
  }

  @protected
  Decimal computeStopLossPip(int? pipDecimalPlaces) {
    if (pipDecimalPlaces == null) return dZero;

    final stopLossPips = state.stopLossPips ?? 0.0;

    if (stopLossPips > 0) return toDecimal(stopLossPips)!;

    final stopLossPrice = state.stopLossPrice ?? 0.0;
    final entryPrice = state.entryPrice ?? 0.0;

    if (entryPrice <= 0 || stopLossPrice <= 0) return dZero;

    final decimalMultiplicator = pow(10, pipDecimalPlaces).toString();
    final dDecimalMultiplicator = toDecimal(decimalMultiplicator)!;
    final dStopLossPrice = toDecimal(stopLossPrice) ?? dZero;
    final dEntryPrice = toDecimal(entryPrice) ?? dZero;
    final deltaPrice = (dEntryPrice - dStopLossPrice).abs();

    return deltaPrice * dDecimalMultiplicator;
  }
}
