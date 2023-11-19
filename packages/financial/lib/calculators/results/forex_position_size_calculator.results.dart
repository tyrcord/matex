// Package imports:
import 'package:matex_core/core.dart';

class MatexForexPositionSizeCalculatorResults extends MatexCalculatorState {
  final double? pipValue;
  final double? positionSize;
  final double? standardLotSize;
  final double? miniLotSize;
  final double? microLotSize;
  final double? stopLossPips;
  final double? amountAtRisk;
  final double? riskRatio;

  const MatexForexPositionSizeCalculatorResults({
    this.pipValue,
    this.positionSize,
    this.standardLotSize,
    this.miniLotSize,
    this.microLotSize,
    this.stopLossPips,
    this.amountAtRisk,
    this.riskRatio,
  });

  @override
  MatexForexPositionSizeCalculatorResults clone() => copyWith();

  @override
  MatexForexPositionSizeCalculatorResults copyWith({
    double? pipValue,
    double? positionSize,
    double? standardLotSize,
    double? miniLotSize,
    double? microLotSize,
    double? stopLossPips,
    double? amountAtRisk,
    double? riskRatio,
  }) {
    return MatexForexPositionSizeCalculatorResults(
      pipValue: pipValue ?? this.pipValue,
      positionSize: positionSize ?? this.positionSize,
      standardLotSize: standardLotSize ?? this.standardLotSize,
      miniLotSize: miniLotSize ?? this.miniLotSize,
      microLotSize: microLotSize ?? this.microLotSize,
      stopLossPips: stopLossPips ?? this.stopLossPips,
      amountAtRisk: amountAtRisk ?? this.amountAtRisk,
      riskRatio: riskRatio ?? this.riskRatio,
    );
  }

  @override
  MatexForexPositionSizeCalculatorResults merge(
    covariant MatexForexPositionSizeCalculatorResults model,
  ) {
    return copyWith(
      pipValue: model.pipValue ?? pipValue,
      positionSize: model.positionSize ?? positionSize,
      standardLotSize: model.standardLotSize ?? standardLotSize,
      miniLotSize: model.miniLotSize ?? miniLotSize,
      microLotSize: model.microLotSize ?? microLotSize,
      stopLossPips: model.stopLossPips ?? stopLossPips,
      amountAtRisk: model.amountAtRisk ?? amountAtRisk,
      riskRatio: model.riskRatio ?? riskRatio,
    );
  }

  @override
  List<Object?> get props => [
        pipValue,
        positionSize,
        standardLotSize,
        miniLotSize,
        microLotSize,
        stopLossPips,
        amountAtRisk,
        riskRatio,
      ];
}
