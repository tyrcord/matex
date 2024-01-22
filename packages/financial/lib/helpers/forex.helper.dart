// Dart imports:
import 'dart:math';

double computePipValue({
  double? counterToAccountCurrencyRate = 0,
  bool? isAccountCurrencyCounter = false,
  double? instrumentPairRate = 0,
  int? pipDecimalPlaces = 0,
  double? positionSize = 0,
}) {
  final decimalMultiplicator = pow(10, pipDecimalPlaces ?? 0);
  final dDecimalPip = 1 / decimalMultiplicator;
  positionSize ??= 0;
  final pipValue = positionSize * dDecimalPip;

  isAccountCurrencyCounter ??= false;
  instrumentPairRate ??= 0;

  if (isAccountCurrencyCounter) return pipValue;

  if (counterToAccountCurrencyRate == 0) {
    final dInstrumentPairRate = instrumentPairRate > 0 ? instrumentPairRate : 1;

    return (pipValue / dInstrumentPairRate);
  }

  final dCounterToAccountCurrencyRate = counterToAccountCurrencyRate ?? 1;

  return pipValue * dCounterToAccountCurrencyRate;
}

double computePipDelta({
  double? entryPrice = 0,
  double? exitPrice = 0,
  num pipDecimalPlaces = 0,
}) {
  final decimalMultiplicator = pow(10, pipDecimalPlaces);

  entryPrice ??= 0;
  exitPrice ??= 0;

  return (exitPrice - entryPrice) * decimalMultiplicator;
}
