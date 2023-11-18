// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

const String _kDefaultPositionSizeFieldType = 'unit';

class MatexForexPositionSizeCalculatorDocument extends FastCalculatorDocument {
  late final String? accountCurrency;
  late final String? base;
  late final String? counter;
  late final String? positionSize;
  late final String? numberOfPips;
  late final String? pipDecimalPlaces;
  late final String positionSizeFieldType;
  late final String? lotSize;

  MatexForexPositionSizeCalculatorDocument({
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
  MatexForexPositionSizeCalculatorDocument clone() => copyWith();

  @override
  MatexForexPositionSizeCalculatorDocument copyWith({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? numberOfPips,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
    String? lotSize,
  }) {
    return MatexForexPositionSizeCalculatorDocument(
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
  MatexForexPositionSizeCalculatorDocument copyWithDefaults({
    bool accountCurrency = false,
    bool base = false,
    bool counter = false,
    bool positionSize = false,
    bool numberOfPips = false,
    bool pipDecimalPlaces = false,
    bool positionSizeFieldType = false,
    bool lotSize = false,
  }) {
    return MatexForexPositionSizeCalculatorDocument(
      accountCurrency: accountCurrency ? null : this.accountCurrency,
      base: base ? null : this.base,
      counter: counter ? null : this.counter,
      positionSize: positionSize ? null : this.positionSize,
      numberOfPips: numberOfPips ? null : this.numberOfPips,
      pipDecimalPlaces: pipDecimalPlaces ? null : this.pipDecimalPlaces,
      lotSize: lotSize ? null : this.lotSize,
      positionSizeFieldType:
          positionSizeFieldType ? null : this.positionSizeFieldType,
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
      positionSize: model.positionSize,
      numberOfPips: model.numberOfPips,
      pipDecimalPlaces: model.pipDecimalPlaces,
      positionSizeFieldType: model.positionSizeFieldType,
      lotSize: model.lotSize,
    );
  }

  @override
  MatexForexPositionSizeCalculatorBlocFields toFields() {
    return MatexForexPositionSizeCalculatorBlocFields(
      accountCurrency: accountCurrency,
      base: base,
      counter: counter,
      positionSize: positionSize,
      numberOfPips: numberOfPips,
      pipDecimalPlaces: pipDecimalPlaces,
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
      'numberOfPips': numberOfPips,
      'pipDecimalPlaces': pipDecimalPlaces,
      'positionSizeFieldType': positionSizeFieldType,
      'lotSize': lotSize,
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
