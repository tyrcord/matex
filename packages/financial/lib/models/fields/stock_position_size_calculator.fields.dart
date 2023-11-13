// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_forms/fastyle_forms.dart';
import 'package:lingua_finance/generated/locale_keys.g.dart';
import 'package:matex_core/core.dart';
import 'package:matex_dart/matex_dart.dart' show MatexPosition;

final String _kDefaultRiskFieldType = FastAmountSwitchFieldType.percent.name;
final String _kDefaultPosition = MatexPosition.long.name;

class MatexStockPositionSizeCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
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

  String get formattedAccountSize {
    final accountBalance = parseFieldValueToDouble(accountSize);

    return localizeCurrency(value: accountBalance);
  }

  String get formattedEntryPrice {
    final entryPriceValue = parseFieldValueToDouble(entryPrice);

    return localizeCurrency(value: entryPriceValue);
  }

  String get formattedStopLossPrice {
    final stopLossPriceValue = parseFieldValueToDouble(stopLossPrice);

    return localizeCurrency(value: stopLossPriceValue);
  }

  String get formattedStopLossAmount {
    final stopLossAmountValue = parseFieldValueToDouble(stopLossAmount);

    return localizeCurrency(value: stopLossAmountValue);
  }

  String get formattedSlippagePercent {
    final slippagePercentValue = parseFieldValueToDouble(slippagePercent);

    return '${localizeNumber(value: slippagePercentValue)}%';
  }

  String get formattedRiskPercent {
    final riskPercentValue = parseFieldValueToDouble(riskPercent);

    return '${localizeNumber(value: riskPercentValue)}%';
  }

  String get formattedRiskReward {
    final riskRewardValue = parseFieldValueToDouble(riskReward);

    return '${localizeNumber(value: riskRewardValue)}:1';
  }

  String get formattedEntryFees {
    final entryFeesValue = parseFieldValueToDouble(entryFees);

    return '${localizeNumber(value: entryFeesValue)}%';
  }

  String get formattedExitFees {
    final exitFeesValue = parseFieldValueToDouble(exitFees);

    return '${localizeNumber(value: exitFeesValue)}%';
  }

  String get formattedPosition {
    return position == MatexPosition.short.name
        ? FinanceLocaleKeys.finance_label_position_short.tr()
        : FinanceLocaleKeys.finance_label_position_long.tr();
  }

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
    FastCalculatorBlocDelegate? delegate,
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
    this.delegate = delegate;
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
    FastCalculatorBlocDelegate? delegate,
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
      delegate: delegate,
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
      delegate: model.delegate,
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
        delegate,
      ];
}
