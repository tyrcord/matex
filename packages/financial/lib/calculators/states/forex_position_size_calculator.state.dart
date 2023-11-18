// Package imports:
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexForexPositionSizeCalculatorState extends MatexCalculatorState {
  final double? positionSize;
  final int? pipDecimalPlaces;
  final bool isAccountCurrencyCounter;
  final double counterToAccountCurrencyRate;
  final double instrumentPairRate;
  final double? microLot;
  final double? miniLot;
  final double? standardLot;
  final double? nanoLot;

  const MatexForexPositionSizeCalculatorState({
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
  MatexForexPositionSizeCalculatorState clone() => copyWith();

  @override
  MatexForexPositionSizeCalculatorState copyWith({
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
    return MatexForexPositionSizeCalculatorState(
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
  MatexForexPositionSizeCalculatorState merge(
    covariant MatexForexPositionSizeCalculatorState model,
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
