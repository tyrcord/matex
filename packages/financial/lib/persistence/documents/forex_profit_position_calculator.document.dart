// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexProfitLossCalculatorDocument extends FastCalculatorDocument {
  static const String defaultPositionSizeFieldType = 'unit';
  final String defaultPosition = MatexPosition.long.name;

  late final String positionSizeFieldType;
  late final String? pipDecimalPlaces;
  late final String? accountCurrency;
  late final String position;
  late final String? positionSize;
  late final String? entryPrice;
  late final String? exitPrice;
  late final String? lotSize;
  late final String? counter;
  late final String? base;

  MatexForexProfitLossCalculatorDocument({
    String? positionSizeFieldType,
    String? pipDecimalPlaces,
    String? accountCurrency,
    String? positionSize,
    String? entryPrice,
    String? exitPrice,
    String? position,
    String? lotSize,
    String? counter,
    String? base,
  }) {
    this.accountCurrency = assignValue(accountCurrency);
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces);
    this.positionSize = assignValue(positionSize);
    this.position = position ?? defaultPosition;
    this.entryPrice = assignValue(entryPrice);
    this.exitPrice = assignValue(exitPrice);
    this.lotSize = assignValue(lotSize);
    this.counter = assignValue(counter);
    this.base = assignValue(base);
    this.positionSizeFieldType =
        positionSizeFieldType ?? defaultPositionSizeFieldType;
    this.pipDecimalPlaces =
        assignValue(pipDecimalPlaces) ?? kDefaultPipPipDecimalPlaces.toString();
  }

  @override
  MatexForexProfitLossCalculatorDocument clone() => copyWith();

  @override
  MatexForexProfitLossCalculatorDocument copyWith({
    String? positionSizeFieldType,
    String? pipDecimalPlaces,
    String? accountCurrency,
    String? positionSize,
    String? entryPrice,
    String? exitPrice,
    String? position,
    String? lotSize,
    String? counter,
    String? base,
  }) {
    return MatexForexProfitLossCalculatorDocument(
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      accountCurrency: accountCurrency ?? this.accountCurrency,
      positionSize: positionSize ?? this.positionSize,
      entryPrice: entryPrice ?? this.entryPrice,
      exitPrice: exitPrice ?? this.exitPrice,
      position: position ?? this.position,
      lotSize: lotSize ?? this.lotSize,
      counter: counter ?? this.counter,
      base: base ?? this.base,
      positionSizeFieldType:
          positionSizeFieldType ?? this.positionSizeFieldType,
    );
  }

  @override
  MatexForexProfitLossCalculatorDocument copyWithDefaults({
    bool resetPositionSizeFieldType = false,
    bool resetPipDecimalPlaces = false,
    bool resetAccountCurrency = false,
    bool resetPositionSize = false,
    bool resetEntryPrice = false,
    bool resetExitPrice = false,
    bool resetPosition = false,
    bool resetCounter = false,
    bool resetLotSize = false,
    bool resetBase = false,
  }) {
    return MatexForexProfitLossCalculatorDocument(
      pipDecimalPlaces: resetPipDecimalPlaces ? null : pipDecimalPlaces,
      accountCurrency: resetAccountCurrency ? null : accountCurrency,
      positionSize: resetPositionSize ? null : positionSize,
      entryPrice: resetEntryPrice ? null : entryPrice,
      exitPrice: resetExitPrice ? null : exitPrice,
      position: resetPosition ? null : position,
      lotSize: resetLotSize ? null : lotSize,
      counter: resetCounter ? null : counter,
      base: resetBase ? null : base,
      positionSizeFieldType:
          resetPositionSizeFieldType ? null : positionSizeFieldType,
    );
  }

  @override
  MatexForexProfitLossCalculatorDocument merge(
    covariant MatexForexProfitLossCalculatorDocument model,
  ) {
    return copyWith(
      positionSizeFieldType: model.positionSizeFieldType,
      pipDecimalPlaces: model.pipDecimalPlaces,
      accountCurrency: model.accountCurrency,
      positionSize: model.positionSize,
      entryPrice: model.entryPrice,
      exitPrice: model.exitPrice,
      position: model.position,
      lotSize: model.lotSize,
      counter: model.counter,
      base: model.base,
    );
  }

  @override
  MatexForexProfitLossCalculatorBlocFields toFields() {
    return MatexForexProfitLossCalculatorBlocFields(
      position: MatexPositionX.fromName(position),
      pipDecimalPlaces: pipDecimalPlaces,
      accountCurrency: accountCurrency,
      positionSize: positionSize,
      entryPrice: entryPrice,
      exitPrice: exitPrice,
      lotSize: lotSize,
      counter: counter,
      base: base,
      positionSizeFieldType:
          MatexPositionSizeTypeX.fromName(positionSizeFieldType),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'positionSizeFieldType': positionSizeFieldType,
      'pipDecimalPlaces': pipDecimalPlaces,
      'accountCurrency': accountCurrency,
      'positionSize': positionSize,
      'entryPrice': entryPrice,
      'exitPrice': exitPrice,
      'position': position,
      'lotSize': lotSize,
      'counter': counter,
      'base': base,
      ...super.toJson(),
    };
  }

  static MatexForexProfitLossCalculatorDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexForexProfitLossCalculatorDocument(
      positionSizeFieldType: json['positionSizeFieldType'] as String?,
      pipDecimalPlaces: json['pipDecimalPlaces'] as String?,
      accountCurrency: json['accountCurrency'] as String?,
      positionSize: json['positionSize'] as String?,
      entryPrice: json['entryPrice'] as String?,
      exitPrice: json['exitPrice'] as String?,
      position: json['position'] as String?,
      lotSize: json['lotSize'] as String?,
      counter: json['counter'] as String?,
      base: json['base'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        positionSizeFieldType,
        pipDecimalPlaces,
        accountCurrency,
        positionSize,
        entryPrice,
        exitPrice,
        position,
        counter,
        lotSize,
        base,
      ];
}
