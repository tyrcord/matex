import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_forms/fastyle_forms.dart';
import 'package:matex_dart/matex_dart.dart' show MatexPosition;
import 'package:matex_financial/financial.dart';

final String _kDefaultRiskFieldType = FastAmountSwitchFieldType.percent.name;
final String _kDefaultPosition = MatexPosition.long.name;

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
  late final String? position;

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
      position: json['position'] as String?,
    );
  }

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
    String? position,
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
      position: position ?? this.position,
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
      position: model.position,
    );
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
      position: position,
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
      'position': position,
      ...super.toJson(),
    };
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
