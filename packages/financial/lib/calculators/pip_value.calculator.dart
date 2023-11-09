// Dart imports:
import 'dart:math';

// Package imports:
import 'package:decimal/decimal.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

import 'package:matex_dart/matex_dart.dart'
    show MatexLotDescriptors, MatexLotDescriptor;

class MatexPipValueCalculator extends MatexCalculator<
    MatexPipValueCalculatorState, MatexPipValueCalculatorResults> {
  MatexPipValueCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: pipValueValidators);

  @override
  MatexPipValueCalculatorState initializeState() =>
      const MatexPipValueCalculatorState();

  @override
  MatexPipValueCalculatorState initializeDefaultState() => initializeState();

  double getPositionSizeFromLotDescriptor({
    MatexLotDescriptor? descriptor,
    num? value = 0,
  }) {
    if (descriptor != null && descriptor.exists) {
      final multiplier = descriptor.multiplier;

      if (value != null) {
        return (toDecimal(value)! * toDecimal(multiplier)!).toDouble();
      }
    }

    return 0;
  }

  set lotDescriptors(MatexLotDescriptors lotDescriptors) {
    setState(state.copyWith(lotDescriptors: lotDescriptors));
  }

  set positionSize(double? value) {
    setState(state.copyWith(positionSize: value));
  }

  set pipDecimalPlaces(int? value) {
    setState(state.copyWith(pipDecimalPlaces: value));
  }

  set isAccountCurrencyCounterCurrency(bool? value) {
    setState(state.copyWith(isAccountCurrencyCounterCurrency: value));
  }

  set counterToAccountCurrencyRate(double? value) {
    setState(state.copyWith(counterToAccountCurrencyRate: value));
  }

  double? get counterToAccountCurrencyRate {
    return state.counterToAccountCurrencyRate;
  }

  set instrumentPairRate(double? value) {
    setState(state.copyWith(instrumentPairRate: value));
  }

  double? get instrumentPairRate => state.instrumentPairRate;

  set lot(double lot) {
    positionSize = getPositionSizeFromLotDescriptor(
      descriptor: state.lotDescriptors?.standard,
      value: lot,
    );
  }

  set microLot(double microLot) {
    positionSize = getPositionSizeFromLotDescriptor(
      descriptor: state.lotDescriptors?.micro,
      value: microLot,
    );
  }

  set miniLot(double miniLot) {
    positionSize = getPositionSizeFromLotDescriptor(
      descriptor: state.lotDescriptors?.mini,
      value: miniLot,
    );
  }

  set nanoLot(double nanoLot) {
    positionSize = getPositionSizeFromLotDescriptor(
      descriptor: state.lotDescriptors?.nano,
      value: nanoLot,
    );
  }

  static const defaultResults = MatexPipValueCalculatorResults(
    pipValue: 0,
  );

  @override
  MatexPipValueCalculatorResults value() {
    if (!isValid) return defaultResults;

    final pipValue = computePipValue();

    return MatexPipValueCalculatorResults(
      pipValue: pipValue.toDouble(),
    );
  }

  Decimal computePipValue() {
    final counterToAccountCurrencyRate = state.counterToAccountCurrencyRate;
    final isAccountCurrencyCounterCurrency =
        state.isAccountCurrencyCounterCurrency;
    final dPositionSize = toDecimal(state.positionSize) ?? dZero;
    final pipDecimalPlaces = state.pipDecimalPlaces ?? 0;
    final decimalMultiplicator = pow(10, pipDecimalPlaces);
    final dDecimalMultiplicator = toDecimal(decimalMultiplicator)!;
    final dDecimalPip = decimalFromRational(dOne / dDecimalMultiplicator);
    final pipValue = dPositionSize * dDecimalPip;

    if (isAccountCurrencyCounterCurrency) return pipValue;

    if (counterToAccountCurrencyRate == 0) {
      final dInstrumentPairRate = toDecimal(state.instrumentPairRate) ?? dOne;

      return decimalFromRational(pipValue / dInstrumentPairRate);
    }

    final dCounterToAccountCurrencyRate =
        toDecimal(counterToAccountCurrencyRate) ?? dOne;

    return pipValue * dCounterToAccountCurrencyRate;
  }
}
