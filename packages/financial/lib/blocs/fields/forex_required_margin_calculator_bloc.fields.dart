// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexForexRequiredMarginCalculatorBlocFields
    extends MatexFinancialInstrumentCalculatorBlocFields
    with MatexCalculatorFormatterMixin, MatexFinancialCalculatorFormatterMixin {
  static const defaultPositionSizeFieldType = MatexPositionSizeType.unit;
  static final String defaultLeverage = kMatexDefaultLeverage.toString();

  late final MatexPositionSizeType positionSizeFieldType;
  late final String? accountCurrency;
  late final String? positionSize;
  late final String leverage;
  late final String? lotSize;

  List<double>? get leverages => kMatexLeverages;

  List<String>? get formattedLeverages {
    if (leverages == null) return null;

    return leverages!.map((leverage) => localizeLeverage(leverage)).toList();
  }

  String get formattedLeverage {
    final value = parseFieldValueToDouble(leverage);

    return localizeLeverage(value);
  }

  String get formattedPositionSize {
    final value = parseFieldValueToDouble(positionSize);

    return localizeNumber(value: value);
  }

  String get formattedLotSize {
    final value = parseFieldValueToDouble(lotSize);

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

  MatexForexRequiredMarginCalculatorBlocFields({
    MatexPositionSizeType? positionSizeFieldType,
    FastCalculatorBlocDelegate? delegate,
    String? accountCurrency,
    String? positionSize,
    String? leverage,
    String? counter,
    String? lotSize,
    String? base,
  }) {
    this.leverage = assignValue(leverage) ?? defaultLeverage;
    this.accountCurrency = assignValue(accountCurrency);
    this.positionSize = assignValue(positionSize);
    this.counter = assignValue(counter);
    this.lotSize = assignValue(lotSize);
    this.base = assignValue(base);
    this.delegate = delegate;
    this.positionSizeFieldType =
        positionSizeFieldType ?? defaultPositionSizeFieldType;
  }

  @override
  MatexForexRequiredMarginCalculatorBlocFields clone() => copyWith();

  @override
  MatexForexRequiredMarginCalculatorBlocFields copyWith({
    MatexPositionSizeType? positionSizeFieldType,
    FastCalculatorBlocDelegate? delegate,
    String? accountCurrency,
    String? positionSize,
    String? leverage,
    String? lotSize,
    String? counter,
    String? base,
  }) {
    return MatexForexRequiredMarginCalculatorBlocFields(
      accountCurrency: accountCurrency ?? this.accountCurrency,
      positionSize: positionSize ?? this.positionSize,
      leverage: leverage ?? this.leverage,
      delegate: delegate ?? this.delegate,
      lotSize: lotSize ?? this.lotSize,
      counter: counter ?? this.counter,
      base: base ?? this.base,
      positionSizeFieldType:
          positionSizeFieldType ?? this.positionSizeFieldType,
    );
  }

  @override
  MatexForexRequiredMarginCalculatorBlocFields copyWithDefaults({
    bool resetPositionSizeFieldType = false,
    bool resetAccountCurrency = false,
    bool resetPositionSize = false,
    bool resetLeverage = false,
    bool resetLotSize = false,
    bool resetCounter = false,
    bool resetBase = false,
  }) {
    return MatexForexRequiredMarginCalculatorBlocFields(
      accountCurrency: resetAccountCurrency ? null : accountCurrency,
      positionSize: resetPositionSize ? null : positionSize,
      leverage: resetLeverage ? null : leverage,
      lotSize: resetLotSize ? null : lotSize,
      counter: resetCounter ? null : counter,
      base: resetBase ? null : base,
      delegate: delegate,
      positionSizeFieldType:
          resetPositionSizeFieldType ? null : positionSizeFieldType,
    );
  }

  @override
  MatexForexRequiredMarginCalculatorBlocFields merge(
    covariant MatexForexRequiredMarginCalculatorBlocFields model,
  ) {
    return copyWith(
      positionSizeFieldType: model.positionSizeFieldType,
      accountCurrency: model.accountCurrency,
      positionSize: model.positionSize,
      leverage: model.leverage,
      lotSize: model.lotSize,
      counter: model.counter,
      base: model.base,
    );
  }

  @override
  List<Object?> get props => [
        positionSizeFieldType,
        accountCurrency,
        positionSize,
        leverage,
        lotSize,
        counter,
        base,
      ];
}
