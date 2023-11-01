import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:fastyle_financial/fastyle_financial.dart';

final String _kDefaultPositionSizeFieldType =
    FastPositionSizeSwitchFieldType.unit.name;

class MatexPipValueCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  late final String? accountCurrency;
  late final String? baseCurrency;
  late final String? counterCurrency;
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

  String get financialInstrument {
    if (baseCurrency == null || counterCurrency == null) return '';

    return '$baseCurrency/$counterCurrency';
  }

  MatexPipValueCalculatorBlocFields({
    String? accountCurrency,
    String? baseCurrency,
    String? counterCurrency,
    String? positionSize,
    String? numberOfPips,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
    MatexCalculatorBlocDelegate? delegate,
  }) {
    this.accountCurrency = assignValue(accountCurrency);
    this.baseCurrency = assignValue(baseCurrency);
    this.counterCurrency = assignValue(counterCurrency);
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
  MatexPipValueCalculatorBlocFields copyWith({
    String? accountCurrency,
    String? baseCurrency,
    String? counterCurrency,
    String? positionSize,
    String? numberOfPips,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
    MatexCalculatorBlocDelegate? delegate,
  }) {
    return MatexPipValueCalculatorBlocFields(
      accountCurrency: accountCurrency ?? this.accountCurrency,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      counterCurrency: counterCurrency ?? this.counterCurrency,
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
      baseCurrency: model.baseCurrency,
      counterCurrency: model.counterCurrency,
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
        baseCurrency,
        counterCurrency,
        positionSize,
        numberOfPips,
        pipDecimalPlaces,
        positionSizeFieldType,
        delegate,
      ];
}