// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

final List<
        MatexCalculatorValidator<MatexForexStopLossTakeProfitCalculatorState>>
    forexStopLossTakeProfitValidators = [
  _isPositionSizeNotNull,
  _isPositionSizeAndInstrumentPairRateValid,
  (state) => state.entryPrice != null && state.entryPrice! > 0,
  (state) {
    final stopLossAmount = state.stopLossAmount;
    final stopLossPrice = state.stopLossPrice;
    final stopLossPips = state.stopLossPips;
    final takeProfitAmount = state.takeProfitAmount;
    final takeProfitPrice = state.takeProfitPrice;
    final takeProfitPips = state.takeProfitPips;

    return (((stopLossAmount != null && stopLossAmount > 0) ||
            (stopLossPrice != null && stopLossPrice > 0) ||
            (stopLossPips != null && stopLossPips > 0)) ||
        ((takeProfitAmount != null && takeProfitAmount > 0) ||
            (takeProfitPrice != null && takeProfitPrice > 0) ||
            (takeProfitPips != null && takeProfitPips > 0)));
  },
];

// Validator: Check if the position size is not null
bool _isPositionSizeNotNull(MatexForexStopLossTakeProfitCalculatorState state) {
  return state.positionSize != null;
}

// Validator: Check if both position size and instrument pair rate are valid
bool _isPositionSizeAndInstrumentPairRateValid(
  MatexForexStopLossTakeProfitCalculatorState state,
) {
  return state.positionSize! > 0 && state.instrumentPairRate > 0;
}
