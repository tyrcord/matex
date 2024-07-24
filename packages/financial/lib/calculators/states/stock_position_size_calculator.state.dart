// Package imports:
import 'package:matex_core/core.dart';

class MatexStockPositionSizeCalculatorState extends MatexCalculatorState {
  final double? accountSize;
  final double? entryPrice;
  final double? stopLossPrice;
  final double? stopLossAmount;
  final double? slippagePercent;
  final double? riskPercent;
  final double? riskReward;
  final double? entryFees;
  final double? exitFees;
  final double? takeProfitPrice;
  final bool isShortPosition;

  const MatexStockPositionSizeCalculatorState({
    this.isShortPosition = false,
    this.accountSize,
    this.entryPrice,
    this.stopLossPrice,
    this.stopLossAmount,
    this.slippagePercent,
    this.riskPercent,
    this.riskReward,
    this.entryFees,
    this.exitFees,
    this.takeProfitPrice,
  });

  @override
  MatexStockPositionSizeCalculatorState clone() => copyWith();

  @override
  MatexStockPositionSizeCalculatorState copyWith({
    double? accountSize,
    double? entryPrice,
    double? stopLossPrice,
    double? stopLossAmount,
    double? slippagePercent,
    double? riskPercent,
    double? riskReward,
    double? entryFees,
    double? exitFees,
    bool? isShortPosition,
    double? takeProfitPrice,
  }) {
    return MatexStockPositionSizeCalculatorState(
      accountSize: accountSize ?? this.accountSize,
      entryPrice: entryPrice ?? this.entryPrice,
      stopLossPrice: stopLossPrice ?? this.stopLossPrice,
      stopLossAmount: stopLossAmount ?? this.stopLossAmount,
      slippagePercent: slippagePercent ?? this.slippagePercent,
      riskPercent: riskPercent ?? this.riskPercent,
      riskReward: riskReward ?? this.riskReward,
      entryFees: entryFees ?? this.entryFees,
      exitFees: exitFees ?? this.exitFees,
      isShortPosition: isShortPosition ?? this.isShortPosition,
      takeProfitPrice: takeProfitPrice ?? this.takeProfitPrice,
    );
  }

  @override
  MatexStockPositionSizeCalculatorState merge(
    covariant MatexStockPositionSizeCalculatorState model,
  ) {
    return copyWith(
      accountSize: model.accountSize,
      entryPrice: model.entryPrice,
      stopLossPrice: model.stopLossPrice,
      stopLossAmount: model.stopLossAmount,
      slippagePercent: model.slippagePercent,
      riskPercent: model.riskPercent,
      riskReward: model.riskReward,
      entryFees: model.entryFees,
      exitFees: model.exitFees,
      isShortPosition: model.isShortPosition,
      takeProfitPrice: model.takeProfitPrice,
    );
  }

  @override
  List<Object?> get props => [
        accountSize,
        entryPrice,
        stopLossPrice,
        stopLossAmount,
        isShortPosition,
        slippagePercent,
        riskPercent,
        riskReward,
        entryFees,
        exitFees,
        takeProfitPrice,
      ];
}
