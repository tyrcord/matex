// Package imports:
import 'package:matex_core/core.dart';

class MatexForexPositionSizeCalculatorResults extends MatexCalculatorState {
  final double? pipValue;
  final double? positionSize;
  final double? stopLossPips;
  final double? amountAtRisk;
  final double? riskPercent;

  const MatexForexPositionSizeCalculatorResults({
    this.pipValue,
    this.positionSize,
    this.stopLossPips,
    this.amountAtRisk,
    this.riskPercent,
  });

  @override
  MatexForexPositionSizeCalculatorResults clone() => copyWith();

  @override
  MatexForexPositionSizeCalculatorResults copyWith({
    double? pipValue,
    double? positionSize,
    double? stopLossPips,
    double? amountAtRisk,
    double? riskPercent,
  }) {
    return MatexForexPositionSizeCalculatorResults(
      pipValue: pipValue ?? this.pipValue,
      positionSize: positionSize ?? this.positionSize,
      stopLossPips: stopLossPips ?? this.stopLossPips,
      amountAtRisk: amountAtRisk ?? this.amountAtRisk,
      riskPercent: riskPercent ?? this.riskPercent,
    );
  }

  @override
  MatexForexPositionSizeCalculatorResults merge(
    covariant MatexForexPositionSizeCalculatorResults model,
  ) {
    return copyWith(
      pipValue: model.pipValue ?? pipValue,
      positionSize: model.positionSize ?? positionSize,
      stopLossPips: model.stopLossPips ?? stopLossPips,
      amountAtRisk: model.amountAtRisk ?? amountAtRisk,
      riskPercent: model.riskPercent ?? riskPercent,
    );
  }

  @override
  List<Object?> get props => [
        pipValue,
        positionSize,
        stopLossPips,
        amountAtRisk,
        riskPercent,
      ];
}
