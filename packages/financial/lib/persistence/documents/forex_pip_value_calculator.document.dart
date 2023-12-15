// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexPipValueCalculatorDocument extends FastCalculatorDocument {
  static const String _kDefaultPositionSizeFieldType = 'unit';

  late final String? accountCurrency;
  late final String? base;
  late final String? counter;
  late final String? positionSize;
  late final String? numberOfPips;
  late final String? pipDecimalPlaces;
  late final String positionSizeFieldType;
  late final String? lotSize;

  MatexForexPipValueCalculatorDocument({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? numberOfPips,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
    String? lotSize,
  }) {
    this.accountCurrency = assignValue(accountCurrency);
    this.base = assignValue(base);
    this.counter = assignValue(counter);
    this.positionSize = assignValue(positionSize);
    this.numberOfPips = assignValue(numberOfPips);
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces);
    this.lotSize = assignValue(lotSize);
    this.positionSizeFieldType =
        positionSizeFieldType ?? _kDefaultPositionSizeFieldType;
  }

  @override
  MatexForexPipValueCalculatorDocument clone() => copyWith();

  @override
  MatexForexPipValueCalculatorDocument copyWith({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? numberOfPips,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
    String? lotSize,
  }) {
    return MatexForexPipValueCalculatorDocument(
      accountCurrency: accountCurrency ?? this.accountCurrency,
      base: base ?? this.base,
      counter: counter ?? this.counter,
      positionSize: positionSize ?? this.positionSize,
      numberOfPips: numberOfPips ?? this.numberOfPips,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      lotSize: lotSize ?? this.lotSize,
      positionSizeFieldType:
          positionSizeFieldType ?? this.positionSizeFieldType,
    );
  }

  @override
  MatexForexPipValueCalculatorDocument copyWithDefaults({
    bool resetAccountCurrency = false,
    bool resetBase = false,
    bool resetCounter = false,
    bool resetPositionSize = false,
    bool resetNumberOfPips = false,
    bool resetPipDecimalPlaces = false,
    bool resetPositionSizeFieldType = false,
    bool resetLotSize = false,
  }) {
    return MatexForexPipValueCalculatorDocument(
      pipDecimalPlaces: resetPipDecimalPlaces ? null : pipDecimalPlaces,
      accountCurrency: resetAccountCurrency ? null : accountCurrency,
      positionSize: resetPositionSize ? null : positionSize,
      numberOfPips: resetNumberOfPips ? null : numberOfPips,
      counter: resetCounter ? null : counter,
      lotSize: resetLotSize ? null : lotSize,
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
      accountCurrency: model.accountCurrency,
      base: model.base,
      counter: model.counter,
      positionSize: model.positionSize,
      numberOfPips: model.numberOfPips,
      pipDecimalPlaces: model.pipDecimalPlaces,
      positionSizeFieldType: model.positionSizeFieldType,
      lotSize: model.lotSize,
    );
  }

  @override
  MatexForexPipValueCalculatorBlocFields toFields() {
    return MatexForexPipValueCalculatorBlocFields(
      accountCurrency: accountCurrency,
      base: base,
      counter: counter,
      positionSize: positionSize,
      numberOfPips: numberOfPips,
      pipDecimalPlaces: pipDecimalPlaces,
      lotSize: lotSize,
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
      'numberOfPips': numberOfPips,
      'pipDecimalPlaces': pipDecimalPlaces,
      'positionSizeFieldType': positionSizeFieldType,
      'lotSize': lotSize,
      ...super.toJson(),
    };
  }

  static MatexForexPipValueCalculatorDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexForexPipValueCalculatorDocument(
      accountCurrency: json['accountCurrency'] as String?,
      base: json['base'] as String?,
      counter: json['counter'] as String?,
      positionSize: json['positionSize'] as String?,
      numberOfPips: json['numberOfPips'] as String?,
      pipDecimalPlaces: json['pipDecimalPlaces'] as String?,
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
        numberOfPips,
        pipDecimalPlaces,
        positionSizeFieldType,
        lotSize,
      ];
}
