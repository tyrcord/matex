// Package imports:
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexPipValueCalculatorState extends MatexCalculatorState {
  final double? positionSize;
  final int? pipDecimalPlaces;
  final bool isAccountCurrencyCounter;
  final double counterToAccountCurrencyRate;
  final double instrumentPairRate;
  final MatexLotDescriptors? lotDescriptors;

  const MatexPipValueCalculatorState({
    this.positionSize,
    this.pipDecimalPlaces,
    this.isAccountCurrencyCounter = false,
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
    bool? isAccountCurrencyCounter,
    double? counterToAccountCurrencyRate,
    double? instrumentPairRate,
    MatexLotDescriptors? lotDescriptors,
  }) {
    return MatexPipValueCalculatorState(
      positionSize: positionSize ?? this.positionSize,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      isAccountCurrencyCounter:
          isAccountCurrencyCounter ?? this.isAccountCurrencyCounter,
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
      isAccountCurrencyCounter: model.isAccountCurrencyCounter,
      counterToAccountCurrencyRate: model.counterToAccountCurrencyRate,
      instrumentPairRate: model.instrumentPairRate,
      lotDescriptors: model.lotDescriptors,
    );
  }

  @override
  List<Object?> get props => [
        positionSize,
        pipDecimalPlaces,
        isAccountCurrencyCounter,
        counterToAccountCurrencyRate,
        instrumentPairRate,
        lotDescriptors,
      ];
}
