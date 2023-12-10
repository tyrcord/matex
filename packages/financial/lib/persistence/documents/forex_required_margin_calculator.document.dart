// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexRequiredMarginCalculatorDocument
    extends FastCalculatorDocument {
  static const String _kDefaultPositionSizeFieldType = 'unit';

  late final String? accountCurrency;
  late final String? base;
  late final String? counter;
  late final String? positionSize;
  late final String leverage;
  late final String positionSizeFieldType;
  late final String? lotSize;

  MatexForexRequiredMarginCalculatorDocument({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? leverage,
    String? positionSizeFieldType,
    String? lotSize,
  }) {
    this.accountCurrency = assignValue(accountCurrency);
    this.base = assignValue(base);
    this.counter = assignValue(counter);
    this.positionSize = assignValue(positionSize);
    this.leverage = assignValue(leverage) ?? '1';
    this.lotSize = assignValue(lotSize);
    this.positionSizeFieldType =
        positionSizeFieldType ?? _kDefaultPositionSizeFieldType;
  }

  @override
  MatexForexRequiredMarginCalculatorDocument clone() => copyWith();

  @override
  MatexForexRequiredMarginCalculatorDocument copyWith({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? leverage,
    String? positionSizeFieldType,
    String? lotSize,
  }) {
    return MatexForexRequiredMarginCalculatorDocument(
      accountCurrency: accountCurrency ?? this.accountCurrency,
      base: base ?? this.base,
      counter: counter ?? this.counter,
      positionSize: positionSize ?? this.positionSize,
      leverage: leverage ?? this.leverage,
      lotSize: lotSize ?? this.lotSize,
      positionSizeFieldType:
          positionSizeFieldType ?? this.positionSizeFieldType,
    );
  }

  @override
  MatexForexRequiredMarginCalculatorDocument copyWithDefaults({
    bool resetAccountCurrency = false,
    bool resetBase = false,
    bool resetCounter = false,
    bool resetPositionSize = false,
    bool resetLeverage = false,
    bool resetPositionSizeFieldType = false,
    bool resetLotSize = false,
  }) {
    return MatexForexRequiredMarginCalculatorDocument(
      accountCurrency: resetAccountCurrency ? null : accountCurrency,
      base: resetBase ? null : base,
      counter: resetCounter ? null : counter,
      positionSize: resetPositionSize ? null : positionSize,
      leverage: resetLeverage ? null : leverage,
      lotSize: resetLotSize ? null : lotSize,
      positionSizeFieldType:
          resetPositionSizeFieldType ? null : positionSizeFieldType,
    );
  }

  @override
  MatexForexRequiredMarginCalculatorDocument merge(
    covariant MatexForexRequiredMarginCalculatorDocument model,
  ) {
    return copyWith(
      accountCurrency: model.accountCurrency,
      base: model.base,
      counter: model.counter,
      positionSize: model.positionSize,
      leverage: model.leverage,
      positionSizeFieldType: model.positionSizeFieldType,
      lotSize: model.lotSize,
    );
  }

  @override
  MatexForexRequiredMarginCalculatorBlocFields toFields() {
    return MatexForexRequiredMarginCalculatorBlocFields(
      accountCurrency: accountCurrency,
      base: base,
      counter: counter,
      positionSize: positionSize,
      leverage: leverage,
      positionSizeFieldType: positionSizeFieldType,
      lotSize: lotSize,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'accountCurrency': accountCurrency,
      'base': base,
      'counter': counter,
      'positionSize': positionSize,
      'leverage': leverage,
      'positionSizeFieldType': positionSizeFieldType,
      'lotSize': lotSize,
      ...super.toJson(),
    };
  }

  static MatexForexRequiredMarginCalculatorDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexForexRequiredMarginCalculatorDocument(
      accountCurrency: json['accountCurrency'] as String?,
      base: json['base'] as String?,
      counter: json['counter'] as String?,
      positionSize: json['positionSize'] as String?,
      leverage: json['leverage'] as String?,
      positionSizeFieldType: json['positionSizeFieldType'] as String?,
      lotSize: json['lotSize'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        accountCurrency,
        base,
        counter,
        positionSize,
        leverage,
        positionSizeFieldType,
        lotSize,
      ];
}
