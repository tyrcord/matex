// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexProfitLossCalculatorDocument extends FastCalculatorDocument {
  static const String defaultPositionSizeFieldType = 'unit';
  final String defaultPosition = MatexPosition.long.name;

  late final String? accountCurrency;
  late final String? base;
  late final String? counter;
  late final String? positionSize;
  late final String? entryPrice;
  late final String? pipDecimalPlaces;
  late final String positionSizeFieldType;
  late final String? lotSize;
  late final String? exitPrice;
  late final String position;

  MatexForexProfitLossCalculatorDocument({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? entryPrice,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
    String? lotSize,
    String? exitPrice,
    String? position,
  }) {
    this.accountCurrency = assignValue(accountCurrency);
    this.base = assignValue(base);
    this.counter = assignValue(counter);
    this.positionSize = assignValue(positionSize);
    this.entryPrice = assignValue(entryPrice);
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces);
    this.lotSize = assignValue(lotSize);
    this.exitPrice = assignValue(exitPrice);
    this.positionSizeFieldType =
        positionSizeFieldType ?? defaultPositionSizeFieldType;
    this.position = position ?? defaultPosition;
  }

  @override
  MatexForexProfitLossCalculatorDocument clone() => copyWith();

  @override
  MatexForexProfitLossCalculatorDocument copyWith({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? entryPrice,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
    String? lotSize,
    String? exitPrice,
    String? position,
  }) {
    return MatexForexProfitLossCalculatorDocument(
      accountCurrency: accountCurrency ?? this.accountCurrency,
      base: base ?? this.base,
      counter: counter ?? this.counter,
      positionSize: positionSize ?? this.positionSize,
      entryPrice: entryPrice ?? this.entryPrice,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      lotSize: lotSize ?? this.lotSize,
      positionSizeFieldType:
          positionSizeFieldType ?? this.positionSizeFieldType,
      exitPrice: exitPrice ?? this.exitPrice,
      position: position ?? this.position,
    );
  }

  @override
  MatexForexProfitLossCalculatorDocument copyWithDefaults({
    bool resetAccountCurrency = false,
    bool resetBase = false,
    bool resetCounter = false,
    bool resetPositionSize = false,
    bool resetEntryPrice = false,
    bool resetPipDecimalPlaces = false,
    bool resetPositionSizeFieldType = false,
    bool resetLotSize = false,
    bool resetExitPrice = false,
    bool resetPosition = false,
  }) {
    return MatexForexProfitLossCalculatorDocument(
      accountCurrency: resetAccountCurrency ? null : accountCurrency,
      base: resetBase ? null : base,
      counter: resetCounter ? null : counter,
      positionSize: resetPositionSize ? null : positionSize,
      entryPrice: resetEntryPrice ? null : entryPrice,
      pipDecimalPlaces: resetPipDecimalPlaces ? null : pipDecimalPlaces,
      lotSize: resetLotSize ? null : lotSize,
      positionSizeFieldType:
          resetPositionSizeFieldType ? null : positionSizeFieldType,
      exitPrice: resetExitPrice ? null : exitPrice,
      position: resetPosition ? null : position,
    );
  }

  @override
  MatexForexProfitLossCalculatorDocument merge(
    covariant MatexForexProfitLossCalculatorDocument model,
  ) {
    return copyWith(
      accountCurrency: model.accountCurrency,
      base: model.base,
      counter: model.counter,
      positionSize: model.positionSize,
      entryPrice: model.entryPrice,
      pipDecimalPlaces: model.pipDecimalPlaces,
      positionSizeFieldType: model.positionSizeFieldType,
      lotSize: model.lotSize,
      exitPrice: model.exitPrice,
      position: model.position,
    );
  }

  @override
  MatexForexProfitLossCalculatorBlocFields toFields() {
    return MatexForexProfitLossCalculatorBlocFields(
      accountCurrency: accountCurrency,
      base: base,
      counter: counter,
      positionSize: positionSize,
      entryPrice: entryPrice,
      pipDecimalPlaces: pipDecimalPlaces,
      lotSize: lotSize,
      exitPrice: exitPrice,
      position: MatexPositionX.fromName(position),
      positionSizeFieldType:
          MatexPositionSizeTypeX.fromName(positionSizeFieldType),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'accountCurrency': accountCurrency,
      'base': base,
      'counter': counter,
      'positionSize': positionSize,
      'entryPrice': entryPrice,
      'pipDecimalPlaces': pipDecimalPlaces,
      'positionSizeFieldType': positionSizeFieldType,
      'lotSize': lotSize,
      'exitPrice': exitPrice,
      'position': position,
      ...super.toJson(),
    };
  }

  static MatexForexProfitLossCalculatorDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexForexProfitLossCalculatorDocument(
      accountCurrency: json['accountCurrency'] as String?,
      base: json['base'] as String?,
      counter: json['counter'] as String?,
      positionSize: json['positionSize'] as String?,
      entryPrice: json['entryPrice'] as String?,
      pipDecimalPlaces: json['pipDecimalPlaces'] as String?,
      positionSizeFieldType: json['positionSizeFieldType'] as String?,
      lotSize: json['lotSize'] as String?,
      exitPrice: json['exitPrice'] as String?,
      position: json['position'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        accountCurrency,
        base,
        counter,
        positionSize,
        entryPrice,
        pipDecimalPlaces,
        positionSizeFieldType,
        lotSize,
        exitPrice,
        position,
      ];
}
