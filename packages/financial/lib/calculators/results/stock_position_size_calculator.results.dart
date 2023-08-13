import 'package:tmodel_dart/tmodel_dart.dart';

class MatexStockPositionSizeCalculatorResults extends TModel {
  final double? shares;
  final double? positionAmount;
  final double? involvedCapital;
  final double? takeProfitAmount;
  final double? takeProfitAmountWithSlippage;
  final double? takeProfitPrice;
  final double? takeProfitPriceWithSlippage;
  final double? toleratedRisk;
  final double? effectiveRisk;
  final double? stopLossPercent;
  final double? stopLossPercentWithSlippage;
  final double? stopLossPriceWithSlippage;
  final double? entryPriceWithSlippage;
  final double? riskPercent;
  final double? totalFeesForLossPosition;
  final double? entryFeeAmount;
  final double? stopLossFeeAmount;
  final double? takeProfitFeeAmount;
  final double? totalFeesForProfitPosition;

  const MatexStockPositionSizeCalculatorResults({
    this.shares,
    this.positionAmount,
    this.involvedCapital,
    this.takeProfitAmount,
    this.takeProfitPrice,
    this.toleratedRisk,
    this.effectiveRisk,
    this.stopLossPercent,
    this.stopLossPercentWithSlippage,
    this.stopLossPriceWithSlippage,
    this.entryPriceWithSlippage,
    this.riskPercent,
    this.totalFeesForLossPosition,
    this.entryFeeAmount,
    this.stopLossFeeAmount,
    this.takeProfitFeeAmount,
    this.totalFeesForProfitPosition,
    this.takeProfitAmountWithSlippage,
    this.takeProfitPriceWithSlippage,
  });

  @override
  MatexStockPositionSizeCalculatorResults clone() => copyWith();

  @override
  MatexStockPositionSizeCalculatorResults copyWith({
    double? shares,
    double? positionAmount,
    double? involvedCapital,
    double? takeProfitAmount,
    double? takeProfitPrice,
    double? toleratedRisk,
    double? effectiveRisk,
    double? stopLossPercent,
    double? stopLossPercentWithSlippage,
    double? stopLossPriceWithSlippage,
    double? entryPriceWithSlippage,
    double? riskPercent,
    double? totalFeesForLossPosition,
    double? entryFeeAmount,
    double? stopLossFeeAmount,
    double? takeProfitFeeAmount,
    double? totalFeesForProfitPosition,
    double? takeProfitAmountWithSlippage,
    double? takeProfitPriceWithSlippage,
  }) {
    return MatexStockPositionSizeCalculatorResults(
      shares: shares ?? this.shares,
      positionAmount: positionAmount ?? this.positionAmount,
      involvedCapital: involvedCapital ?? this.involvedCapital,
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
      riskPercent: riskPercent ?? this.riskPercent,
      totalFeesForLossPosition:
          totalFeesForLossPosition ?? this.totalFeesForLossPosition,
      entryFeeAmount: entryFeeAmount ?? this.entryFeeAmount,
      stopLossFeeAmount: stopLossFeeAmount ?? this.stopLossFeeAmount,
      takeProfitFeeAmount: takeProfitFeeAmount ?? this.takeProfitFeeAmount,
      totalFeesForProfitPosition:
          totalFeesForProfitPosition ?? this.totalFeesForProfitPosition,
      takeProfitAmountWithSlippage:
          takeProfitAmountWithSlippage ?? this.takeProfitAmountWithSlippage,
      takeProfitPriceWithSlippage:
          takeProfitPriceWithSlippage ?? this.takeProfitPriceWithSlippage,
    );
  }

  @override
  MatexStockPositionSizeCalculatorResults merge(
    covariant MatexStockPositionSizeCalculatorResults model,
  ) {
    return copyWith(
      shares: model.shares,
      positionAmount: model.positionAmount,
      involvedCapital: model.involvedCapital,
      takeProfitAmount: model.takeProfitAmount,
      takeProfitPrice: model.takeProfitPrice,
      toleratedRisk: model.toleratedRisk,
      effectiveRisk: model.effectiveRisk,
      stopLossPercent: model.stopLossPercent,
      stopLossPercentWithSlippage: model.stopLossPercentWithSlippage,
      stopLossPriceWithSlippage: model.stopLossPriceWithSlippage,
      entryPriceWithSlippage: model.entryPriceWithSlippage,
      riskPercent: model.riskPercent,
      totalFeesForLossPosition: model.totalFeesForLossPosition,
      entryFeeAmount: model.entryFeeAmount,
      stopLossFeeAmount: model.stopLossFeeAmount,
      takeProfitFeeAmount: model.takeProfitFeeAmount,
      totalFeesForProfitPosition: model.totalFeesForProfitPosition,
      takeProfitAmountWithSlippage: model.takeProfitAmountWithSlippage,
      takeProfitPriceWithSlippage: model.takeProfitPriceWithSlippage,
    );
  }

  @override
  List<Object?> get props => [
        shares,
        positionAmount,
        involvedCapital,
        takeProfitAmount,
        takeProfitPrice,
        toleratedRisk,
        effectiveRisk,
        stopLossPercent,
        stopLossPercentWithSlippage,
        stopLossPriceWithSlippage,
        entryPriceWithSlippage,
        riskPercent,
        totalFeesForLossPosition,
        entryFeeAmount,
        stopLossFeeAmount,
        takeProfitFeeAmount,
        totalFeesForProfitPosition,
        takeProfitAmountWithSlippage,
        takeProfitPriceWithSlippage,
      ];
}
