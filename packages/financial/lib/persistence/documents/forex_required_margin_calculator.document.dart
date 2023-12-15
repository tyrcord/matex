// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexRequiredMarginCalculatorDocument
    extends FastCalculatorDocument {
  static const String defaultPositionSizeFieldType = 'unit';
  static const String defaultLeverage = '1';

  late final String positionSizeFieldType;
  late final String? accountCurrency;
  late final String? positionSize;
  late final String leverage;
  late final String? lotSize;
  late final String? counter;
  late final String? base;

  MatexForexRequiredMarginCalculatorDocument({
    String? positionSizeFieldType,
    String? accountCurrency,
    String? positionSize,
    String? leverage,
    String? lotSize,
    String? counter,
    String? base,
  }) {
    this.leverage = assignValue(leverage) ?? defaultLeverage;
    this.accountCurrency = assignValue(accountCurrency);
    this.positionSize = assignValue(positionSize);
    this.counter = assignValue(counter);
    this.lotSize = assignValue(lotSize);
    this.base = assignValue(base);
    this.positionSizeFieldType =
        positionSizeFieldType ?? defaultPositionSizeFieldType;
  }

  @override
  MatexForexRequiredMarginCalculatorDocument clone() => copyWith();

  @override
  MatexForexRequiredMarginCalculatorDocument copyWith({
    String? positionSizeFieldType,
    String? accountCurrency,
    String? positionSize,
    String? leverage,
    String? lotSize,
    String? counter,
    String? base,
  }) {
    return MatexForexRequiredMarginCalculatorDocument(
      accountCurrency: accountCurrency ?? this.accountCurrency,
      positionSize: positionSize ?? this.positionSize,
      leverage: leverage ?? this.leverage,
      lotSize: lotSize ?? this.lotSize,
      counter: counter ?? this.counter,
      base: base ?? this.base,
      positionSizeFieldType:
          positionSizeFieldType ?? this.positionSizeFieldType,
    );
  }

  @override
  MatexForexRequiredMarginCalculatorDocument copyWithDefaults({
    bool resetPositionSizeFieldType = false,
    bool resetAccountCurrency = false,
    bool resetPositionSize = false,
    bool resetLeverage = false,
    bool resetLotSize = false,
    bool resetCounter = false,
    bool resetBase = false,
  }) {
    return MatexForexRequiredMarginCalculatorDocument(
      accountCurrency: resetAccountCurrency ? null : accountCurrency,
      positionSize: resetPositionSize ? null : positionSize,
      leverage: resetLeverage ? null : leverage,
      lotSize: resetLotSize ? null : lotSize,
      counter: resetCounter ? null : counter,
      base: resetBase ? null : base,
      positionSizeFieldType:
          resetPositionSizeFieldType ? null : positionSizeFieldType,
    );
  }

  @override
  MatexForexRequiredMarginCalculatorDocument merge(
    covariant MatexForexRequiredMarginCalculatorDocument model,
  ) {
    return copyWith(
      positionSizeFieldType: model.positionSizeFieldType,
      accountCurrency: model.accountCurrency,
      positionSize: model.positionSize,
      leverage: model.leverage,
      lotSize: model.lotSize,
      counter: model.counter,
      base: model.base,
    );
  }

  @override
  MatexForexRequiredMarginCalculatorBlocFields toFields() {
    return MatexForexRequiredMarginCalculatorBlocFields(
      accountCurrency: accountCurrency,
      positionSize: positionSize,
      leverage: leverage,
      counter: counter,
      lotSize: lotSize,
      base: base,
      positionSizeFieldType:
          MatexPositionSizeTypeX.fromName(positionSizeFieldType),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'positionSizeFieldType': positionSizeFieldType,
      'accountCurrency': accountCurrency,
      'positionSize': positionSize,
      'leverage': leverage,
      'counter': counter,
      'lotSize': lotSize,
      'base': base,
      ...super.toJson(),
    };
  }

  static MatexForexRequiredMarginCalculatorDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexForexRequiredMarginCalculatorDocument(
      positionSizeFieldType: json['positionSizeFieldType'] as String?,
      accountCurrency: json['accountCurrency'] as String?,
      positionSize: json['positionSize'] as String?,
      leverage: json['leverage'] as String?,
      counter: json['counter'] as String?,
      lotSize: json['lotSize'] as String?,
      base: json['base'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        positionSizeFieldType,
        accountCurrency,
        positionSize,
        leverage,
        lotSize,
        counter,
        base,
      ];
}
