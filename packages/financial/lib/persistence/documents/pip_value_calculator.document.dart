// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_financial/fastyle_financial.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

final String _kDefaultPositionSizeFieldType =
    FastPositionSizeSwitchFieldType.unit.name;

class MatexPipValueCalculatorDocument extends FastCalculatorDocument {
  late final String? accountCurrency;
  late final String? baseCurrency;
  late final String? counterCurrency;
  late final String? positionSize;
  late final String? numberOfPips;
  late final String? pipDecimalPlaces;
  late final String positionSizeFieldType;

  MatexPipValueCalculatorDocument({
    String? accountCurrency,
    String? baseCurrency,
    String? counterCurrency,
    String? positionSize,
    String? numberOfPips,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
  }) {
    this.accountCurrency = assignValue(accountCurrency);
    this.baseCurrency = assignValue(baseCurrency);
    this.counterCurrency = assignValue(counterCurrency);
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
    String? baseCurrency,
    String? counterCurrency,
    String? positionSize,
    String? numberOfPips,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
  }) {
    return MatexPipValueCalculatorDocument(
      accountCurrency: accountCurrency ?? this.accountCurrency,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      counterCurrency: counterCurrency ?? this.counterCurrency,
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
    bool baseCurrency = false,
    bool counterCurrency = false,
    bool positionSize = false,
    bool numberOfPips = false,
    bool pipDecimalPlaces = false,
    bool positionSizeFieldType = false,
  }) {
    return MatexPipValueCalculatorDocument(
      accountCurrency: accountCurrency ? null : this.accountCurrency,
      baseCurrency: baseCurrency ? null : this.baseCurrency,
      counterCurrency: counterCurrency ? null : this.counterCurrency,
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
      baseCurrency: model.baseCurrency,
      counterCurrency: model.counterCurrency,
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
      baseCurrency: baseCurrency,
      counterCurrency: counterCurrency,
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
      'baseCurrency': baseCurrency,
      'counterCurrency': counterCurrency,
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
      baseCurrency: json['baseCurrency'] as String?,
      counterCurrency: json['counterCurrency'] as String?,
      positionSize: json['positionSize'] as String?,
      numberOfPips: json['numberOfPips'] as String?,
      pipDecimalPlaces: json['pipDecimalPlaces'] as String?,
      positionSizeFieldType: json['positionSizeFieldType'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        accountCurrency,
        baseCurrency,
        counterCurrency,
        positionSize,
        numberOfPips,
        pipDecimalPlaces,
        positionSizeFieldType,
      ];
}
