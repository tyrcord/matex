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
  final String? riskFieldType;

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
    String? riskFieldType,
  }) : riskFieldType = riskFieldType ?? 'percent';

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
    String? riskFieldType,
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
      riskFieldType: riskFieldType ?? this.riskFieldType,
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
      riskFieldType: model.riskFieldType,
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
        riskFieldType,
      ];
}
