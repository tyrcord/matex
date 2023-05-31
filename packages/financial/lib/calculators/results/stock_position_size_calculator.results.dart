import 'package:tmodel_dart/tmodel_dart.dart';

class MatexStockPositionSizeCalculatorResults extends TModel {
  final double? shares;
  final double? positionAmount;
  final double? stopLossAmount;
  final double? takeProfitAmount;
  final double? takeProfitPrice;
  final double? toleratedRisk;
  final double? effectiveRisk;
  final double? stopLossPercent;
  final double? stopLossPercentWithSlippage;
  final double? stopLossPriceWithSlippage;
  final double? entryPriceWithSlippage;

  const MatexStockPositionSizeCalculatorResults({
    this.shares,
    this.positionAmount,
    this.stopLossAmount,
    this.takeProfitAmount,
    this.takeProfitPrice,
    this.toleratedRisk,
    this.effectiveRisk,
    this.stopLossPercent,
    this.stopLossPercentWithSlippage,
    this.stopLossPriceWithSlippage,
    this.entryPriceWithSlippage,
  });

  @override
  MatexStockPositionSizeCalculatorResults clone() => copyWith();

  @override
  MatexStockPositionSizeCalculatorResults copyWith({
    double? shares,
    double? positionAmount,
    double? stopLossAmount,
    double? takeProfitAmount,
    double? takeProfitPrice,
    double? toleratedRisk,
    double? effectiveRisk,
    double? stopLossPercent,
    double? stopLossPercentWithSlippage,
    double? stopLossPriceWithSlippage,
    double? entryPriceWithSlippage,
  }) {
    return MatexStockPositionSizeCalculatorResults(
      shares: shares ?? this.shares,
      positionAmount: positionAmount ?? this.positionAmount,
      stopLossAmount: stopLossAmount ?? this.stopLossAmount,
      takeProfitAmount: takeProfitAmount ?? this.takeProfitAmount,
      takeProfitPrice: takeProfitPrice ?? this.takeProfitPrice,
      toleratedRisk: toleratedRisk ?? this.toleratedRisk,
      effectiveRisk: effectiveRisk ?? this.effectiveRisk,
      stopLossPercent: stopLossPercent ?? this.stopLossPercent,
      stopLossPercentWithSlippage:
          stopLossPercentWithSlippage ?? this.stopLossPercentWithSlippage,
      stopLossPriceWithSlippage:
          stopLossPriceWithSlippage ?? this.stopLossPriceWithSlippage,
      entryPriceWithSlippage:
          entryPriceWithSlippage ?? this.entryPriceWithSlippage,
    );
  }

  @override
  MatexStockPositionSizeCalculatorResults merge(
    covariant MatexStockPositionSizeCalculatorResults model,
  ) {
    return copyWith(
      shares: model.shares,
      positionAmount: model.positionAmount,
      stopLossAmount: model.stopLossAmount,
      takeProfitAmount: model.takeProfitAmount,
      takeProfitPrice: model.takeProfitPrice,
      toleratedRisk: model.toleratedRisk,
      effectiveRisk: model.effectiveRisk,
      stopLossPercent: model.stopLossPercent,
      stopLossPercentWithSlippage: model.stopLossPercentWithSlippage,
      stopLossPriceWithSlippage: model.stopLossPriceWithSlippage,
      entryPriceWithSlippage: model.entryPriceWithSlippage,
    );
  }

  @override
  List<Object?> get props => [
        shares,
        positionAmount,
        stopLossAmount,
        takeProfitAmount,
        takeProfitPrice,
        toleratedRisk,
        effectiveRisk,
        stopLossPercent,
        stopLossPercentWithSlippage,
        stopLossPriceWithSlippage,
        entryPriceWithSlippage,
      ];
}
