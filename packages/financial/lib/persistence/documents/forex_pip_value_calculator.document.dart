// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexPipValueCalculatorDocument extends FastCalculatorDocument {
  static const String defaultPositionSizeFieldType = 'unit';

  late final String? positionSizeFieldType;
  late final String? pipDecimalPlaces;
  late final String? accountCurrency;
  late final String? positionSize;
  late final String? numberOfPips;
  late final String? lotSize;
  late final String? counter;
  late final String? base;

  MatexForexPipValueCalculatorDocument({
    String? positionSizeFieldType,
    String? pipDecimalPlaces,
    String? accountCurrency,
    String? positionSize,
    String? numberOfPips,
    String? counter,
    String? lotSize,
    String? base,
  }) {
    this.accountCurrency = assignValue(accountCurrency);
    this.positionSize = assignValue(positionSize);
    this.numberOfPips = assignValue(numberOfPips);
    this.lotSize = assignValue(lotSize);
    this.counter = assignValue(counter);
    this.base = assignValue(base);
    this.positionSizeFieldType =
        positionSizeFieldType ?? defaultPositionSizeFieldType;
    this.pipDecimalPlaces =
        assignValue(pipDecimalPlaces) ?? kDefaultPipPipDecimalPlaces.toString();
  }

  @override
  MatexForexPipValueCalculatorDocument clone() => copyWith();

  @override
  MatexForexPipValueCalculatorDocument copyWith({
    String? positionSizeFieldType,
    String? pipDecimalPlaces,
    String? accountCurrency,
    String? positionSize,
    String? numberOfPips,
    String? counter,
    String? lotSize,
    String? base,
  }) {
    return MatexForexPipValueCalculatorDocument(
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      accountCurrency: accountCurrency ?? this.accountCurrency,
      positionSize: positionSize ?? this.positionSize,
      numberOfPips: numberOfPips ?? this.numberOfPips,
      lotSize: lotSize ?? this.lotSize,
      counter: counter ?? this.counter,
      base: base ?? this.base,
      positionSizeFieldType:
          positionSizeFieldType ?? this.positionSizeFieldType,
    );
  }

  @override
  MatexForexPipValueCalculatorDocument copyWithDefaults({
    bool resetPositionSizeFieldType = false,
    bool resetPipDecimalPlaces = false,
    bool resetAccountCurrency = false,
    bool resetPositionSize = false,
    bool resetNumberOfPips = false,
    bool resetCounter = false,
    bool resetLotSize = false,
    bool resetBase = false,
  }) {
    return MatexForexPipValueCalculatorDocument(
      pipDecimalPlaces: resetPipDecimalPlaces ? null : pipDecimalPlaces,
      accountCurrency: resetAccountCurrency ? null : accountCurrency,
      numberOfPips: resetNumberOfPips ? null : numberOfPips,
      positionSize: resetPositionSize ? null : positionSize,
      lotSize: resetLotSize ? null : lotSize,
      counter: resetCounter ? null : counter,
      base: resetBase ? null : base,
      positionSizeFieldType:
          resetPositionSizeFieldType ? null : positionSizeFieldType,
    );
  }

  @override
  MatexForexPipValueCalculatorDocument merge(
    covariant MatexForexPipValueCalculatorDocument model,
  ) {
    return copyWith(
      positionSizeFieldType: model.positionSizeFieldType,
      pipDecimalPlaces: model.pipDecimalPlaces,
      accountCurrency: model.accountCurrency,
      positionSize: model.positionSize,
      numberOfPips: model.numberOfPips,
      lotSize: model.lotSize,
      counter: model.counter,
      base: model.base,
    );
  }

  @override
  MatexForexPipValueCalculatorBlocFields toFields() {
    return MatexForexPipValueCalculatorBlocFields(
      pipDecimalPlaces: pipDecimalPlaces,
      accountCurrency: accountCurrency,
      positionSize: positionSize,
      numberOfPips: numberOfPips,
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
      'pipDecimalPlaces': pipDecimalPlaces,
      'accountCurrency': accountCurrency,
      'numberOfPips': numberOfPips,
      'positionSize': positionSize,
      'counter': counter,
      'lotSize': lotSize,
      'base': base,
      ...super.toJson(),
    };
  }

  static MatexForexPipValueCalculatorDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexForexPipValueCalculatorDocument(
      positionSizeFieldType: json['positionSizeFieldType'] as String?,
      pipDecimalPlaces: json['pipDecimalPlaces'] as String?,
      accountCurrency: json['accountCurrency'] as String?,
      positionSize: json['positionSize'] as String?,
      numberOfPips: json['numberOfPips'] as String?,
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
        numberOfPips,
        lotSize,
        counter,
        base,
      ];
}
