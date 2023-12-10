// Package imports:
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexForexRequiredMarginCalculatorState extends MatexCalculatorState {
  final double? positionSize;
  final int pipDecimalPlaces;
  final bool isAccountCurrencyCounter;
  final double counterToAccountCurrencyRate;
  final double instrumentPairRate;
  final double leverage;

  const MatexForexRequiredMarginCalculatorState({
    this.pipDecimalPlaces = kDefaultPipPipDecimalPlaces,
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
    int? pipDecimalPlaces,
    bool? isAccountCurrencyCounter,
    double? counterToAccountCurrencyRate,
    double? instrumentPairRate,
    double? leverage,
  }) {
    return MatexForexRequiredMarginCalculatorState(
      positionSize: positionSize ?? this.positionSize,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
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
    bool resetPipDecimalPlaces = false,
    bool resetIsAccountCurrencyCounter = false,
    bool resetCounterToAccountCurrencyRate = false,
    bool resetInstrumentPairRate = false,
    bool resetLeverage = false,
  }) {
    return MatexForexRequiredMarginCalculatorState(
      positionSize: resetPositionSize ? null : positionSize,
      pipDecimalPlaces: resetPipDecimalPlaces
          ? kDefaultPipPipDecimalPlaces
          : pipDecimalPlaces,
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
      pipDecimalPlaces: model.pipDecimalPlaces,
      isAccountCurrencyCounter: model.isAccountCurrencyCounter,
      counterToAccountCurrencyRate: model.counterToAccountCurrencyRate,
      instrumentPairRate: model.instrumentPairRate,
      leverage: model.leverage,
    );
  }

  @override
  List<Object?> get props => [
        positionSize,
        pipDecimalPlaces,
        isAccountCurrencyCounter,
        counterToAccountCurrencyRate,
        instrumentPairRate,
        leverage,
      ];
}
