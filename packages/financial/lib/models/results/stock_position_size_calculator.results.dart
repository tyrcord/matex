import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexStockPositionSizeCalculatorBlocResults
    extends FastCalculatorResults {
  final double? shares;
  final double? positionAmount;
  final double? involvedCapital;
  final double? takeProfitAmount;
  final double? takeProfitPrice;
  final double? toleratedRisk;
  final double? effectiveRisk;
  final double? stopLossPercent;
  final double? stopLossPercentWithSlippage;
  final double? stopLossPriceWithSlippage;
  final double? entryPriceWithSlippage;
  final String? formattedShares;
  final String? formattedPositionAmount;
  final String? formattedInvolvedCapital;
  final String? formattedTakeProfitAmount;
  final String? formattedTakeProfitPrice;
  final String? formattedToleratedRisk;
  final String? formattedEffectiveRisk;
  final String? formattedStopLossPercent;
  final String? formattedStopLossPercentWithSlippage;
  final String? formattedStopLossPriceWithSlippage;
  final String? formattedEntryPriceWithSlippage;

  const MatexStockPositionSizeCalculatorBlocResults({
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
    this.formattedShares,
    this.formattedPositionAmount,
    this.formattedInvolvedCapital,
    this.formattedTakeProfitAmount,
    this.formattedTakeProfitPrice,
    this.formattedToleratedRisk,
    this.formattedEffectiveRisk,
    this.formattedStopLossPercent,
    this.formattedStopLossPercentWithSlippage,
    this.formattedStopLossPriceWithSlippage,
    this.formattedEntryPriceWithSlippage,
  });

  factory MatexStockPositionSizeCalculatorBlocResults.fromCalculatorResults(
    MatexStockPositionSizeCalculatorResults results,
  ) {
    return MatexStockPositionSizeCalculatorBlocResults(
      shares: results.shares,
      positionAmount: results.positionAmount,
      involvedCapital: results.involvedCapital,
      takeProfitAmount: results.takeProfitAmount,
      takeProfitPrice: results.takeProfitPrice,
      toleratedRisk: results.toleratedRisk,
      effectiveRisk: results.effectiveRisk,
      stopLossPercent: results.stopLossPercent,
      stopLossPercentWithSlippage: results.stopLossPercentWithSlippage,
      stopLossPriceWithSlippage: results.stopLossPriceWithSlippage,
      entryPriceWithSlippage: results.entryPriceWithSlippage,
      formattedShares: results.shares?.toString(),
      formattedPositionAmount: results.positionAmount?.toString(),
      formattedInvolvedCapital: results.involvedCapital?.toString(),
      formattedTakeProfitAmount: results.takeProfitAmount?.toString(),
      formattedTakeProfitPrice: results.takeProfitPrice?.toString(),
      formattedToleratedRisk: results.toleratedRisk?.toString(),
      formattedEffectiveRisk: results.effectiveRisk?.toString(),
      formattedStopLossPercent: results.stopLossPercent?.toString(),
      formattedStopLossPercentWithSlippage:
          results.stopLossPercentWithSlippage?.toString(),
      formattedStopLossPriceWithSlippage:
          results.stopLossPriceWithSlippage?.toString(),
      formattedEntryPriceWithSlippage:
          results.entryPriceWithSlippage?.toString(),
    );
  }

  @override
  MatexStockPositionSizeCalculatorBlocResults clone() => copyWith();

  @override
  MatexStockPositionSizeCalculatorBlocResults copyWith({
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
    String? formattedShares,
    String? formattedPositionAmount,
    String? formattedInvolvedCapital,
    String? formattedTakeProfitAmount,
    String? formattedTakeProfitPrice,
    String? formattedToleratedRisk,
    String? formattedEffectiveRisk,
    String? formattedStopLossPercent,
    String? formattedStopLossPercentWithSlippage,
    String? formattedStopLossPriceWithSlippage,
    String? formattedEntryPriceWithSlippage,
  }) {
    return MatexStockPositionSizeCalculatorBlocResults(
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
      formattedShares: formattedShares ?? this.formattedShares,
      formattedPositionAmount:
          formattedPositionAmount ?? this.formattedPositionAmount,
      formattedInvolvedCapital:
          formattedInvolvedCapital ?? this.formattedInvolvedCapital,
      formattedTakeProfitAmount:
          formattedTakeProfitAmount ?? this.formattedTakeProfitAmount,
      formattedTakeProfitPrice:
          formattedTakeProfitPrice ?? this.formattedTakeProfitPrice,
      formattedToleratedRisk:
          formattedToleratedRisk ?? this.formattedToleratedRisk,
      formattedEffectiveRisk:
          formattedEffectiveRisk ?? this.formattedEffectiveRisk,
      formattedStopLossPercent:
          formattedStopLossPercent ?? this.formattedStopLossPercent,
      formattedStopLossPercentWithSlippage:
          formattedStopLossPercentWithSlippage ??
              this.formattedStopLossPercentWithSlippage,
      formattedStopLossPriceWithSlippage: formattedStopLossPriceWithSlippage ??
          this.formattedStopLossPriceWithSlippage,
      formattedEntryPriceWithSlippage: formattedEntryPriceWithSlippage ??
          this.formattedEntryPriceWithSlippage,
    );
  }

  @override
  MatexStockPositionSizeCalculatorBlocResults merge(
    covariant MatexStockPositionSizeCalculatorBlocResults model,
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
      formattedShares: model.formattedShares,
      formattedPositionAmount: model.formattedPositionAmount,
      formattedInvolvedCapital: model.formattedInvolvedCapital,
      formattedTakeProfitAmount: model.formattedTakeProfitAmount,
      formattedTakeProfitPrice: model.formattedTakeProfitPrice,
      formattedToleratedRisk: model.formattedToleratedRisk,
      formattedEffectiveRisk: model.formattedEffectiveRisk,
      formattedStopLossPercent: model.formattedStopLossPercent,
      formattedStopLossPercentWithSlippage:
          model.formattedStopLossPercentWithSlippage,
      formattedStopLossPriceWithSlippage:
          model.formattedStopLossPriceWithSlippage,
      formattedEntryPriceWithSlippage: model.formattedEntryPriceWithSlippage,
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
        formattedShares,
        formattedPositionAmount,
        formattedInvolvedCapital,
        formattedTakeProfitAmount,
        formattedTakeProfitPrice,
        formattedToleratedRisk,
        formattedEffectiveRisk,
        formattedStopLossPercent,
        formattedStopLossPercentWithSlippage,
        formattedStopLossPriceWithSlippage,
        formattedEntryPriceWithSlippage,
      ];
}
