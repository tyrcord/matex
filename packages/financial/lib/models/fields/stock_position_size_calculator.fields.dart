import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexStockPositionSizeCalculatorBlocFields extends FastCalculatorFields {
  late final String? riskPercent;
  late final String? riskReward;
  late final String? stopLossAmount;

  final String? accountSize;
  final String? entryPrice;
  final String? stopLossPrice;
  final String? slippagePercent;
  final String? entryFees;
  final String? exitFees;
  final String? riskFieldType;

  MatexStockPositionSizeCalculatorBlocFields({
    this.accountSize,
    this.entryPrice,
    this.stopLossPrice,
    this.slippagePercent,
    this.entryFees,
    this.exitFees,
    String? riskFieldType,
    String? riskPercent,
    String? riskReward,
    String? stopLossAmount,
  }) : riskFieldType = riskFieldType ?? 'percent' {
    this.stopLossAmount = assignValue(stopLossAmount);
    this.riskPercent = assignValue(riskPercent);
    this.riskReward = assignValue(riskReward);
  }

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
    String? riskReward,
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
      riskReward: riskReward ?? this.riskReward,
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
      riskReward: model.riskReward,
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
        riskReward,
        entryFees,
        exitFees,
        riskFieldType,
      ];
}
