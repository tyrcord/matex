// Package imports:
import 'package:matex_core/core.dart';

class MatexForexRequiredMarginCalculatorState extends MatexCalculatorState {
  final double? positionSize;
  final bool isAccountCurrencyCounter;
  final double counterToAccountCurrencyRate;
  final double instrumentPairRate;
  final double leverage;

  const MatexForexRequiredMarginCalculatorState({
    this.isAccountCurrencyCounter = false,
    this.counterToAccountCurrencyRate = 0,
    this.instrumentPairRate = 0,
    this.leverage = 1,
    this.positionSize,
  });

  @override
  MatexForexRequiredMarginCalculatorState clone() => copyWith();

  @override
  MatexForexRequiredMarginCalculatorState copyWith({
    double? positionSize,
    bool? isAccountCurrencyCounter,
    double? counterToAccountCurrencyRate,
    double? instrumentPairRate,
    double? leverage,
  }) {
    return MatexForexRequiredMarginCalculatorState(
      positionSize: positionSize ?? this.positionSize,
      isAccountCurrencyCounter:
          isAccountCurrencyCounter ?? this.isAccountCurrencyCounter,
      counterToAccountCurrencyRate:
          counterToAccountCurrencyRate ?? this.counterToAccountCurrencyRate,
      instrumentPairRate: instrumentPairRate ?? this.instrumentPairRate,
      leverage: leverage ?? this.leverage,
    );
  }

  @override
  MatexForexRequiredMarginCalculatorState copyWithDefaults({
    bool resetPositionSize = false,
    bool resetIsAccountCurrencyCounter = false,
    bool resetCounterToAccountCurrencyRate = false,
    bool resetInstrumentPairRate = false,
    bool resetLeverage = false,
  }) {
    return MatexForexRequiredMarginCalculatorState(
      positionSize: resetPositionSize ? null : positionSize,
      isAccountCurrencyCounter:
          resetIsAccountCurrencyCounter ? false : isAccountCurrencyCounter,
      counterToAccountCurrencyRate:
          resetCounterToAccountCurrencyRate ? 0 : counterToAccountCurrencyRate,
      instrumentPairRate: resetInstrumentPairRate ? 0 : instrumentPairRate,
      leverage: resetLeverage ? 1 : leverage,
    );
  }

  @override
  MatexForexRequiredMarginCalculatorState merge(
    covariant MatexForexRequiredMarginCalculatorState model,
  ) {
    return copyWith(
      positionSize: model.positionSize,
      isAccountCurrencyCounter: model.isAccountCurrencyCounter,
      counterToAccountCurrencyRate: model.counterToAccountCurrencyRate,
      instrumentPairRate: model.instrumentPairRate,
      leverage: model.leverage,
    );
  }

  @override
  List<Object?> get props => [
        positionSize,
        isAccountCurrencyCounter,
        counterToAccountCurrencyRate,
        instrumentPairRate,
        leverage,
      ];
}
