import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_forms/fastyle_forms.dart';

final String _kDefaultEntryFeeType = FastAmountSwitchFieldType.amount.name;
final String _kDefaultExitFeeType = FastAmountSwitchFieldType.amount.name;

class MatexProfitAndLossCalculatorBlocFields extends FastCalculatorFields {
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

  MatexProfitAndLossCalculatorBlocFields({
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
  MatexProfitAndLossCalculatorBlocFields clone() => copyWith();

  @override
  MatexProfitAndLossCalculatorBlocFields copyWith({
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
    return MatexProfitAndLossCalculatorBlocFields(
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
  MatexProfitAndLossCalculatorBlocFields merge(
    covariant MatexProfitAndLossCalculatorBlocFields model,
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
        exitFeeType,
        entryFeeType,
      ];
}
