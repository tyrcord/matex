import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/models/fields/stock_position_size_calculator.fields.dart';

class MatexStockPositionSizeCalculatorBlocDocument
    extends FastCalculatorDocument {
  final String? accountSize;
  final String? entryPrice;
  final String? stopLossPrice;
  final String? stopLossAmount;
  final String? slippagePercent;
  final String? riskPercent;
  final String? rewardRisk;
  final String? entryFees;
  final String? exitFees;

  const MatexStockPositionSizeCalculatorBlocDocument({
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
  MatexStockPositionSizeCalculatorBlocDocument clone() => copyWith();

  @override
  MatexStockPositionSizeCalculatorBlocDocument copyWith({
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
    return MatexStockPositionSizeCalculatorBlocDocument(
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
      rewardRisk: model.rewardRisk,
      entryFees: model.entryFees,
      exitFees: model.exitFees,
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
      'rewardRisk': rewardRisk,
      'entryFees': entryFees,
      'exitFees': exitFees,
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
      rewardRisk: rewardRisk,
      entryFees: entryFees,
      exitFees: exitFees,
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
      rewardRisk: json['rewardRisk'] as String?,
      entryFees: json['entryFees'] as String?,
      exitFees: json['exitFees'] as String?,
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
