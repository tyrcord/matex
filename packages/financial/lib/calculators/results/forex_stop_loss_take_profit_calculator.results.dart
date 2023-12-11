import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexForexStopLossTakeProfitCalculatorResults
    extends FastCalculatorResults {
  final double? pipValue;
  final double? stopLossPrice;
  final double? stopLossPips;
  final double? stopLossAmount;
  final double? takeProfitPrice;
  final double? takeProfitPips;
  final double? takeProfitAmount;
  final double? riskRewardRatio;

  const MatexForexStopLossTakeProfitCalculatorResults({
    this.pipValue,
    this.stopLossPrice,
    this.stopLossPips,
    this.stopLossAmount,
    this.takeProfitPrice,
    this.takeProfitPips,
    this.takeProfitAmount,
    this.riskRewardRatio,
  });

  @override
  MatexForexStopLossTakeProfitCalculatorResults clone() => copyWith();

  @override
  MatexForexStopLossTakeProfitCalculatorResults copyWith({
    double? pipValue,
    double? stopLossPrice,
    double? stopLossPips,
    double? stopLossAmount,
    double? takeProfitPrice,
    double? takeProfitPips,
    double? takeProfitAmount,
    double? riskRewardRatio,
  }) {
    return MatexForexStopLossTakeProfitCalculatorResults(
      pipValue: pipValue ?? this.pipValue,
      stopLossPrice: stopLossPrice ?? this.stopLossPrice,
      stopLossPips: stopLossPips ?? this.stopLossPips,
      stopLossAmount: stopLossAmount ?? this.stopLossAmount,
      takeProfitPrice: takeProfitPrice ?? this.takeProfitPrice,
      takeProfitPips: takeProfitPips ?? this.takeProfitPips,
      takeProfitAmount: takeProfitAmount ?? this.takeProfitAmount,
      riskRewardRatio: riskRewardRatio ?? this.riskRewardRatio,
    );
  }

  @override
  MatexForexStopLossTakeProfitCalculatorResults merge(
    covariant MatexForexStopLossTakeProfitCalculatorResults model,
  ) {
    return copyWith(
      pipValue: model.pipValue,
      stopLossPrice: model.stopLossPrice,
      stopLossPips: model.stopLossPips,
      stopLossAmount: model.stopLossAmount,
      takeProfitPrice: model.takeProfitPrice,
      takeProfitPips: model.takeProfitPips,
      takeProfitAmount: model.takeProfitAmount,
      riskRewardRatio: model.riskRewardRatio,
    );
  }

  @override
  List<Object?> get props => [
        pipValue,
        stopLossPrice,
        stopLossPips,
        stopLossAmount,
        takeProfitPrice,
        takeProfitPips,
        takeProfitAmount,
        riskRewardRatio,
      ];
}
