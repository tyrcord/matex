import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:t_helpers/helpers.dart';

Decimal computePipValue({
  double? counterToAccountCurrencyRate = 0,
  bool? isAccountCurrencyCounter = false,
  double? instrumentPairRate = 0,
  int? pipDecimalPlaces = 0,
  double? positionSize = 0,
}) {
  final dPositionSize = toDecimalOrDefault(positionSize);
  final decimalMultiplicator = pow(10, pipDecimalPlaces ?? 0);
  final dDecimalMultiplicator = toDecimalOrDefault(decimalMultiplicator);
  final dDecimalPip = decimalFromRational(dOne / dDecimalMultiplicator);
  final pipValue = dPositionSize * dDecimalPip;

  isAccountCurrencyCounter ??= false;
  instrumentPairRate ??= 0;

  if (isAccountCurrencyCounter) return pipValue;

  if (counterToAccountCurrencyRate == 0) {
    final dInstrumentPairRate = toDecimal(instrumentPairRate) ?? dOne;

    return decimalFromRational(pipValue / dInstrumentPairRate);
  }

  final dCounterToAccountCurrencyRate =
      toDecimal(counterToAccountCurrencyRate) ?? dOne;

  return pipValue * dCounterToAccountCurrencyRate;
}

Decimal computePipDelta({
  double? entryPrice = 0,
  double? exitPrice = 0,
  num pipDecimalPlaces = 0,
}) {
  final dEntryPrice = toDecimalOrDefault(entryPrice);
  final dExitPrice = toDecimalOrDefault(exitPrice);
  final decimalMultiplicator = pow(10, pipDecimalPlaces);
  final dDecimalMultiplicator = toDecimalOrDefault(decimalMultiplicator);
  final dDelta = (dEntryPrice - dExitPrice) * dDecimalMultiplicator;

  return dDelta;
}
