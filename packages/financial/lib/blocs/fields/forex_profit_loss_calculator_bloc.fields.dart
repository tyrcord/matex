// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexProfitLossCalculatorBlocFields
    extends MatexFinancialInstrumentCalculatorBlocFields
    with MatexCalculatorFormatterMixin {
  static const defaultPositionSizeFieldType = MatexPositionSizeType.unit;
  final defaultPosition = MatexPosition.long;

  late final MatexPositionSizeType positionSizeFieldType;
  late final String? pipDecimalPlaces;
  late final String? accountCurrency;
  late final MatexPosition position;
  late final String? positionSize;
  late final String? entryPrice;
  late final String? exitPrice;
  late final String? lotSize;

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

  String get formattedLotSize {
    final value = parseFieldValueToDouble(lotSize);

    return localizeNumber(value: value);
  }

  String get formattedPosition => position.localizedName;

  String get formattedPositionSize {
    final value = parseFieldValueToDouble(positionSize);

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

  MatexForexProfitLossCalculatorBlocFields({
    MatexPositionSizeType? positionSizeFieldType,
    FastCalculatorBlocDelegate? delegate,
    String? pipDecimalPlaces,
    String? accountCurrency,
    MatexPosition? position,
    String? positionSize,
    String? entryPrice,
    String? exitPrice,
    String? lotSize,
    String? counter,
    String? base,
  }) {
    this.accountCurrency = assignValue(accountCurrency);
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces);
    this.positionSize = assignValue(positionSize);
    this.position = position ?? defaultPosition;
    this.entryPrice = assignValue(entryPrice);
    this.exitPrice = assignValue(exitPrice);
    this.lotSize = assignValue(lotSize);
    this.counter = assignValue(counter);
    this.base = assignValue(base);
    this.delegate = delegate;
    this.positionSizeFieldType =
        positionSizeFieldType ?? defaultPositionSizeFieldType;
  }

  @override
  MatexForexProfitLossCalculatorBlocFields clone() => copyWith();

  @override
  MatexForexProfitLossCalculatorBlocFields copyWith({
    MatexPositionSizeType? positionSizeFieldType,
    FastCalculatorBlocDelegate? delegate,
    String? pipDecimalPlaces,
    String? accountCurrency,
    MatexPosition? position,
    String? positionSize,
    String? entryPrice,
    String? exitPrice,
    String? counter,
    String? lotSize,
    String? base,
  }) {
    return MatexForexProfitLossCalculatorBlocFields(
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      accountCurrency: accountCurrency ?? this.accountCurrency,
      positionSize: positionSize ?? this.positionSize,
      entryPrice: entryPrice ?? this.entryPrice,
      exitPrice: exitPrice ?? this.exitPrice,
      position: position ?? this.position,
      delegate: delegate ?? this.delegate,
      lotSize: lotSize ?? this.lotSize,
      counter: counter ?? this.counter,
      base: base ?? this.base,
      positionSizeFieldType:
          positionSizeFieldType ?? this.positionSizeFieldType,
    );
  }

  @override
  MatexForexProfitLossCalculatorBlocFields copyWithDefaults({
    bool resetPositionSizeFieldType = false,
    bool resetPipDecimalPlaces = false,
    bool resetAccountCurrency = false,
    bool resetPositionSize = false,
    bool resetEntryPrice = false,
    bool resetExitPrice = false,
    bool resetPosition = false,
    bool resetCounter = false,
    bool resetLotSize = false,
    bool resetBase = false,
  }) {
    return MatexForexProfitLossCalculatorBlocFields(
      pipDecimalPlaces: resetPipDecimalPlaces ? null : pipDecimalPlaces,
      accountCurrency: resetAccountCurrency ? null : accountCurrency,
      positionSize: resetPositionSize ? null : positionSize,
      entryPrice: resetEntryPrice ? null : entryPrice,
      exitPrice: resetExitPrice ? null : exitPrice,
      position: resetPosition ? null : position,
      lotSize: resetLotSize ? null : lotSize,
      counter: resetCounter ? null : counter,
      base: resetBase ? null : base,
      delegate: delegate,
      positionSizeFieldType:
          resetPositionSizeFieldType ? null : positionSizeFieldType,
    );
  }

  @override
  MatexForexProfitLossCalculatorBlocFields merge(
    covariant MatexForexProfitLossCalculatorBlocFields model,
  ) {
    return copyWith(
      positionSizeFieldType: model.positionSizeFieldType,
      pipDecimalPlaces: model.pipDecimalPlaces,
      accountCurrency: model.accountCurrency,
      positionSize: model.positionSize,
      entryPrice: model.entryPrice,
      exitPrice: model.exitPrice,
      delegate: model.delegate,
      position: model.position,
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
        entryPrice,
        exitPrice,
        position,
        counter,
        lotSize,
        base,
      ];
}
