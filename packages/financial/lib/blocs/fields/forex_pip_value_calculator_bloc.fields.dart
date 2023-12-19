// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexForexPipValueCalculatorBlocFields
    extends MatexFinancialInstrumentCalculatorBlocFields
    with MatexCalculatorFormatterMixin {
  static const defaultPositionSizeFieldType = MatexPositionSizeType.unit;

  late final MatexPositionSizeType positionSizeFieldType;
  late final String? pipDecimalPlaces;
  late final String? accountCurrency;
  late final String? positionSize;
  late final String? numberOfPips;
  late final String? lotSize;

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

    return financialInstrument?.formattedSymbol ?? '';
  }

  MatexFinancialInstrument? get financialInstrument {
    if (base == null || counter == null) return null;

    return MatexFinancialInstrument(base: base!, counter: counter!);
  }

  MatexForexPipValueCalculatorBlocFields({
    MatexPositionSizeType? positionSizeFieldType,
    FastCalculatorBlocDelegate? delegate,
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
    this.counter = assignValue(counter);
    this.lotSize = assignValue(lotSize);
    this.base = assignValue(base);
    this.delegate = delegate;
    this.positionSizeFieldType =
        positionSizeFieldType ?? defaultPositionSizeFieldType;
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces) ??
        kMatexDefaultPipDecimalPlaces.toString();
  }

  @override
  MatexForexPipValueCalculatorBlocFields clone() => copyWith();

  @override
  MatexForexPipValueCalculatorBlocFields copyWith({
    MatexPositionSizeType? positionSizeFieldType,
    FastCalculatorBlocDelegate? delegate,
    String? pipDecimalPlaces,
    String? accountCurrency,
    String? positionSize,
    String? numberOfPips,
    String? lotSize,
    String? counter,
    String? base,
  }) {
    return MatexForexPipValueCalculatorBlocFields(
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      accountCurrency: accountCurrency ?? this.accountCurrency,
      positionSize: positionSize ?? this.positionSize,
      numberOfPips: numberOfPips ?? this.numberOfPips,
      delegate: delegate ?? this.delegate,
      lotSize: lotSize ?? this.lotSize,
      counter: counter ?? this.counter,
      base: base ?? this.base,
      positionSizeFieldType:
          positionSizeFieldType ?? this.positionSizeFieldType,
    );
  }

  @override
  MatexForexPipValueCalculatorBlocFields copyWithDefaults({
    bool resetPositionSizeFieldType = false,
    bool resetPipDecimalPlaces = false,
    bool resetAccountCurrency = false,
    bool resetPositionSize = false,
    bool resetNumberOfPips = false,
    bool resetCounter = false,
    bool resetLotSize = false,
    bool resetBase = false,
  }) {
    return MatexForexPipValueCalculatorBlocFields(
      pipDecimalPlaces: resetPipDecimalPlaces ? null : pipDecimalPlaces,
      accountCurrency: resetAccountCurrency ? null : accountCurrency,
      numberOfPips: resetNumberOfPips ? null : numberOfPips,
      positionSize: resetPositionSize ? null : positionSize,
      lotSize: resetLotSize ? null : lotSize,
      counter: resetCounter ? null : counter,
      base: resetBase ? null : base,
      delegate: delegate,
      positionSizeFieldType:
          resetPositionSizeFieldType ? null : positionSizeFieldType,
    );
  }

  @override
  MatexForexPipValueCalculatorBlocFields merge(
    covariant MatexForexPipValueCalculatorBlocFields model,
  ) {
    return copyWith(
      positionSizeFieldType: model.positionSizeFieldType,
      pipDecimalPlaces: model.pipDecimalPlaces,
      accountCurrency: model.accountCurrency,
      positionSize: model.positionSize,
      numberOfPips: model.numberOfPips,
      delegate: model.delegate,
      lotSize: model.lotSize,
      counter: model.counter,
      base: model.base,
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
