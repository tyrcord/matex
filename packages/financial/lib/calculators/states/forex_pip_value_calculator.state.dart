// Package imports:
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexForexPipValueCalculatorState extends MatexCalculatorState {
  final double? positionSize;
  final int pipDecimalPlaces;
  final bool isAccountCurrencyCounter;
  final double counterToAccountCurrencyRate;
  final double instrumentPairRate;

  const MatexForexPipValueCalculatorState({
    int? pipDecimalPlaces,
    bool? isAccountCurrencyCounter,
    double? counterToAccountCurrencyRate,
    double? instrumentPairRate,
    this.positionSize,
  })  : pipDecimalPlaces = pipDecimalPlaces ?? kDefaultPipPipDecimalPlaces,
        counterToAccountCurrencyRate = counterToAccountCurrencyRate ?? 0,
        isAccountCurrencyCounter = isAccountCurrencyCounter ?? false,
        instrumentPairRate = instrumentPairRate ?? 0;

  @override
  MatexForexPipValueCalculatorState clone() => copyWith();

  @override
  MatexForexPipValueCalculatorState copyWith({
    double? positionSize,
    int? pipDecimalPlaces,
    bool? isAccountCurrencyCounter,
    double? counterToAccountCurrencyRate,
    double? instrumentPairRate,
  }) {
    return MatexForexPipValueCalculatorState(
      positionSize: positionSize ?? this.positionSize,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      isAccountCurrencyCounter:
          isAccountCurrencyCounter ?? this.isAccountCurrencyCounter,
      counterToAccountCurrencyRate:
          counterToAccountCurrencyRate ?? this.counterToAccountCurrencyRate,
      instrumentPairRate: instrumentPairRate ?? this.instrumentPairRate,
    );
  }

  @override
  MatexForexPipValueCalculatorState merge(
    covariant MatexForexPipValueCalculatorState model,
  ) {
    return copyWith(
      positionSize: model.positionSize,
      pipDecimalPlaces: model.pipDecimalPlaces,
      isAccountCurrencyCounter: model.isAccountCurrencyCounter,
      counterToAccountCurrencyRate: model.counterToAccountCurrencyRate,
      instrumentPairRate: model.instrumentPairRate,
    );
  }

  @override
  List<Object?> get props => [
        positionSize,
        pipDecimalPlaces,
        isAccountCurrencyCounter,
        counterToAccountCurrencyRate,
        instrumentPairRate,
      ];
}
