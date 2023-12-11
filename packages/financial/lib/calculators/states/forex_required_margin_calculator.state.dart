// Package imports:
import 'package:matex_core/core.dart';

class MatexForexRequiredMarginCalculatorState extends MatexCalculatorState {
  final double? positionSize;
  final bool isAccountCurrencyCounter;
  final double counterToAccountCurrencyRate;
  final double instrumentPairRate;
  final double leverage;
  final bool isAccountCurrencyBase;

  const MatexForexRequiredMarginCalculatorState({
    this.isAccountCurrencyCounter = false,
    this.isAccountCurrencyBase = false,
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
    bool? isAccountCurrencyBase,
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
      isAccountCurrencyBase:
          isAccountCurrencyBase ?? this.isAccountCurrencyBase,
    );
  }

  @override
  MatexForexRequiredMarginCalculatorState copyWithDefaults({
    bool resetPositionSize = false,
    bool resetIsAccountCurrencyCounter = false,
    bool resetCounterToAccountCurrencyRate = false,
    bool resetInstrumentPairRate = false,
    bool resetLeverage = false,
    bool resetIsAccountCurrencyBase = false,
  }) {
    return MatexForexRequiredMarginCalculatorState(
      positionSize: resetPositionSize ? null : positionSize,
      isAccountCurrencyCounter:
          resetIsAccountCurrencyCounter ? false : isAccountCurrencyCounter,
      counterToAccountCurrencyRate:
          resetCounterToAccountCurrencyRate ? 0 : counterToAccountCurrencyRate,
      instrumentPairRate: resetInstrumentPairRate ? 0 : instrumentPairRate,
      leverage: resetLeverage ? 1 : leverage,
      isAccountCurrencyBase:
          resetIsAccountCurrencyBase ? false : isAccountCurrencyBase,
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
      isAccountCurrencyBase: model.isAccountCurrencyBase,
    );
  }

  @override
  List<Object?> get props => [
        positionSize,
        isAccountCurrencyCounter,
        counterToAccountCurrencyRate,
        instrumentPairRate,
        leverage,
        isAccountCurrencyBase,
      ];
}
