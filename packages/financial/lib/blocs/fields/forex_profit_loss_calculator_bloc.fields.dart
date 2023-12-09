// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

class MatexForexProfitLossCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin
    implements MatexFinancialInstrumentCalculatorBlocFields {
  static const String defaultPositionSizeFieldType = 'unit';
  final defaultPosition = MatexPosition.long;

  @override
  late final String? base;
  @override
  late final String? counter;

  late final String? accountCurrency;

  late final String? positionSize;
  late final String? pipDecimalPlaces;
  late final String positionSizeFieldType;
  late final String? lotSize;
  late final String? entryPrice;
  late final String? exitPrice;
  late final MatexPosition position;

  String get formattedEntryPrice {
    final value = parseFieldValueToDouble(entryPrice);

    return localizeNumber(
      maximumFractionDigits: kMatexQuoteMaxFractionDigits,
      value: value,
    );
  }

  String get formattedExitPrice {
    final value = parseFieldValueToDouble(exitPrice);

    return localizeNumber(
      maximumFractionDigits: kMatexQuoteMaxFractionDigits,
      value: value,
    );
  }

  String get formattedPosition => position.localizedName;

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

  MatexForexProfitLossCalculatorBlocFields({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? entryPrice,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
    String? lotSize,
    String? exitPrice,
    MatexPosition? position,
  }) {
    this.accountCurrency = assignValue(accountCurrency);
    this.base = assignValue(base);
    this.counter = assignValue(counter);
    this.positionSize = assignValue(positionSize);
    this.entryPrice = assignValue(entryPrice);
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces);
    this.lotSize = assignValue(lotSize);
    this.exitPrice = assignValue(exitPrice);
    this.positionSizeFieldType =
        positionSizeFieldType ?? defaultPositionSizeFieldType;
    this.position = position ?? defaultPosition;
  }

  @override
  MatexForexProfitLossCalculatorBlocFields clone() => copyWith();

  @override
  MatexForexProfitLossCalculatorBlocFields copyWith({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? entryPrice,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
    String? lotSize,
    String? exitPrice,
    MatexPosition? position,
  }) {
    return MatexForexProfitLossCalculatorBlocFields(
      accountCurrency: accountCurrency ?? this.accountCurrency,
      base: base ?? this.base,
      counter: counter ?? this.counter,
      positionSize: positionSize ?? this.positionSize,
      entryPrice: entryPrice ?? this.entryPrice,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      lotSize: lotSize ?? this.lotSize,
      positionSizeFieldType:
          positionSizeFieldType ?? this.positionSizeFieldType,
      exitPrice: exitPrice ?? this.exitPrice,
      position: position ?? this.position,
    );
  }

  @override
  MatexForexProfitLossCalculatorBlocFields copyWithDefaults({
    bool resetAccountCurrency = false,
    bool resetBase = false,
    bool resetCounter = false,
    bool resetPositionSize = false,
    bool resetEntryPrice = false,
    bool resetPipDecimalPlaces = false,
    bool resetPositionSizeFieldType = false,
    bool resetLotSize = false,
    bool resetExitPrice = false,
    bool resetPosition = false,
  }) {
    return MatexForexProfitLossCalculatorBlocFields(
      accountCurrency: resetAccountCurrency ? null : accountCurrency,
      base: resetBase ? null : base,
      counter: resetCounter ? null : counter,
      positionSize: resetPositionSize ? null : positionSize,
      entryPrice: resetEntryPrice ? null : entryPrice,
      pipDecimalPlaces: resetPipDecimalPlaces ? null : pipDecimalPlaces,
      lotSize: resetLotSize ? null : lotSize,
      positionSizeFieldType:
          resetPositionSizeFieldType ? null : positionSizeFieldType,
      exitPrice: resetExitPrice ? null : exitPrice,
      position: resetPosition ? null : position,
    );
  }

  @override
  MatexForexProfitLossCalculatorBlocFields merge(
    covariant MatexForexProfitLossCalculatorBlocFields model,
  ) {
    return copyWith(
      accountCurrency: model.accountCurrency,
      base: model.base,
      counter: model.counter,
      positionSize: model.positionSize,
      entryPrice: model.entryPrice,
      pipDecimalPlaces: model.pipDecimalPlaces,
      positionSizeFieldType: model.positionSizeFieldType,
      lotSize: model.lotSize,
      exitPrice: model.exitPrice,
      position: model.position,
    );
  }

  @override
  List<Object?> get props => [
        accountCurrency,
        base,
        counter,
        positionSize,
        entryPrice,
        pipDecimalPlaces,
        positionSizeFieldType,
        lotSize,
        exitPrice,
        position,
      ];
}
