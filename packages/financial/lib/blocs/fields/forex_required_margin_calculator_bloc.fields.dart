// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

class MatexForexRequiredMarginCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin
    implements MatexFinancialInstrumentCalculatorBlocFields {
  static const String defaultPositionSizeFieldType = 'unit';

  @override
  late final String? counter;
  @override
  late final String? base;

  late final String positionSizeFieldType;
  late final String? pipDecimalPlaces;
  late final String? accountCurrency;
  late final String? positionSize;
  late final String? leverage;
  late final String? lotSize;

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
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
    String? lotSize,
  }) {
    this.accountCurrency = assignValue(accountCurrency);
    this.base = assignValue(base);
    this.counter = assignValue(counter);
    this.positionSize = assignValue(positionSize);
    this.leverage = assignValue(leverage);
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces);
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
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
    String? lotSize,
  }) {
    return MatexForexRequiredMarginCalculatorBlocFields(
      accountCurrency: accountCurrency ?? this.accountCurrency,
      base: base ?? this.base,
      counter: counter ?? this.counter,
      positionSize: positionSize ?? this.positionSize,
      leverage: leverage ?? this.leverage,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
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
    bool resetPipDecimalPlaces = false,
    bool resetPositionSizeFieldType = false,
    bool resetLotSize = false,
  }) {
    return MatexForexRequiredMarginCalculatorBlocFields(
      accountCurrency: resetAccountCurrency ? null : accountCurrency,
      base: resetBase ? null : base,
      counter: resetCounter ? null : counter,
      positionSize: resetPositionSize ? null : positionSize,
      leverage: resetLeverage ? null : leverage,
      pipDecimalPlaces: resetPipDecimalPlaces ? null : pipDecimalPlaces,
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
      pipDecimalPlaces: model.pipDecimalPlaces,
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
        pipDecimalPlaces,
        positionSizeFieldType,
        lotSize,
      ];
}
