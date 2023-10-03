import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_dart/matex_dart.dart' show MatexPosition;
import 'package:fastyle_forms/fastyle_forms.dart';

final String _kDefaultRiskFieldType = FastAmountSwitchFieldType.percent.name;
final String _kDefaultPosition = MatexPosition.long.name;

class MatexStockPositionSizeCalculatorBlocFields extends FastCalculatorFields {
  late final String? accountSize;
  late final String? entryPrice;
  late final String? stopLossPrice;
  late final String? stopLossAmount;
  late final String? slippagePercent;
  late final String? riskPercent;
  late final String? riskReward;
  late final String? entryFees;
  late final String? exitFees;
  late final String? riskFieldType;
  late final String position;

  MatexStockPositionSizeCalculatorBlocFields({
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
    String? position,
  }) {
    this.accountSize = assignValue(accountSize);
    this.entryPrice = assignValue(entryPrice);
    this.stopLossPrice = assignValue(stopLossPrice);
    this.stopLossAmount = assignValue(stopLossAmount);
    this.slippagePercent = assignValue(slippagePercent);
    this.riskPercent = assignValue(riskPercent);
    this.riskReward = assignValue(riskReward);
    this.entryFees = assignValue(entryFees);
    this.exitFees = assignValue(exitFees);
    this.riskFieldType = riskFieldType ?? _kDefaultRiskFieldType;
    this.position = position ?? _kDefaultPosition;
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
    String? position,
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
      position: position ?? this.position,
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
      position: model.position,
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
        position,
      ];
}
