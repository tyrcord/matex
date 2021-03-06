// Package imports:
import 'package:matex_core/core.dart';

class MatexStockPositionSizeCalculatorState extends MatexCalculatorState {
  final double? accountSize;
  final double? entryPrice;
  final double? stopLossPrice;
  final double? stopLossAmount;
  final double? slippagePercent;
  final double? riskPercent;
  final double? rewardRisk;
  final double? entryFees;
  final double? exitFees;

  const MatexStockPositionSizeCalculatorState({
    this.accountSize,
    this.entryPrice,
    this.stopLossPrice,
    this.stopLossAmount,
    this.slippagePercent,
    this.riskPercent,
    this.rewardRisk,
    this.entryFees,
    this.exitFees,
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
    double? rewardRisk,
    double? entryFees,
    double? exitFees,
  }) {
    return MatexStockPositionSizeCalculatorState(
      accountSize: accountSize ?? this.accountSize,
      entryPrice: entryPrice ?? this.entryPrice,
      stopLossPrice: stopLossPrice ?? this.stopLossPrice,
      stopLossAmount: stopLossAmount ?? this.stopLossAmount,
      slippagePercent: slippagePercent ?? this.slippagePercent,
      riskPercent: riskPercent ?? this.riskPercent,
      rewardRisk: rewardRisk ?? this.rewardRisk,
      entryFees: entryFees ?? this.entryFees,
      exitFees: exitFees ?? this.exitFees,
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
      rewardRisk: model.rewardRisk,
      entryFees: model.entryFees,
      exitFees: model.exitFees,
    );
  }

  @override
  List<Object?> get props => [
        accountSize,
        entryPrice,
        stopLossPrice,
        stopLossAmount,
        slippagePercent,
        riskPercent,
        rewardRisk,
        entryFees,
        exitFees,
      ];
}
