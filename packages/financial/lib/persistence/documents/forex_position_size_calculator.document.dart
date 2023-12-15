// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexPositionSizeCalculatorDocument extends FastCalculatorDocument {
  static const String defaultStopLossFieldType = 'price';
  static const String defaultRiskFieldType = 'percent';

  late final String stopLossFieldType;
  late final String pipDecimalPlaces;
  late final String? accountCurrency;
  late final String riskFieldType;
  late final String? stopLossPrice;
  late final String? stopLossPips;
  late final String? accountSize;
  late final String? riskPercent;
  late final String? riskAmount;
  late final String? entryPrice;
  late final String? counter;
  late final String? base;

  MatexForexPositionSizeCalculatorDocument({
    String? accountCurrency,
    String? base,
    String? counter,
    String? pipDecimalPlaces,
    String? riskFieldType,
    String? stopLossFieldType,
    String? accountSize,
    String? riskAmount,
    String? riskPercent,
    String? stopLossPrice,
    String? stopLossPips,
    String? entryPrice,
  }) {
    this.stopLossFieldType = stopLossFieldType ?? defaultStopLossFieldType;
    this.riskFieldType = riskFieldType ?? defaultRiskFieldType;
    this.accountCurrency = assignValue(accountCurrency);
    this.stopLossPrice = assignValue(stopLossPrice);
    this.stopLossPips = assignValue(stopLossPips);
    this.accountSize = assignValue(accountSize);
    this.riskPercent = assignValue(riskPercent);
    this.riskAmount = assignValue(riskAmount);
    this.entryPrice = assignValue(entryPrice);
    this.counter = assignValue(counter);
    this.base = assignValue(base);
    this.pipDecimalPlaces =
        assignValue(pipDecimalPlaces) ?? kDefaultPipPipDecimalPlaces.toString();
  }

  @override
  MatexForexPositionSizeCalculatorDocument clone() => copyWith();

  @override
  MatexForexPositionSizeCalculatorDocument copyWith({
    String? stopLossFieldType,
    String? pipDecimalPlaces,
    String? accountCurrency,
    String? stopLossPrice,
    String? riskFieldType,
    String? stopLossPips,
    String? riskPercent,
    String? accountSize,
    String? entryPrice,
    String? riskAmount,
    String? counter,
    String? base,
  }) {
    return MatexForexPositionSizeCalculatorDocument(
      stopLossFieldType: stopLossFieldType ?? this.stopLossFieldType,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      accountCurrency: accountCurrency ?? this.accountCurrency,
      riskFieldType: riskFieldType ?? this.riskFieldType,
      stopLossPrice: stopLossPrice ?? this.stopLossPrice,
      stopLossPips: stopLossPips ?? this.stopLossPips,
      accountSize: accountSize ?? this.accountSize,
      riskPercent: riskPercent ?? this.riskPercent,
      riskAmount: riskAmount ?? this.riskAmount,
      entryPrice: entryPrice ?? this.entryPrice,
      counter: counter ?? this.counter,
      base: base ?? this.base,
    );
  }

  @override
  MatexForexPositionSizeCalculatorDocument copyWithDefaults({
    bool resetStopLossFieldType = false,
    bool resetPipDecimalPlaces = false,
    bool resetAccountCurrency = false,
    bool resetRiskFieldType = false,
    bool resetStopLossPrice = false,
    bool resetStopLossPips = false,
    bool resetAccountSize = false,
    bool resetRiskPercent = false,
    bool resetRiskAmount = false,
    bool resetEntryPrice = false,
    bool resetCounter = false,
    bool resetBase = false,
  }) {
    return MatexForexPositionSizeCalculatorDocument(
      stopLossFieldType: resetStopLossFieldType ? null : stopLossFieldType,
      pipDecimalPlaces: resetPipDecimalPlaces ? null : pipDecimalPlaces,
      accountCurrency: resetAccountCurrency ? null : accountCurrency,
      riskFieldType: resetRiskFieldType ? null : riskFieldType,
      stopLossPrice: resetStopLossPrice ? null : stopLossPrice,
      stopLossPips: resetStopLossPips ? null : stopLossPips,
      accountSize: resetAccountSize ? null : accountSize,
      riskPercent: resetRiskPercent ? null : riskPercent,
      riskAmount: resetRiskAmount ? null : riskAmount,
      entryPrice: resetEntryPrice ? null : entryPrice,
      counter: resetCounter ? null : counter,
      base: resetBase ? null : base,
    );
  }

  @override
  MatexForexPositionSizeCalculatorDocument merge(
    covariant MatexForexPositionSizeCalculatorDocument model,
  ) {
    return copyWith(
      stopLossFieldType: model.stopLossFieldType,
      pipDecimalPlaces: model.pipDecimalPlaces,
      accountCurrency: model.accountCurrency,
      riskFieldType: model.riskFieldType,
      stopLossPrice: model.stopLossPrice,
      stopLossPips: model.stopLossPips,
      accountSize: model.accountSize,
      riskPercent: model.riskPercent,
      riskAmount: model.riskAmount,
      entryPrice: model.entryPrice,
      counter: model.counter,
      base: model.base,
    );
  }

  @override
  MatexForexPositionSizeCalculatorBlocFields toFields() {
    return MatexForexPositionSizeCalculatorBlocFields(
      stopLossFieldType: stopLossFieldType,
      pipDecimalPlaces: pipDecimalPlaces,
      accountCurrency: accountCurrency,
      stopLossPrice: stopLossPrice,
      riskFieldType: riskFieldType,
      stopLossPips: stopLossPips,
      accountSize: accountSize,
      riskPercent: riskPercent,
      riskAmount: riskAmount,
      entryPrice: entryPrice,
      counter: counter,
      base: base,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'stopLossFieldType': stopLossFieldType,
      'pipDecimalPlaces': pipDecimalPlaces,
      'accountCurrency': accountCurrency,
      'riskFieldType': riskFieldType,
      'stopLossPrice': stopLossPrice,
      'stopLossPips': stopLossPips,
      'accountSize': accountSize,
      'riskPercent': riskPercent,
      'riskAmount': riskAmount,
      'entryPrice': entryPrice,
      'counter': counter,
      'base': base,
      ...super.toJson(),
    };
  }

  static MatexForexPositionSizeCalculatorDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexForexPositionSizeCalculatorDocument(
      stopLossFieldType: json['stopLossFieldType'] as String?,
      pipDecimalPlaces: json['pipDecimalPlaces'] as String?,
      accountCurrency: json['accountCurrency'] as String?,
      riskFieldType: json['riskFieldType'] as String?,
      stopLossPrice: json['stopLossPrice'] as String?,
      stopLossPips: json['stopLossPips'] as String?,
      accountSize: json['accountSize'] as String?,
      riskPercent: json['riskPercent'] as String?,
      riskAmount: json['riskAmount'] as String?,
      entryPrice: json['entryPrice'] as String?,
      counter: json['counter'] as String?,
      base: json['base'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        stopLossFieldType,
        pipDecimalPlaces,
        accountCurrency,
        riskFieldType,
        stopLossPrice,
        stopLossPips,
        accountSize,
        riskPercent,
        entryPrice,
        riskAmount,
        counter,
        base,
      ];
}
