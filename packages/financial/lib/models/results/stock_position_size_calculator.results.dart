// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

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
  final double? riskPercent;
  final double? totalFeesForLossPosition;
  final double? entryFeeAmount;
  final double? stopLossFeeAmount;
  final double? takeProfitFeeAmount;
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
  final String? formattedRiskPercent;
  final String? formattedTotalFeesForLossPosition;
  final String? formattedEntryFeeAmount;
  final String? formattedStopLossFeeAmount;
  final String? formattedTakeProfitFeeAmount;
  final double? totalFeesForProfitPosition;
  final String? formattedTotalFeesForProfitPosition;
  final double? takeProfitAmountAfterFee;
  final String? formattedTakeProfitAmountAfterFee;

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
    this.riskPercent,
    this.totalFeesForLossPosition,
    this.entryFeeAmount,
    this.stopLossFeeAmount,
    this.takeProfitFeeAmount,
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
    this.formattedRiskPercent,
    this.formattedTotalFeesForLossPosition,
    this.formattedEntryFeeAmount,
    this.formattedStopLossFeeAmount,
    this.formattedTakeProfitFeeAmount,
    this.totalFeesForProfitPosition,
    this.formattedTotalFeesForProfitPosition,
    this.takeProfitAmountAfterFee,
    this.formattedTakeProfitAmountAfterFee,
  });

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
    double? riskPercent,
    double? totalFeesForLossPosition,
    double? entryFeeAmount,
    double? stopLossFeeAmount,
    double? takeProfitFeeAmount,
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
    String? formattedRiskPercent,
    String? formattedTotalFeesForLossPosition,
    String? formattedEntryFeeAmount,
    String? formattedStopLossFeeAmount,
    String? formattedTakeProfitFeeAmount,
    double? totalFeesForProfitPosition,
    String? formattedTotalFeesForProfitPosition,
    double? takeProfitAmountAfterFee,
    String? formattedTakeProfitAmountAfterFee,
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
      riskPercent: riskPercent ?? this.riskPercent,
      totalFeesForLossPosition:
          totalFeesForLossPosition ?? this.totalFeesForLossPosition,
      entryFeeAmount: entryFeeAmount ?? this.entryFeeAmount,
      stopLossFeeAmount: stopLossFeeAmount ?? this.stopLossFeeAmount,
      takeProfitFeeAmount: takeProfitFeeAmount ?? this.takeProfitFeeAmount,
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
      formattedRiskPercent: formattedRiskPercent ?? this.formattedRiskPercent,
      formattedTotalFeesForLossPosition: formattedTotalFeesForLossPosition ??
          this.formattedTotalFeesForLossPosition,
      formattedEntryFeeAmount:
          formattedEntryFeeAmount ?? this.formattedEntryFeeAmount,
      formattedStopLossFeeAmount:
          formattedStopLossFeeAmount ?? this.formattedStopLossFeeAmount,
      formattedTakeProfitFeeAmount:
          formattedTakeProfitFeeAmount ?? this.formattedTakeProfitFeeAmount,
      totalFeesForProfitPosition:
          totalFeesForProfitPosition ?? this.totalFeesForProfitPosition,
      formattedTotalFeesForProfitPosition:
          formattedTotalFeesForProfitPosition ??
              this.formattedTotalFeesForProfitPosition,
      takeProfitAmountAfterFee:
          takeProfitAmountAfterFee ?? this.takeProfitAmountAfterFee,
      formattedTakeProfitAmountAfterFee: formattedTakeProfitAmountAfterFee ??
          this.formattedTakeProfitAmountAfterFee,
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
      riskPercent: model.riskPercent,
      totalFeesForLossPosition: model.totalFeesForLossPosition,
      entryFeeAmount: model.entryFeeAmount,
      stopLossFeeAmount: model.stopLossFeeAmount,
      takeProfitFeeAmount: model.takeProfitFeeAmount,
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
      formattedRiskPercent: model.formattedRiskPercent,
      formattedTotalFeesForLossPosition:
          model.formattedTotalFeesForLossPosition,
      formattedEntryFeeAmount: model.formattedEntryFeeAmount,
      formattedStopLossFeeAmount: model.formattedStopLossFeeAmount,
      formattedTakeProfitFeeAmount: model.formattedTakeProfitFeeAmount,
      totalFeesForProfitPosition: model.totalFeesForProfitPosition,
      formattedTotalFeesForProfitPosition:
          model.formattedTotalFeesForProfitPosition,
      takeProfitAmountAfterFee: model.takeProfitAmountAfterFee,
      formattedTakeProfitAmountAfterFee:
          model.formattedTakeProfitAmountAfterFee,
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
        formattedRiskPercent,
        formattedTotalFeesForLossPosition,
        formattedEntryFeeAmount,
        formattedStopLossFeeAmount,
        formattedTakeProfitFeeAmount,
        totalFeesForProfitPosition,
        formattedTotalFeesForProfitPosition,
        takeProfitAmountAfterFee,
        formattedTakeProfitAmountAfterFee,
      ];
}
