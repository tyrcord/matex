import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_forms/fastyle_forms.dart';
import 'package:matex_financial/financial.dart';

final String _kDefaultEntryFeeType = FastAmountSwitchFieldType.amount.name;
final String _kDefaultExitFeeType = FastAmountSwitchFieldType.amount.name;

class MatexProfitAndLossCalculatorDocument extends FastCalculatorDocument {
  late final String? positionSize;
  late final String? entryPrice;
  late final String? exitPrice;
  late final String? fixedCosts;
  late final String? entryFeePercentagePerUnit;
  late final String? entryFeeAmountPerUnit;
  late final String? exitFeeAmountPerUnit;
  late final String? exitFeePercentagePerUnit;
  late final String? taxRate;
  late final String? entryFeeType;
  late final String? exitFeeType;

  MatexProfitAndLossCalculatorDocument({
    String? positionSize,
    String? entryPrice,
    String? exitPrice,
    String? fixedCosts,
    String? entryFeePercentagePerUnit,
    String? entryFeeAmountPerUnit,
    String? exitFeeAmountPerUnit,
    String? exitFeePercentagePerUnit,
    String? taxRate,
    String? entryFeeType,
    String? exitFeeType,
  }) {
    this.positionSize = assignValue(positionSize);
    this.entryPrice = assignValue(entryPrice);
    this.exitPrice = assignValue(exitPrice);
    this.fixedCosts = assignValue(fixedCosts);
    this.entryFeePercentagePerUnit = assignValue(entryFeePercentagePerUnit);
    this.entryFeeAmountPerUnit = assignValue(entryFeeAmountPerUnit);
    this.exitFeeAmountPerUnit = assignValue(exitFeeAmountPerUnit);
    this.exitFeePercentagePerUnit = assignValue(exitFeePercentagePerUnit);
    this.taxRate = assignValue(taxRate);
    this.entryFeeType = assignValue(entryFeeType) ?? _kDefaultEntryFeeType;
    this.exitFeeType = assignValue(exitFeeType) ?? _kDefaultExitFeeType;
  }

  @override
  MatexProfitAndLossCalculatorDocument clone() => copyWith();

  @override
  MatexProfitAndLossCalculatorDocument copyWith({
    String? positionSize,
    String? entryPrice,
    String? exitPrice,
    String? fixedCosts,
    String? entryFeePercentagePerUnit,
    String? entryFeeAmountPerUnit,
    String? exitFeeAmountPerUnit,
    String? exitFeePercentagePerUnit,
    String? taxRate,
    String? entryFeeType,
    String? exitFeeType,
  }) {
    return MatexProfitAndLossCalculatorDocument(
      positionSize: positionSize ?? this.positionSize,
      entryPrice: entryPrice ?? this.entryPrice,
      exitPrice: exitPrice ?? this.exitPrice,
      fixedCosts: fixedCosts ?? this.fixedCosts,
      entryFeePercentagePerUnit:
          entryFeePercentagePerUnit ?? this.entryFeePercentagePerUnit,
      entryFeeAmountPerUnit:
          entryFeeAmountPerUnit ?? this.entryFeeAmountPerUnit,
      exitFeeAmountPerUnit: exitFeeAmountPerUnit ?? this.exitFeeAmountPerUnit,
      exitFeePercentagePerUnit:
          exitFeePercentagePerUnit ?? this.exitFeePercentagePerUnit,
      taxRate: taxRate ?? this.taxRate,
      exitFeeType: exitFeeType ?? this.exitFeeType,
      entryFeeType: entryFeeType ?? this.entryFeeType,
    );
  }

  @override
  MatexProfitAndLossCalculatorDocument merge(
    covariant MatexProfitAndLossCalculatorDocument model,
  ) {
    return copyWith(
      positionSize: model.positionSize,
      entryPrice: model.entryPrice,
      exitPrice: model.exitPrice,
      fixedCosts: model.fixedCosts,
      entryFeePercentagePerUnit: model.entryFeePercentagePerUnit,
      entryFeeAmountPerUnit: model.entryFeeAmountPerUnit,
      exitFeeAmountPerUnit: model.exitFeeAmountPerUnit,
      exitFeePercentagePerUnit: model.exitFeePercentagePerUnit,
      taxRate: model.taxRate,
      exitFeeType: model.exitFeeType,
      entryFeeType: model.entryFeeType,
    );
  }

  @override
  MatexProfitAndLossCalculatorBlocFields toFields() {
    return MatexProfitAndLossCalculatorBlocFields(
      positionSize: positionSize,
      entryPrice: entryPrice,
      exitPrice: exitPrice,
      fixedCosts: fixedCosts,
      entryFeePercentagePerUnit: entryFeePercentagePerUnit,
      entryFeeAmountPerUnit: entryFeeAmountPerUnit,
      exitFeeAmountPerUnit: exitFeeAmountPerUnit,
      exitFeePercentagePerUnit: exitFeePercentagePerUnit,
      taxRate: taxRate,
      entryFeeType: entryFeeType,
      exitFeeType: exitFeeType,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'entryFeePercentagePerUnit': entryFeePercentagePerUnit,
      'entryFeeType': entryFeeType,
      'exitFeeType': exitFeeType,
      'exitFeePercentagePerUnit': exitFeePercentagePerUnit,
      'entryFeeAmountPerUnit': entryFeeAmountPerUnit,
      'exitFeeAmountPerUnit': exitFeeAmountPerUnit,
      'positionSize': positionSize,
      'fixedCosts': fixedCosts,
      'entryPrice': entryPrice,
      'exitPrice': exitPrice,
      'taxRate': taxRate,
    };
  }

  static MatexProfitAndLossCalculatorDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexProfitAndLossCalculatorDocument(
      entryFeeType: json['entryFeeType'] as String?,
      exitFeeType: json['exitFeeType'] as String?,
      positionSize: json['positionSize'] as String?,
      entryPrice: json['entryPrice'] as String?,
      exitPrice: json['exitPrice'] as String?,
      fixedCosts: json['fixedCosts'] as String?,
      entryFeePercentagePerUnit: json['entryFeePercentagePerUnit'] as String?,
      entryFeeAmountPerUnit: json['entryFeeAmountPerUnit'] as String?,
      exitFeeAmountPerUnit: json['exitFeeAmountPerUnit'] as String?,
      exitFeePercentagePerUnit: json['exitFeePercentagePerUnit'] as String?,
      taxRate: json['taxRate'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        positionSize,
        entryPrice,
        exitPrice,
        fixedCosts,
        entryFeePercentagePerUnit,
        entryFeeAmountPerUnit,
        exitFeeAmountPerUnit,
        exitFeePercentagePerUnit,
        taxRate,
        entryFeeType,
        exitFeeType,
      ];
}
