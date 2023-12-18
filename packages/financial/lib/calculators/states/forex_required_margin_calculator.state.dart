// Package imports:
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexForexRequiredMarginCalculatorState extends MatexCalculatorState {
  final double counterToAccountCurrencyRate;
  final bool isAccountCurrencyCounter;
  final bool isAccountCurrencyBase;
  final double instrumentPairRate;
  final double? positionSize;
  final double leverage;

  const MatexForexRequiredMarginCalculatorState({
    double? counterToAccountCurrencyRate,
    bool? isAccountCurrencyCounter,
    bool? isAccountCurrencyBase,
    double? instrumentPairRate,
    double? leverage,
    this.positionSize,
  })  : counterToAccountCurrencyRate = counterToAccountCurrencyRate ?? 0,
        isAccountCurrencyCounter = isAccountCurrencyCounter ?? false,
        isAccountCurrencyBase = isAccountCurrencyBase ?? false,
        leverage = leverage ?? kMatexDefaultLeverage,
        instrumentPairRate = instrumentPairRate ?? 0;

  @override
  MatexForexRequiredMarginCalculatorState clone() => copyWith();

  @override
  MatexForexRequiredMarginCalculatorState copyWith({
    double? counterToAccountCurrencyRate,
    bool? isAccountCurrencyCounter,
    bool? isAccountCurrencyBase,
    double? instrumentPairRate,
    double? positionSize,
    double? leverage,
  }) {
    return MatexForexRequiredMarginCalculatorState(
      instrumentPairRate: instrumentPairRate ?? this.instrumentPairRate,
      positionSize: positionSize ?? this.positionSize,
      leverage: leverage ?? this.leverage,
      isAccountCurrencyCounter:
          isAccountCurrencyCounter ?? this.isAccountCurrencyCounter,
      counterToAccountCurrencyRate:
          counterToAccountCurrencyRate ?? this.counterToAccountCurrencyRate,
      isAccountCurrencyBase:
          isAccountCurrencyBase ?? this.isAccountCurrencyBase,
    );
  }

  @override
  MatexForexRequiredMarginCalculatorState copyWithDefaults({
    bool resetCounterToAccountCurrencyRate = false,
    bool resetIsAccountCurrencyCounter = false,
    bool resetIsAccountCurrencyBase = false,
    bool resetInstrumentPairRate = false,
    bool resetPositionSize = false,
    bool resetLeverage = false,
  }) {
    return MatexForexRequiredMarginCalculatorState(
      instrumentPairRate: resetInstrumentPairRate ? null : instrumentPairRate,
      positionSize: resetPositionSize ? null : positionSize,
      leverage: resetLeverage ? null : leverage,
      isAccountCurrencyBase:
          resetIsAccountCurrencyBase ? false : isAccountCurrencyBase,
      isAccountCurrencyCounter:
          resetIsAccountCurrencyCounter ? null : isAccountCurrencyCounter,
      counterToAccountCurrencyRate: resetCounterToAccountCurrencyRate
          ? null
          : counterToAccountCurrencyRate,
    );
  }

  @override
  MatexForexRequiredMarginCalculatorState merge(
    covariant MatexForexRequiredMarginCalculatorState model,
  ) {
    return copyWith(
      counterToAccountCurrencyRate: model.counterToAccountCurrencyRate,
      isAccountCurrencyCounter: model.isAccountCurrencyCounter,
      isAccountCurrencyBase: model.isAccountCurrencyBase,
      instrumentPairRate: model.instrumentPairRate,
      positionSize: model.positionSize,
      leverage: model.leverage,
    );
  }

  @override
  List<Object?> get props => [
        counterToAccountCurrencyRate,
        isAccountCurrencyCounter,
        isAccountCurrencyBase,
        instrumentPairRate,
        positionSize,
        leverage,
      ];
}
