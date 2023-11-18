// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexForexPositionSizeCalculatorBlocResults
    extends FastCalculatorResults {
  final double? positionSize;
  final double? standardLotSize;
  final double? miniLotSize;
  final double? microLotSize;
  final double? stopLossPips;
  final double? amountAtRisk;
  final double? riskRatio;
  final double? pipValue;

  final String? formattedPositionSize;
  final String? formattedStandardLotSize;
  final String? formattedMiniLotSize;
  final String? formattedMicroLotSize;
  final String? formattedStopLossPips;
  final String? formattedAmountAtRisk;
  final String? formattedRiskRatio;
  final String? formattedPipValue;

  const MatexForexPositionSizeCalculatorBlocResults({
    this.positionSize,
    this.formattedPositionSize,
    this.standardLotSize,
    this.formattedStandardLotSize,
    this.miniLotSize,
    this.formattedMiniLotSize,
    this.microLotSize,
    this.formattedMicroLotSize,
    this.stopLossPips,
    this.formattedStopLossPips,
    this.amountAtRisk,
    this.formattedAmountAtRisk,
    this.riskRatio,
    this.formattedRiskRatio,
    this.pipValue,
    this.formattedPipValue,
  });

  @override
  MatexForexPositionSizeCalculatorBlocResults clone() => copyWith();

  @override
  MatexForexPositionSizeCalculatorBlocResults copyWith({
    double? positionSize,
    double? standardLotSize,
    double? miniLotSize,
    double? microLotSize,
    String? formattedPositionSize,
    String? formattedStandardLotSize,
    String? formattedMiniLotSize,
    String? formattedMicroLotSize,
    double? stopLossPips,
    String? formattedStopLossPips,
    double? amountAtRisk,
    String? formattedAmountAtRisk,
    double? riskRatio,
    String? formattedRiskRatio,
    double? pipValue,
    String? formattedPipValue,
  }) {
    return MatexForexPositionSizeCalculatorBlocResults(
      positionSize: positionSize ?? this.positionSize,
      formattedPositionSize:
          formattedPositionSize ?? this.formattedPositionSize,
      standardLotSize: standardLotSize ?? this.standardLotSize,
      formattedStandardLotSize:
          formattedStandardLotSize ?? this.formattedStandardLotSize,
      miniLotSize: miniLotSize ?? this.miniLotSize,
      formattedMiniLotSize: formattedMiniLotSize ?? this.formattedMiniLotSize,
      microLotSize: microLotSize ?? this.microLotSize,
      formattedMicroLotSize:
          formattedMicroLotSize ?? this.formattedMicroLotSize,
      stopLossPips: stopLossPips ?? this.stopLossPips,
      formattedStopLossPips:
          formattedStopLossPips ?? this.formattedStopLossPips,
      amountAtRisk: amountAtRisk ?? this.amountAtRisk,
      formattedAmountAtRisk:
          formattedAmountAtRisk ?? this.formattedAmountAtRisk,
      riskRatio: riskRatio ?? this.riskRatio,
      formattedRiskRatio: formattedRiskRatio ?? this.formattedRiskRatio,
      pipValue: pipValue ?? this.pipValue,
      formattedPipValue: formattedPipValue ?? this.formattedPipValue,
    );
  }

  @override
  MatexForexPositionSizeCalculatorBlocResults merge(
    covariant MatexForexPositionSizeCalculatorBlocResults model,
  ) {
    return copyWith(
      positionSize: model.positionSize,
      formattedPositionSize: model.formattedPositionSize,
      standardLotSize: model.standardLotSize,
      formattedStandardLotSize: model.formattedStandardLotSize,
      miniLotSize: model.miniLotSize,
      formattedMiniLotSize: model.formattedMiniLotSize,
      microLotSize: model.microLotSize,
      formattedMicroLotSize: model.formattedMicroLotSize,
      stopLossPips: model.stopLossPips,
      formattedStopLossPips: model.formattedStopLossPips,
      amountAtRisk: model.amountAtRisk,
      formattedAmountAtRisk: model.formattedAmountAtRisk,
      riskRatio: model.riskRatio,
      formattedRiskRatio: model.formattedRiskRatio,
      pipValue: model.pipValue,
      formattedPipValue: model.formattedPipValue,
    );
  }

  @override
  List<Object?> get props => [
        positionSize,
        formattedPositionSize,
        standardLotSize,
        formattedStandardLotSize,
        miniLotSize,
        formattedMiniLotSize,
        microLotSize,
        formattedMicroLotSize,
        stopLossPips,
        formattedStopLossPips,
        amountAtRisk,
        formattedAmountAtRisk,
        riskRatio,
        formattedRiskRatio,
        pipValue,
        formattedPipValue,
      ];
}
