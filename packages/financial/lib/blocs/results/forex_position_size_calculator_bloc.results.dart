// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexForexPositionSizeCalculatorBlocResults
    extends FastCalculatorResults {
  final double? positionSize;
  final double? standardLotSize;
  final double? miniLotSize;
  final double? microLotSize;
  final double? stopLossPips;
  final double? stopLossPrice;
  final double? amountAtRisk;
  final double? riskRatio;
  final double? pipValue;

  final String? formattedPositionSize;
  final String? formattedStandardLotSize;
  final String? formattedMiniLotSize;
  final String? formattedMicroLotSize;
  final String? formattedStopLossPips;
  final String? formattedStopLossPrice;
  final String? formattedAmountAtRisk;
  final String? formattedRiskRatio;
  final String? formattedPipValue;

  final List<MatexForexPositionSizeCalculatorBlocResults>? range;

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
    this.stopLossPrice,
    this.formattedStopLossPrice,
    this.amountAtRisk,
    this.formattedAmountAtRisk,
    this.riskRatio,
    this.formattedRiskRatio,
    this.pipValue,
    this.formattedPipValue,
    this.range,
  });

  @override
  MatexForexPositionSizeCalculatorBlocResults clone() => copyWith();

  @override
  MatexForexPositionSizeCalculatorBlocResults copyWith({
    double? positionSize,
    double? standardLotSize,
    double? miniLotSize,
    double? microLotSize,
    double? stopLossPips,
    double? stopLossPrice,
    String? formattedPositionSize,
    String? formattedStandardLotSize,
    String? formattedMiniLotSize,
    String? formattedMicroLotSize,
    String? formattedStopLossPips,
    String? formattedStopLossPrice,
    double? amountAtRisk,
    String? formattedAmountAtRisk,
    double? riskRatio,
    String? formattedRiskRatio,
    double? pipValue,
    String? formattedPipValue,
    List<MatexForexPositionSizeCalculatorBlocResults>? range,
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
      stopLossPrice: stopLossPrice ?? this.stopLossPrice,
      formattedStopLossPrice:
          formattedStopLossPrice ?? this.formattedStopLossPrice,
      amountAtRisk: amountAtRisk ?? this.amountAtRisk,
      formattedAmountAtRisk:
          formattedAmountAtRisk ?? this.formattedAmountAtRisk,
      riskRatio: riskRatio ?? this.riskRatio,
      formattedRiskRatio: formattedRiskRatio ?? this.formattedRiskRatio,
      pipValue: pipValue ?? this.pipValue,
      formattedPipValue: formattedPipValue ?? this.formattedPipValue,
      range: range ?? this.range,
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
      stopLossPrice: model.stopLossPrice,
      formattedStopLossPrice: model.formattedStopLossPrice,
      amountAtRisk: model.amountAtRisk,
      formattedAmountAtRisk: model.formattedAmountAtRisk,
      riskRatio: model.riskRatio,
      formattedRiskRatio: model.formattedRiskRatio,
      pipValue: model.pipValue,
      formattedPipValue: model.formattedPipValue,
      range: model.range,
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
        stopLossPrice,
        formattedStopLossPrice,
        amountAtRisk,
        formattedAmountAtRisk,
        riskRatio,
        formattedRiskRatio,
        pipValue,
        formattedPipValue,
        range,
      ];
}
