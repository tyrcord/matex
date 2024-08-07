// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexStockPositionSizeCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  static final defaultTakeProfitFieldType =
      MatexTakeProfitSwitchFieldType.riskReward.name;
  static const MatexPosition defaultPosition = MatexPosition.long;
  static const String defaultRiskFieldType = 'percent';

  late final String? slippagePercent;
  late final String? stopLossAmount;
  late final MatexPosition position;
  late final String? stopLossPrice;
  late final String riskFieldType;
  late final String? riskPercent;
  late final String? accountSize;
  late final String? entryPrice;
  late final String? riskReward;
  late final String? entryFees;
  late final String? exitFees;
  late final String? takeProfitPrice;
  late final String? takeProfitFieldType;

  String get formattedAccountSize {
    final accountBalance = parseStringToDouble(accountSize);

    return localizeCurrency(value: accountBalance);
  }

  String get formattedEntryPrice {
    final entryPriceValue = parseStringToDouble(entryPrice);

    return localizeCurrency(value: entryPriceValue);
  }

  String get formattedStopLossPrice {
    final stopLossPriceValue = parseStringToDouble(stopLossPrice);

    return localizeCurrency(value: stopLossPriceValue);
  }

  String get formattedStopLossAmount {
    final stopLossAmountValue = parseStringToDouble(stopLossAmount);

    return localizeCurrency(value: stopLossAmountValue);
  }

  String get formattedSlippagePercent {
    final slippagePercentValue = parseStringToDouble(slippagePercent);

    return '${localizeNumber(value: slippagePercentValue)}%';
  }

  String get formattedRiskPercent {
    final riskPercentValue = parseStringToDouble(riskPercent);

    return '${localizeNumber(value: riskPercentValue)}%';
  }

  String get formattedRiskReward {
    final riskRewardValue = parseStringToDouble(riskReward);

    return '1:${localizeNumber(value: riskRewardValue)}';
  }

  String get formattedEntryFees {
    final entryFeesValue = parseStringToDouble(entryFees);

    return '${localizeNumber(value: entryFeesValue)}%';
  }

  String get formattedExitFees {
    final exitFeesValue = parseStringToDouble(exitFees);

    return '${localizeNumber(value: exitFeesValue)}%';
  }

  String get formattedPosition => position.localizedName;

  String get formattedTakeProfitPrice {
    final takeProfitPriceValue = parseStringToDouble(takeProfitPrice);

    return localizeCurrency(value: takeProfitPriceValue);
  }

  MatexStockPositionSizeCalculatorBlocFields({
    FastCalculatorBlocDelegate? delegate,
    String? slippagePercent,
    MatexPosition? position,
    String? stopLossAmount,
    String? riskFieldType,
    String? stopLossPrice,
    String? accountSize,
    String? riskPercent,
    String? entryPrice,
    String? riskReward,
    String? entryFees,
    String? exitFees,
    String? takeProfitPrice,
    String? takeProfitFieldType,
  }) {
    this.riskFieldType = riskFieldType ?? defaultRiskFieldType;
    this.slippagePercent = assignValue(slippagePercent);
    this.stopLossAmount = assignValue(stopLossAmount);
    this.stopLossPrice = assignValue(stopLossPrice);
    this.accountSize = assignValue(accountSize);
    this.riskPercent = assignValue(riskPercent);
    this.position = position ?? defaultPosition;
    this.entryPrice = assignValue(entryPrice);
    this.riskReward = assignValue(riskReward);
    this.entryFees = assignValue(entryFees);
    this.exitFees = assignValue(exitFees);
    this.delegate = delegate;
    this.takeProfitPrice = assignValue(takeProfitPrice);
    this.takeProfitFieldType =
        takeProfitFieldType ?? defaultTakeProfitFieldType;
  }

  @override
  MatexStockPositionSizeCalculatorBlocFields clone() => copyWith();

  @override
  MatexStockPositionSizeCalculatorBlocFields copyWith({
    FastCalculatorBlocDelegate? delegate,
    MatexPosition? position,
    String? slippagePercent,
    String? stopLossAmount,
    String? stopLossPrice,
    String? riskFieldType,
    String? accountSize,
    String? riskPercent,
    String? entryPrice,
    String? riskReward,
    String? entryFees,
    String? exitFees,
    String? takeProfitPrice,
    String? takeProfitFieldType,
  }) {
    return MatexStockPositionSizeCalculatorBlocFields(
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
      delegate: delegate,
      takeProfitPrice: takeProfitPrice ?? this.takeProfitPrice,
      takeProfitFieldType: takeProfitFieldType ?? this.takeProfitFieldType,
    );
  }

  @override
  MatexStockPositionSizeCalculatorBlocFields copyWithDefaults({
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
    bool resetTakeProfitPrice = false,
    bool resetTakeProfitFieldType = false,
  }) {
    return MatexStockPositionSizeCalculatorBlocFields(
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
      delegate: delegate,
      takeProfitPrice: resetTakeProfitPrice ? null : takeProfitPrice,
      takeProfitFieldType:
          resetTakeProfitFieldType ? null : takeProfitFieldType,
    );
  }

  @override
  MatexStockPositionSizeCalculatorBlocFields merge(
    covariant MatexStockPositionSizeCalculatorBlocFields model,
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
      delegate: model.delegate,
      takeProfitPrice: model.takeProfitPrice,
      takeProfitFieldType: model.takeProfitFieldType,
    );
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
        takeProfitPrice,
        takeProfitFieldType,
      ];

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
      'position': position.name,
      'takeProfitPrice': takeProfitPrice,
      'takeProfitFieldType': takeProfitFieldType,
    };
  }
}
