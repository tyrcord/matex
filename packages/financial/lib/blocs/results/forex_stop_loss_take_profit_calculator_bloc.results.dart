// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexForexStopLossTakeProfitCalculatorBlocResults
    extends FastCalculatorResults {
  final double? pipValue;
  final double? stopLossPrice;
  final double? stopLossPips;
  final double? stopLossAmount;
  final double? takeProfitPrice;
  final double? takeProfitPips;
  final double? takeProfitAmount;
  final double? riskRewardRatio;

  final String? formattedPipValue;
  final String? formattedStopLossPrice;
  final String? formattedStopLossPips;
  final String? formattedStopLossAmount;
  final String? formattedTakeProfitPrice;
  final String? formattedTakeProfitPips;
  final String? formattedTakeProfitAmount;
  final String? formattedRiskRewardRatio;

  const MatexForexStopLossTakeProfitCalculatorBlocResults({
    this.formattedPipValue,
    this.formattedStopLossPrice,
    this.formattedStopLossPips,
    this.formattedStopLossAmount,
    this.formattedTakeProfitPrice,
    this.formattedTakeProfitPips,
    this.formattedTakeProfitAmount,
    this.formattedRiskRewardRatio,
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
  MatexForexStopLossTakeProfitCalculatorBlocResults clone() => copyWith();

  @override
  MatexForexStopLossTakeProfitCalculatorBlocResults copyWith({
    String? formattedPipValue,
    String? formattedStopLossPrice,
    String? formattedStopLossPips,
    String? formattedStopLossAmount,
    String? formattedTakeProfitPrice,
    String? formattedTakeProfitPips,
    String? formattedTakeProfitAmount,
    String? formattedRiskRewardRatio,
    double? pipValue,
    double? stopLossPrice,
    double? stopLossPips,
    double? stopLossAmount,
    double? takeProfitPrice,
    double? takeProfitPips,
    double? takeProfitAmount,
    double? riskRewardRatio,
  }) {
    return MatexForexStopLossTakeProfitCalculatorBlocResults(
      formattedPipValue: formattedPipValue ?? this.formattedPipValue,
      formattedStopLossPrice:
          formattedStopLossPrice ?? this.formattedStopLossPrice,
      formattedStopLossPips:
          formattedStopLossPips ?? this.formattedStopLossPips,
      formattedStopLossAmount:
          formattedStopLossAmount ?? this.formattedStopLossAmount,
      formattedTakeProfitPrice:
          formattedTakeProfitPrice ?? this.formattedTakeProfitPrice,
      formattedTakeProfitPips:
          formattedTakeProfitPips ?? this.formattedTakeProfitPips,
      formattedTakeProfitAmount:
          formattedTakeProfitAmount ?? this.formattedTakeProfitAmount,
      formattedRiskRewardRatio:
          formattedRiskRewardRatio ?? this.formattedRiskRewardRatio,
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
  MatexForexStopLossTakeProfitCalculatorBlocResults merge(
    covariant MatexForexStopLossTakeProfitCalculatorBlocResults model,
  ) {
    return copyWith(
      formattedPipValue: model.formattedPipValue,
      formattedStopLossPrice: model.formattedStopLossPrice,
      formattedStopLossPips: model.formattedStopLossPips,
      formattedStopLossAmount: model.formattedStopLossAmount,
      formattedTakeProfitPrice: model.formattedTakeProfitPrice,
      formattedTakeProfitPips: model.formattedTakeProfitPips,
      formattedTakeProfitAmount: model.formattedTakeProfitAmount,
      formattedRiskRewardRatio: model.formattedRiskRewardRatio,
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
        formattedPipValue,
        formattedStopLossPrice,
        formattedStopLossPips,
        formattedStopLossAmount,
        formattedTakeProfitPrice,
        formattedTakeProfitPips,
        formattedTakeProfitAmount,
        formattedRiskRewardRatio,
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
