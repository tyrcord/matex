import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexStockPositionSizeCalculatorBlocFields extends FastCalculatorFields {
  final String? accountSize;
  final String? entryPrice;
  final String? stopLossPrice;
  final String? stopLossAmount;
  final String? slippagePercent;
  final String? riskPercent;
  final String? rewardRisk;
  final String? entryFees;
  final String? exitFees;

  const MatexStockPositionSizeCalculatorBlocFields({
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
  MatexStockPositionSizeCalculatorBlocFields clone() => copyWith();

  @override
  MatexStockPositionSizeCalculatorBlocFields copyWith({
    String? accountSize,
    String? entryPrice,
    String? stopLossPrice,
    String? stopLossAmount,
    String? slippagePercent,
    String? riskPercent,
    String? rewardRisk,
    String? entryFees,
    String? exitFees,
  }) {
    return MatexStockPositionSizeCalculatorBlocFields(
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
  MatexStockPositionSizeCalculatorBlocFields merge(
    covariant MatexStockPositionSizeCalculatorBlocFields model,
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
