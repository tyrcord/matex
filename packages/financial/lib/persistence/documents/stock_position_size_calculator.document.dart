// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexStockPositionSizeCalculatorBlocDocument
    extends FastCalculatorDocument {
  static final defaultPosition = MatexPosition.long.name;
  static const defaultRiskFieldType = 'percent';

  late final String? slippagePercent;
  late final String? stopLossAmount;
  late final String? stopLossPrice;
  late final String riskFieldType;
  late final String? accountSize;
  late final String? riskPercent;
  late final String? entryPrice;
  late final String? riskReward;
  late final String? entryFees;
  late final String? exitFees;
  late final String position;

  static MatexStockPositionSizeCalculatorBlocDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexStockPositionSizeCalculatorBlocDocument(
      slippagePercent: json['slippagePercent'] as String?,
      stopLossAmount: json['stopLossAmount'] as String?,
      riskFieldType: json['riskFieldType'] as String?,
      stopLossPrice: json['stopLossPrice'] as String?,
      accountSize: json['accountSize'] as String?,
      riskPercent: json['riskPercent'] as String?,
      riskReward: json['riskReward'] as String?,
      entryPrice: json['entryPrice'] as String?,
      entryFees: json['entryFees'] as String?,
      exitFees: json['exitFees'] as String?,
      position: json['position'] as String?,
    );
  }

  MatexStockPositionSizeCalculatorBlocDocument({
    String? slippagePercent,
    String? stopLossAmount,
    String? riskFieldType,
    String? stopLossPrice,
    String? accountSize,
    String? riskPercent,
    String? entryPrice,
    String? riskReward,
    String? entryFees,
    String? position,
    String? exitFees,
  }) {
    this.riskFieldType = riskFieldType ?? defaultRiskFieldType;
    this.slippagePercent = assignValue(slippagePercent);
    this.stopLossAmount = assignValue(stopLossAmount);
    this.stopLossPrice = assignValue(stopLossPrice);
    this.riskPercent = assignValue(riskPercent);
    this.position = position ?? defaultPosition;
    this.accountSize = assignValue(accountSize);
    this.entryPrice = assignValue(entryPrice);
    this.riskReward = assignValue(riskReward);
    this.entryFees = assignValue(entryFees);
    this.exitFees = assignValue(exitFees);
  }

  @override
  MatexStockPositionSizeCalculatorBlocDocument clone() => copyWith();

  @override
  MatexStockPositionSizeCalculatorBlocDocument copyWith({
    String? slippagePercent,
    String? stopLossAmount,
    String? riskFieldType,
    String? stopLossPrice,
    String? accountSize,
    String? riskPercent,
    String? entryPrice,
    String? riskReward,
    String? entryFees,
    String? position,
    String? exitFees,
  }) {
    return MatexStockPositionSizeCalculatorBlocDocument(
      slippagePercent: slippagePercent ?? this.slippagePercent,
      stopLossAmount: stopLossAmount ?? this.stopLossAmount,
      stopLossPrice: stopLossPrice ?? this.stopLossPrice,
      riskFieldType: riskFieldType ?? this.riskFieldType,
      accountSize: accountSize ?? this.accountSize,
      riskPercent: riskPercent ?? this.riskPercent,
      entryPrice: entryPrice ?? this.entryPrice,
      riskReward: riskReward ?? this.riskReward,
      entryFees: entryFees ?? this.entryFees,
      exitFees: exitFees ?? this.exitFees,
      position: position ?? this.position,
    );
  }

  @override
  MatexStockPositionSizeCalculatorBlocDocument copyWithDefaults({
    bool resetSlippagePercent = false,
    bool resetStopLossAmount = false,
    bool resetRiskFieldType = false,
    bool resetStopLossPrice = false,
    bool resetRiskPercent = false,
    bool resetAccountSize = false,
    bool resetRiskReward = false,
    bool resetEntryPrice = false,
    bool resetEntryFees = false,
    bool resetExitFees = false,
    bool resetPosition = false,
  }) {
    return MatexStockPositionSizeCalculatorBlocDocument(
      slippagePercent: resetSlippagePercent ? null : slippagePercent,
      stopLossAmount: resetStopLossAmount ? null : stopLossAmount,
      riskFieldType: resetRiskFieldType ? null : riskFieldType,
      stopLossPrice: resetStopLossPrice ? null : stopLossPrice,
      accountSize: resetAccountSize ? null : accountSize,
      riskPercent: resetRiskPercent ? null : riskPercent,
      riskReward: resetRiskReward ? null : riskReward,
      entryPrice: resetEntryPrice ? null : entryPrice,
      entryFees: resetEntryFees ? null : entryFees,
      exitFees: resetExitFees ? null : exitFees,
      position: resetPosition ? null : position,
    );
  }

  @override
  MatexStockPositionSizeCalculatorBlocDocument merge(
    covariant MatexStockPositionSizeCalculatorBlocDocument model,
  ) {
    return copyWith(
      slippagePercent: model.slippagePercent,
      stopLossAmount: model.stopLossAmount,
      stopLossPrice: model.stopLossPrice,
      riskFieldType: model.riskFieldType,
      accountSize: model.accountSize,
      riskPercent: model.riskPercent,
      entryPrice: model.entryPrice,
      riskReward: model.riskReward,
      entryFees: model.entryFees,
      exitFees: model.exitFees,
      position: model.position,
    );
  }

  @override
  MatexStockPositionSizeCalculatorBlocFields toFields() {
    return MatexStockPositionSizeCalculatorBlocFields(
      position: MatexPositionX.fromName(position),
      slippagePercent: slippagePercent,
      stopLossAmount: stopLossAmount,
      stopLossPrice: stopLossPrice,
      riskFieldType: riskFieldType,
      accountSize: accountSize,
      riskPercent: riskPercent,
      entryPrice: entryPrice,
      riskReward: riskReward,
      entryFees: entryFees,
      exitFees: exitFees,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'slippagePercent': slippagePercent,
      'stopLossAmount': stopLossAmount,
      'stopLossPrice': stopLossPrice,
      'riskFieldType': riskFieldType,
      'accountSize': accountSize,
      'riskPercent': riskPercent,
      'entryPrice': entryPrice,
      'riskReward': riskReward,
      'entryFees': entryFees,
      'exitFees': exitFees,
      'position': position,
      ...super.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        slippagePercent,
        stopLossAmount,
        stopLossPrice,
        riskFieldType,
        accountSize,
        riskPercent,
        entryPrice,
        riskReward,
        entryFees,
        exitFees,
        position,
      ];
}
