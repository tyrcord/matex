// Package imports:
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexForexProfitLossCalculatorState extends MatexCalculatorState {
  final double? positionSize;
  final int pipDecimalPlaces;
  final bool isAccountCurrencyCounter;
  final double counterToAccountCurrencyRate;
  final double instrumentPairRate;
  final double? exitPrice;
  final double? entryPrice;
  final MatexPosition position;

  const MatexForexProfitLossCalculatorState({
    this.positionSize,
    int? pipDecimalPlaces,
    bool? isAccountCurrencyCounter,
    double? counterToAccountCurrencyRate,
    double? instrumentPairRate,
    this.exitPrice,
    this.entryPrice,
    MatexPosition? position,
  })  : position = position ?? MatexPosition.long,
        pipDecimalPlaces = pipDecimalPlaces ?? kMatexDefaultPipDecimalPlaces,
        counterToAccountCurrencyRate = counterToAccountCurrencyRate ?? 0,
        isAccountCurrencyCounter = isAccountCurrencyCounter ?? false,
        instrumentPairRate = instrumentPairRate ?? 0;

  @override
  MatexForexProfitLossCalculatorState clone() => copyWith();

  @override
  MatexForexProfitLossCalculatorState copyWith({
    double? positionSize,
    int? pipDecimalPlaces,
    bool? isAccountCurrencyCounter,
    double? counterToAccountCurrencyRate,
    double? instrumentPairRate,
    double? exitPrice,
    double? entryPrice,
    MatexPosition? position,
  }) {
    return MatexForexProfitLossCalculatorState(
      positionSize: positionSize ?? this.positionSize,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      isAccountCurrencyCounter:
          isAccountCurrencyCounter ?? this.isAccountCurrencyCounter,
      counterToAccountCurrencyRate:
          counterToAccountCurrencyRate ?? this.counterToAccountCurrencyRate,
      instrumentPairRate: instrumentPairRate ?? this.instrumentPairRate,
      exitPrice: exitPrice ?? this.exitPrice,
      entryPrice: entryPrice ?? this.entryPrice,
      position: position ?? this.position,
    );
  }

  @override
  MatexForexProfitLossCalculatorState merge(
    covariant MatexForexProfitLossCalculatorState model,
  ) {
    return copyWith(
      positionSize: model.positionSize,
      pipDecimalPlaces: model.pipDecimalPlaces,
      isAccountCurrencyCounter: model.isAccountCurrencyCounter,
      counterToAccountCurrencyRate: model.counterToAccountCurrencyRate,
      instrumentPairRate: model.instrumentPairRate,
      exitPrice: model.exitPrice,
      entryPrice: model.entryPrice,
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
        exitPrice,
        entryPrice,
        position,
      ];
}
