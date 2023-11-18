// Package imports:
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexForexPipValueCalculatorState extends MatexCalculatorState {
  final double? positionSize;
  final int? pipDecimalPlaces;
  final bool isAccountCurrencyCounter;
  final double counterToAccountCurrencyRate;
  final double instrumentPairRate;
  final double? microLot;
  final double? miniLot;
  final double? standardLot;
  final double? nanoLot;

  const MatexForexPipValueCalculatorState({
    this.positionSize,
    this.pipDecimalPlaces,
    this.isAccountCurrencyCounter = false,
    this.counterToAccountCurrencyRate = 0,
    this.instrumentPairRate = 0,
    this.microLot,
    this.miniLot,
    this.standardLot,
    this.nanoLot,
  });

  @override
  MatexForexPipValueCalculatorState clone() => copyWith();

  @override
  MatexForexPipValueCalculatorState copyWith({
    double? positionSize,
    int? pipDecimalPlaces,
    bool? isAccountCurrencyCounter,
    double? counterToAccountCurrencyRate,
    double? instrumentPairRate,
    MatexLotDescriptors? lotDescriptors,
    double? microLot,
    double? miniLot,
    double? standardLot,
    double? nanoLot,
  }) {
    return MatexForexPipValueCalculatorState(
      positionSize: positionSize ?? this.positionSize,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      isAccountCurrencyCounter:
          isAccountCurrencyCounter ?? this.isAccountCurrencyCounter,
      counterToAccountCurrencyRate:
          counterToAccountCurrencyRate ?? this.counterToAccountCurrencyRate,
      instrumentPairRate: instrumentPairRate ?? this.instrumentPairRate,
      microLot: microLot ?? this.microLot,
      miniLot: miniLot ?? this.miniLot,
      standardLot: standardLot ?? this.standardLot,
      nanoLot: nanoLot ?? this.nanoLot,
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
      microLot: model.microLot,
      miniLot: model.miniLot,
      standardLot: model.standardLot,
      nanoLot: model.nanoLot,
    );
  }

  @override
  List<Object?> get props => [
        positionSize,
        pipDecimalPlaces,
        isAccountCurrencyCounter,
        counterToAccountCurrencyRate,
        instrumentPairRate,
        microLot,
        miniLot,
        standardLot,
        nanoLot,
      ];
}
