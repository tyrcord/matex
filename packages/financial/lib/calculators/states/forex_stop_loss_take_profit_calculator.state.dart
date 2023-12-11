// Package imports:
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexForexStopLossTakeProfitCalculatorState extends MatexCalculatorState {
  final double? positionSize;
  final int pipDecimalPlaces;
  final bool isAccountCurrencyCounter;
  final double counterToAccountCurrencyRate;
  final double instrumentPairRate;
  final double? entryPrice;
  final double? stopLossPrice;
  final double? stopLossPips;
  final double? stopLossAmount;
  final double? takeProfitPrice;
  final double? takeProfitPips;
  final double? takeProfitAmount;
  final MatexPosition position;

  const MatexForexStopLossTakeProfitCalculatorState({
    this.pipDecimalPlaces = kDefaultPipPipDecimalPlaces,
    this.isAccountCurrencyCounter = false,
    this.counterToAccountCurrencyRate = 0,
    this.instrumentPairRate = 0,
    this.positionSize,
    this.entryPrice,
    this.stopLossPrice,
    this.stopLossPips,
    this.stopLossAmount,
    this.takeProfitPrice,
    this.takeProfitPips,
    this.takeProfitAmount,
    MatexPosition? position,
  }) : position = position ?? MatexPosition.long;

  @override
  MatexForexStopLossTakeProfitCalculatorState clone() => copyWith();

  @override
  MatexForexStopLossTakeProfitCalculatorState copyWith({
    double? positionSize,
    int? pipDecimalPlaces,
    bool? isAccountCurrencyCounter,
    double? counterToAccountCurrencyRate,
    double? instrumentPairRate,
    double? entryPrice,
    double? stopLossPrice,
    double? stopLossPips,
    double? stopLossAmount,
    double? takeProfitPrice,
    double? takeProfitPips,
    double? takeProfitAmount,
    MatexPosition? position,
  }) {
    return MatexForexStopLossTakeProfitCalculatorState(
      positionSize: positionSize ?? this.positionSize,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      isAccountCurrencyCounter:
          isAccountCurrencyCounter ?? this.isAccountCurrencyCounter,
      counterToAccountCurrencyRate:
          counterToAccountCurrencyRate ?? this.counterToAccountCurrencyRate,
      instrumentPairRate: instrumentPairRate ?? this.instrumentPairRate,
      entryPrice: entryPrice ?? this.entryPrice,
      stopLossPrice: stopLossPrice ?? this.stopLossPrice,
      stopLossPips: stopLossPips ?? this.stopLossPips,
      stopLossAmount: stopLossAmount ?? this.stopLossAmount,
      takeProfitPrice: takeProfitPrice ?? this.takeProfitPrice,
      takeProfitPips: takeProfitPips ?? this.takeProfitPips,
      takeProfitAmount: takeProfitAmount ?? this.takeProfitAmount,
      position: position ?? this.position,
    );
  }

  @override
  MatexForexStopLossTakeProfitCalculatorState merge(
    covariant MatexForexStopLossTakeProfitCalculatorState model,
  ) {
    return copyWith(
      positionSize: model.positionSize,
      pipDecimalPlaces: model.pipDecimalPlaces,
      isAccountCurrencyCounter: model.isAccountCurrencyCounter,
      counterToAccountCurrencyRate: model.counterToAccountCurrencyRate,
      instrumentPairRate: model.instrumentPairRate,
      entryPrice: model.entryPrice,
      stopLossPrice: model.stopLossPrice,
      stopLossPips: model.stopLossPips,
      stopLossAmount: model.stopLossAmount,
      takeProfitPrice: model.takeProfitPrice,
      takeProfitPips: model.takeProfitPips,
      takeProfitAmount: model.takeProfitAmount,
      position: model.position,
    );
  }

  @override
  List<Object?> get props => [
        positionSize,
        pipDecimalPlaces,
        isAccountCurrencyCounter,
        counterToAccountCurrencyRate,
        instrumentPairRate,
        entryPrice,
        stopLossPrice,
        stopLossPips,
        stopLossAmount,
        takeProfitPrice,
        takeProfitPips,
        takeProfitAmount,
        position,
      ];
}
