// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

class MatexForexRequiredMarginCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin, MatexFinancialCalculatorFormatterMixin
    implements MatexFinancialInstrumentCalculatorBlocFields {
  static const String defaultPositionSizeFieldType = 'unit';

  @override
  late final String? counter;
  @override
  late final String? base;

  late final String positionSizeFieldType;
  late final String? accountCurrency;
  late final String? positionSize;
  late final String? leverage;
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

  // FIXME: Move to a abstract class
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

  MatexForexRequiredMarginCalculatorBlocFields({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? leverage,
    String? positionSizeFieldType,
    String? lotSize,
  }) {
    this.accountCurrency = assignValue(accountCurrency);
    this.base = assignValue(base);
    this.counter = assignValue(counter);
    this.positionSize = assignValue(positionSize);
    this.leverage = assignValue(leverage);
    this.lotSize = assignValue(lotSize);
    this.positionSizeFieldType =
        positionSizeFieldType ?? defaultPositionSizeFieldType;
  }

  @override
  MatexForexRequiredMarginCalculatorBlocFields clone() => copyWith();

  @override
  MatexForexRequiredMarginCalculatorBlocFields copyWith({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? leverage,
    String? positionSizeFieldType,
    String? lotSize,
  }) {
    return MatexForexRequiredMarginCalculatorBlocFields(
      accountCurrency: accountCurrency ?? this.accountCurrency,
      base: base ?? this.base,
      counter: counter ?? this.counter,
      positionSize: positionSize ?? this.positionSize,
      leverage: leverage ?? this.leverage,
      lotSize: lotSize ?? this.lotSize,
      positionSizeFieldType:
          positionSizeFieldType ?? this.positionSizeFieldType,
    );
  }

  @override
  MatexForexRequiredMarginCalculatorBlocFields copyWithDefaults({
    bool resetAccountCurrency = false,
    bool resetBase = false,
    bool resetCounter = false,
    bool resetPositionSize = false,
    bool resetLeverage = false,
    bool resetPositionSizeFieldType = false,
    bool resetLotSize = false,
  }) {
    return MatexForexRequiredMarginCalculatorBlocFields(
      accountCurrency: resetAccountCurrency ? null : accountCurrency,
      base: resetBase ? null : base,
      counter: resetCounter ? null : counter,
      positionSize: resetPositionSize ? null : positionSize,
      leverage: resetLeverage ? null : leverage,
      lotSize: resetLotSize ? null : lotSize,
      positionSizeFieldType:
          resetPositionSizeFieldType ? null : positionSizeFieldType,
    );
  }

  @override
  MatexForexRequiredMarginCalculatorBlocFields merge(
    covariant MatexForexRequiredMarginCalculatorBlocFields model,
  ) {
    return copyWith(
      accountCurrency: model.accountCurrency,
      base: model.base,
      counter: model.counter,
      positionSize: model.positionSize,
      leverage: model.leverage,
      positionSizeFieldType: model.positionSizeFieldType,
      lotSize: model.lotSize,
    );
  }

  @override
  List<Object?> get props => [
        accountCurrency,
        base,
        counter,
        positionSize,
        leverage,
        positionSizeFieldType,
        lotSize,
      ];
}
