// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexPositionSizeCalculatorDocument extends FastCalculatorDocument {
  late final String? accountCurrency;
  late final String? base;
  late final String? counter;
  late final String? pipDecimalPlaces;
  late final String? accountSizeFieldType;
  late final String? riskFieldType;
  late final String? stopLossFieldType;
  late final String? accountSize;
  late final String? riskAmount;
  late final String? riskPercent;
  late final String? stopLossPrice;
  late final String? stopLossPips;

  MatexForexPositionSizeCalculatorDocument({
    String? accountCurrency,
    String? base,
    String? counter,
    String? pipDecimalPlaces,
    String? accountSizeFieldType,
    String? riskFieldType,
    String? stopLossFieldType,
    String? accountSize,
    String? riskAmount,
    String? riskPercent,
    String? stopLossPrice,
    String? stopLossPips,
  }) {
    this.accountCurrency = assignValue(accountCurrency);
    this.base = assignValue(base);
    this.counter = assignValue(counter);
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces);
    this.accountSizeFieldType = assignValue(accountSizeFieldType);
    this.riskFieldType = assignValue(riskFieldType);
    this.stopLossFieldType = assignValue(stopLossFieldType);
    this.accountSize = assignValue(accountSize);
    this.riskAmount = assignValue(riskAmount);
    this.riskPercent = assignValue(riskPercent);
    this.stopLossPrice = assignValue(stopLossPrice);
    this.stopLossPips = assignValue(stopLossPips);
  }

  @override
  MatexForexPositionSizeCalculatorDocument clone() => copyWith();

  @override
  MatexForexPositionSizeCalculatorDocument copyWithDefaults({
    bool accountCurrency = false,
    bool base = false,
    bool counter = false,
    bool pipDecimalPlaces = false,
    bool accountSizeFieldType = false,
    bool riskFieldType = false,
    bool stopLossFieldType = false,
    bool accountSize = false,
    bool riskAmount = false,
    bool riskPercent = false,
    bool stopLossPrice = false,
    bool stopLossPips = false,
  }) {
    return MatexForexPositionSizeCalculatorDocument(
      accountCurrency: accountCurrency ? null : this.accountCurrency,
      base: base ? null : this.base,
      counter: counter ? null : this.counter,
      pipDecimalPlaces: pipDecimalPlaces
          ? kDefaultPipPipDecimalPlaces.toString()
          : this.pipDecimalPlaces,
      accountSizeFieldType:
          accountSizeFieldType ? null : this.accountSizeFieldType,
      riskFieldType: riskFieldType ? null : this.riskFieldType,
      stopLossFieldType: stopLossFieldType ? null : this.stopLossFieldType,
      accountSize: accountSize ? null : this.accountSize,
      riskAmount: riskAmount ? null : this.riskAmount,
      riskPercent: riskPercent ? null : this.riskPercent,
      stopLossPrice: stopLossPrice ? null : this.stopLossPrice,
      stopLossPips: stopLossPips ? null : this.stopLossPips,
    );
  }

  @override
  MatexForexPositionSizeCalculatorDocument copyWith({
    String? accountCurrency,
    String? base,
    String? counter,
    String? pipDecimalPlaces,
    String? accountSizeFieldType,
    String? riskFieldType,
    String? stopLossFieldType,
    String? accountSize,
    String? riskAmount,
    String? riskPercent,
    String? stopLossPrice,
    String? stopLossPips,
  }) {
    return MatexForexPositionSizeCalculatorDocument(
      accountCurrency: accountCurrency ?? this.accountCurrency,
      base: base ?? this.base,
      counter: counter ?? this.counter,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      accountSizeFieldType: accountSizeFieldType ?? this.accountSizeFieldType,
      riskFieldType: riskFieldType ?? this.riskFieldType,
      stopLossFieldType: stopLossFieldType ?? this.stopLossFieldType,
      accountSize: accountSize ?? this.accountSize,
      riskAmount: riskAmount ?? this.riskAmount,
      riskPercent: riskPercent ?? this.riskPercent,
      stopLossPrice: stopLossPrice ?? this.stopLossPrice,
      stopLossPips: stopLossPips ?? this.stopLossPips,
    );
  }

  @override
  MatexForexPositionSizeCalculatorDocument merge(
    covariant MatexForexPositionSizeCalculatorDocument model,
  ) {
    return copyWith(
      accountCurrency: model.accountCurrency,
      base: model.base,
      counter: model.counter,
      pipDecimalPlaces: model.pipDecimalPlaces,
      accountSizeFieldType: model.accountSizeFieldType,
      riskFieldType: model.riskFieldType,
      stopLossFieldType: model.stopLossFieldType,
      accountSize: model.accountSize,
      riskAmount: model.riskAmount,
      riskPercent: model.riskPercent,
      stopLossPrice: model.stopLossPrice,
      stopLossPips: model.stopLossPips,
    );
  }

  @override
  MatexForexPositionSizeCalculatorBlocFields toFields() {
    return MatexForexPositionSizeCalculatorBlocFields(
      accountCurrency: accountCurrency,
      base: base,
      counter: counter,
      pipDecimalPlaces: pipDecimalPlaces,
      accountSizeFieldType: accountSizeFieldType,
      riskFieldType: riskFieldType,
      stopLossFieldType: stopLossFieldType,
      accountSize: accountSize,
      riskAmount: riskAmount,
      riskPercent: riskPercent,
      stopLossPrice: stopLossPrice,
      stopLossPips: stopLossPips,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'accountCurrency': accountCurrency,
      'base': base,
      'counter': counter,
      'pipDecimalPlaces': pipDecimalPlaces,
      'accountSizeFieldType': accountSizeFieldType,
      'riskFieldType': riskFieldType,
      'stopLossFieldType': stopLossFieldType,
      'accountSize': accountSize,
      'riskAmount': riskAmount,
      'riskPercent': riskPercent,
      'stopLossPrice': stopLossPrice,
      'stopLossPips': stopLossPips,
      ...super.toJson(),
    };
  }

  static MatexForexPositionSizeCalculatorDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexForexPositionSizeCalculatorDocument(
      accountCurrency: json['accountCurrency'] as String?,
      base: json['base'] as String?,
      counter: json['counter'] as String?,
      pipDecimalPlaces: json['pipDecimalPlaces'] as String?,
      accountSizeFieldType: json['accountSizeFieldType'] as String?,
      riskFieldType: json['riskFieldType'] as String?,
      stopLossFieldType: json['stopLossFieldType'] as String?,
      accountSize: json['accountSize'] as String?,
      riskAmount: json['riskAmount'] as String?,
      riskPercent: json['riskPercent'] as String?,
      stopLossPrice: json['stopLossPrice'] as String?,
      stopLossPips: json['stopLossPips'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        accountCurrency,
        base,
        counter,
        pipDecimalPlaces,
        accountSizeFieldType,
        riskFieldType,
        stopLossFieldType,
        accountSize,
        riskAmount,
        riskPercent,
        stopLossPrice,
        stopLossPips,
      ];
}