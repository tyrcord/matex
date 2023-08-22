import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/models/fields/stock_position_size_calculator.fields.dart';

class MatexStockPositionSizeCalculatorBlocDocument
    extends FastCalculatorDocument {
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

  MatexStockPositionSizeCalculatorBlocDocument({
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
  }) : riskFieldType = riskFieldType ?? 'percent' {
    this.accountSize = assignValue(accountSize);
    this.entryPrice = assignValue(entryPrice);
    this.stopLossPrice = assignValue(stopLossPrice);
    this.stopLossAmount = assignValue(stopLossAmount);
    this.slippagePercent = assignValue(slippagePercent);
    this.riskPercent = assignValue(riskPercent);
    this.riskReward = assignValue(riskReward);
    this.entryFees = assignValue(entryFees);
    this.exitFees = assignValue(exitFees);
  }

  @override
  MatexStockPositionSizeCalculatorBlocDocument clone() => copyWith();

  @override
  MatexStockPositionSizeCalculatorBlocDocument copyWith({
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
    return MatexStockPositionSizeCalculatorBlocDocument(
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
  MatexStockPositionSizeCalculatorBlocDocument merge(
    covariant MatexStockPositionSizeCalculatorBlocDocument model,
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
  Map<String, dynamic> toJson() {
    return {
      'accountSize': accountSize,
      'entryPrice': entryPrice,
      'stopLossPrice': stopLossPrice,
      'stopLossAmount': stopLossAmount,
      'slippagePercent': slippagePercent,
      'riskPercent': riskPercent,
      'riskReward': riskReward,
      'entryFees': entryFees,
      'exitFees': exitFees,
      'riskFieldType': riskFieldType,
    };
  }

  @override
  MatexStockPositionSizeCalculatorBlocFields toFields() {
    return MatexStockPositionSizeCalculatorBlocFields(
      accountSize: accountSize,
      entryPrice: entryPrice,
      stopLossPrice: stopLossPrice,
      stopLossAmount: stopLossAmount,
      slippagePercent: slippagePercent,
      riskPercent: riskPercent,
      riskReward: riskReward,
      entryFees: entryFees,
      exitFees: exitFees,
      riskFieldType: riskFieldType,
    );
  }

  static MatexStockPositionSizeCalculatorBlocDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexStockPositionSizeCalculatorBlocDocument(
      accountSize: json['accountSize'] as String?,
      entryPrice: json['entryPrice'] as String?,
      stopLossPrice: json['stopLossPrice'] as String?,
      stopLossAmount: json['stopLossAmount'] as String?,
      slippagePercent: json['slippagePercent'] as String?,
      riskPercent: json['riskPercent'] as String?,
      riskReward: json['riskReward'] as String?,
      entryFees: json['entryFees'] as String?,
      exitFees: json['exitFees'] as String?,
      riskFieldType: json['riskFieldType'] as String?,
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
