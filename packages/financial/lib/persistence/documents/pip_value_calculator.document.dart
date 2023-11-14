// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_financial/fastyle_financial.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

final String _kDefaultPositionSizeFieldType =
    FastPositionSizeSwitchFieldType.unit.name;

class MatexPipValueCalculatorDocument extends FastCalculatorDocument {
  late final String? accountCurrency;
  late final String? base;
  late final String? counter;
  late final String? positionSize;
  late final String? numberOfPips;
  late final String? pipDecimalPlaces;
  late final String positionSizeFieldType;

  MatexPipValueCalculatorDocument({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? numberOfPips,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
  }) {
    this.accountCurrency = assignValue(accountCurrency);
    this.base = assignValue(base);
    this.counter = assignValue(counter);
    this.positionSize = assignValue(positionSize);
    this.numberOfPips = assignValue(numberOfPips);
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces);
    this.positionSizeFieldType =
        positionSizeFieldType ?? _kDefaultPositionSizeFieldType;
  }

  @override
  MatexPipValueCalculatorDocument clone() => copyWith();

  @override
  MatexPipValueCalculatorDocument copyWith({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? numberOfPips,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
  }) {
    return MatexPipValueCalculatorDocument(
      accountCurrency: accountCurrency ?? this.accountCurrency,
      base: base ?? this.base,
      counter: counter ?? this.counter,
      positionSize: positionSize ?? this.positionSize,
      numberOfPips: numberOfPips ?? this.numberOfPips,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      positionSizeFieldType:
          positionSizeFieldType ?? this.positionSizeFieldType,
    );
  }

  @override
  MatexPipValueCalculatorDocument copyWithDefaults({
    bool accountCurrency = false,
    bool base = false,
    bool counter = false,
    bool positionSize = false,
    bool numberOfPips = false,
    bool pipDecimalPlaces = false,
    bool positionSizeFieldType = false,
  }) {
    return MatexPipValueCalculatorDocument(
      accountCurrency: accountCurrency ? null : this.accountCurrency,
      base: base ? null : this.base,
      counter: counter ? null : this.counter,
      positionSize: positionSize ? null : this.positionSize,
      numberOfPips: numberOfPips ? null : this.numberOfPips,
      pipDecimalPlaces: pipDecimalPlaces ? null : this.pipDecimalPlaces,
      positionSizeFieldType:
          positionSizeFieldType ? null : this.positionSizeFieldType,
    );
  }

  @override
  MatexPipValueCalculatorDocument merge(
    covariant MatexPipValueCalculatorDocument model,
  ) {
    return copyWith(
      accountCurrency: model.accountCurrency,
      base: model.base,
      counter: model.counter,
      positionSize: model.positionSize,
      numberOfPips: model.numberOfPips,
      pipDecimalPlaces: model.pipDecimalPlaces,
      positionSizeFieldType: model.positionSizeFieldType,
    );
  }

  @override
  MatexPipValueCalculatorBlocFields toFields() {
    return MatexPipValueCalculatorBlocFields(
      accountCurrency: accountCurrency,
      base: base,
      counter: counter,
      positionSize: positionSize,
      numberOfPips: numberOfPips,
      pipDecimalPlaces: pipDecimalPlaces,
      positionSizeFieldType: positionSizeFieldType,
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
      ...super.toJson(),
    };
  }

  static MatexPipValueCalculatorDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexPipValueCalculatorDocument(
      accountCurrency: json['accountCurrency'] as String?,
      base: json['base'] as String?,
      counter: json['counter'] as String?,
      positionSize: json['positionSize'] as String?,
      numberOfPips: json['numberOfPips'] as String?,
      pipDecimalPlaces: json['pipDecimalPlaces'] as String?,
      positionSizeFieldType: json['positionSizeFieldType'] as String?,
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
      ];
}
