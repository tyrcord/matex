// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_financial/fastyle_financial.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

final String _kDefaultPositionSizeFieldType =
    FastPositionSizeSwitchFieldType.unit.name;

class MatexPipValueCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin
    implements MatexFinancialInstrumentCalculatorBlocFields {
  @override
  late final String? base;
  @override
  late final String? counter;

  late final String? accountCurrency;
  late final String? positionSize;
  late final String? numberOfPips;
  late final String? pipDecimalPlaces;
  late final String positionSizeFieldType;

  String get formattedPositionSize {
    final value = parseFieldValueToDouble(positionSize);

    return localizeNumber(value: value);
  }

  String get formattedNumberOfPips {
    final value = parseFieldValueToDouble(numberOfPips);

    return localizeNumber(value: value);
  }

  String get formattedFinancialInstrument {
    if (base == null || counter == null) return '';

    return formatCurrencyPair(
      counter: counter!,
      delimiter: '/',
      base: base!,
    );
  }

  MatexFinancialInstrument? get financialInstrument {
    if (base == null || counter == null) return null;

    return MatexFinancialInstrument(
      base: base!,
      counter: counter!,
    );
  }

  MatexPipValueCalculatorBlocFields({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? numberOfPips,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
    FastCalculatorBlocDelegate? delegate,
  }) {
    this.accountCurrency = assignValue(accountCurrency);
    this.base = assignValue(base);
    this.counter = assignValue(counter);
    this.positionSize = assignValue(positionSize);
    this.numberOfPips = assignValue(numberOfPips);
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces);
    this.delegate = delegate;
    this.positionSizeFieldType =
        positionSizeFieldType ?? _kDefaultPositionSizeFieldType;
  }

  @override
  MatexPipValueCalculatorBlocFields clone() => copyWith();

  @override
  MatexPipValueCalculatorBlocFields copyWithDefaults({
    bool accountCurrency = false,
    bool base = false,
    bool counter = false,
    bool positionSize = false,
    bool numberOfPips = false,
    bool pipDecimalPlaces = false,
    bool positionSizeFieldType = false,
  }) {
    return MatexPipValueCalculatorBlocFields(
      accountCurrency: accountCurrency ? null : this.accountCurrency,
      base: base ? null : this.base,
      counter: counter ? null : this.counter,
      positionSize: positionSize ? null : this.positionSize,
      numberOfPips: numberOfPips ? null : this.numberOfPips,
      pipDecimalPlaces: pipDecimalPlaces
          ? kDefaultPipPipDecimalPlaces.toString()
          : this.pipDecimalPlaces,
      positionSizeFieldType:
          positionSizeFieldType ? null : this.positionSizeFieldType,
    );
  }

  @override
  MatexPipValueCalculatorBlocFields copyWith({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? numberOfPips,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
    FastCalculatorBlocDelegate? delegate,
  }) {
    return MatexPipValueCalculatorBlocFields(
      accountCurrency: accountCurrency ?? this.accountCurrency,
      base: base ?? this.base,
      counter: counter ?? this.counter,
      positionSize: positionSize ?? this.positionSize,
      numberOfPips: numberOfPips ?? this.numberOfPips,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      positionSizeFieldType:
          positionSizeFieldType ?? this.positionSizeFieldType,
      delegate: delegate ?? this.delegate,
    );
  }

  @override
  MatexPipValueCalculatorBlocFields merge(
    covariant MatexPipValueCalculatorBlocFields model,
  ) {
    return copyWith(
      accountCurrency: model.accountCurrency,
      base: model.base,
      counter: model.counter,
      positionSize: model.positionSize,
      numberOfPips: model.numberOfPips,
      pipDecimalPlaces: model.pipDecimalPlaces,
      positionSizeFieldType: model.positionSizeFieldType,
      delegate: model.delegate,
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
        delegate,
      ];
}
