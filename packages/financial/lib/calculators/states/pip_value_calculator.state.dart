// Package imports:
import 'package:matex_core/core.dart';
import 'package:matex_dart/matex_dart.dart' show MatexLotDescriptors;

class MatexPipValueCalculatorState extends MatexCalculatorState {
  final double? positionSize;
  final int? pipDecimalPlaces;
  final bool isAccountCurrencyCounterCurrency;
  final double counterToAccountCurrencyRate;
  final double instrumentPairRate;
  final MatexLotDescriptors? lotDescriptors;

  const MatexPipValueCalculatorState({
    this.positionSize,
    this.pipDecimalPlaces,
    this.isAccountCurrencyCounterCurrency = false,
    this.counterToAccountCurrencyRate = 0,
    this.instrumentPairRate = 0,
    this.lotDescriptors,
  });

  @override
  MatexPipValueCalculatorState clone() => copyWith();

  @override
  MatexPipValueCalculatorState copyWith({
    double? positionSize,
    int? pipDecimalPlaces,
    bool? isAccountCurrencyCounterCurrency,
    double? counterToAccountCurrencyRate,
    double? instrumentPairRate,
    MatexLotDescriptors? lotDescriptors,
  }) {
    return MatexPipValueCalculatorState(
      positionSize: positionSize ?? this.positionSize,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      isAccountCurrencyCounterCurrency: isAccountCurrencyCounterCurrency ??
          this.isAccountCurrencyCounterCurrency,
      counterToAccountCurrencyRate:
          counterToAccountCurrencyRate ?? this.counterToAccountCurrencyRate,
      instrumentPairRate: instrumentPairRate ?? this.instrumentPairRate,
      lotDescriptors: lotDescriptors ?? this.lotDescriptors,
    );
  }

  @override
  MatexPipValueCalculatorState merge(
    covariant MatexPipValueCalculatorState model,
  ) {
    return copyWith(
      positionSize: model.positionSize,
      pipDecimalPlaces: model.pipDecimalPlaces,
      isAccountCurrencyCounterCurrency: model.isAccountCurrencyCounterCurrency,
      counterToAccountCurrencyRate: model.counterToAccountCurrencyRate,
      instrumentPairRate: model.instrumentPairRate,
      lotDescriptors: model.lotDescriptors,
    );
  }

  @override
  List<Object?> get props => [
        positionSize,
        pipDecimalPlaces,
        isAccountCurrencyCounterCurrency,
        counterToAccountCurrencyRate,
        instrumentPairRate,
        lotDescriptors,
      ];
}
