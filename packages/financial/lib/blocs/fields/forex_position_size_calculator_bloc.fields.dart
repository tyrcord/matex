// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexForexPositionSizeCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin
    implements MatexFinancialInstrumentCalculatorBlocFields {
  static const String defaultStopLossFieldType = 'price';
  static const String defaultRiskFieldType = 'percent';

  @override
  late final String? base;
  @override
  late final String? counter;

  late final String? stopLossFieldType;
  late final String? pipDecimalPlaces;
  late final String? accountCurrency;
  late final String? riskFieldType;
  late final String? stopLossPrice;
  late final String? stopLossPips;
  late final String? accountSize;
  late final String? riskPercent;
  late final String? riskAmount;
  late final String? entryPrice;

  String get formattedAccountSize {
    final accountBalance = parseFieldValueToDouble(accountSize);

    return localizeCurrency(value: accountBalance);
  }

  String get formattedEntryPrice {
    final pipDecimalPlacesValue = parseFieldValueToDouble(pipDecimalPlaces);
    final value = parseFieldValueToDouble(entryPrice);

    return localizeCurrency(
      minimumFractionDigits: pipDecimalPlacesValue.toInt(),
      maximumFractionDigits: kMatexQuoteMaxFractionDigits,
      value: value,
    );
  }

  String get formattedStopLossPrice {
    final pipDecimalPlacesValue = parseFieldValueToDouble(pipDecimalPlaces);
    final value = parseFieldValueToDouble(stopLossPrice);

    return localizeCurrency(
      minimumFractionDigits: pipDecimalPlacesValue.toInt(),
      maximumFractionDigits: kMatexQuoteMaxFractionDigits,
      value: value,
    );
  }

  String get formattedRiskPercent {
    final riskPercentValue = parseFieldValueToDouble(riskPercent);

    return '${localizeNumber(value: riskPercentValue)}%';
  }

  String get formattedRiskAmount {
    final riskAmountValue = parseFieldValueToDouble(riskAmount);

    return localizeCurrency(value: riskAmountValue);
  }

  String get formattedStopLossPips {
    final stopLossPipsValue = parseFieldValueToDouble(stopLossPips);

    return localizeNumber(value: stopLossPipsValue);
  }

  String get formattedFinancialInstrument {
    if (base == null || counter == null) return '';

    return financialInstrument?.formattedSymbol ?? '';
  }

  MatexFinancialInstrument? get financialInstrument {
    if (base == null || counter == null) return null;

    return MatexFinancialInstrument(base: base!, counter: counter!);
  }

  MatexForexPositionSizeCalculatorBlocFields({
    FastCalculatorBlocDelegate? delegate,
    String? stopLossFieldType,
    String? pipDecimalPlaces,
    String? accountCurrency,
    String? riskFieldType,
    String? stopLossPrice,
    String? stopLossPips,
    String? riskPercent,
    String? accountSize,
    String? riskAmount,
    String? entryPrice,
    String? counter,
    String? base,
  }) {
    this.stopLossFieldType = stopLossFieldType ?? defaultStopLossFieldType;
    this.riskFieldType = riskFieldType ?? defaultRiskFieldType;
    this.accountCurrency = assignValue(accountCurrency);
    this.stopLossPrice = assignValue(stopLossPrice);
    this.stopLossPips = assignValue(stopLossPips);
    this.accountSize = assignValue(accountSize);
    this.riskPercent = assignValue(riskPercent);
    this.riskAmount = assignValue(riskAmount);
    this.entryPrice = assignValue(entryPrice);
    this.counter = assignValue(counter);
    this.base = assignValue(base);
    this.delegate = delegate;
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces) ??
        kMatexDefaultPipDecimalPlaces.toString();
  }

  @override
  MatexForexPositionSizeCalculatorBlocFields clone() => copyWith();

  @override
  MatexForexPositionSizeCalculatorBlocFields copyWith({
    FastCalculatorBlocDelegate? delegate,
    String? stopLossFieldType,
    String? pipDecimalPlaces,
    String? accountCurrency,
    String? stopLossPrice,
    String? riskFieldType,
    String? stopLossPips,
    String? riskPercent,
    String? accountSize,
    String? entryPrice,
    String? riskAmount,
    String? counter,
    String? base,
  }) {
    return MatexForexPositionSizeCalculatorBlocFields(
      stopLossFieldType: stopLossFieldType ?? this.stopLossFieldType,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      accountCurrency: accountCurrency ?? this.accountCurrency,
      riskFieldType: riskFieldType ?? this.riskFieldType,
      stopLossPrice: stopLossPrice ?? this.stopLossPrice,
      stopLossPips: stopLossPips ?? this.stopLossPips,
      accountSize: accountSize ?? this.accountSize,
      riskPercent: riskPercent ?? this.riskPercent,
      riskAmount: riskAmount ?? this.riskAmount,
      entryPrice: entryPrice ?? this.entryPrice,
      delegate: delegate ?? this.delegate,
      counter: counter ?? this.counter,
      base: base ?? this.base,
    );
  }

  @override
  MatexForexPositionSizeCalculatorBlocFields copyWithDefaults({
    bool resetStopLossFieldType = false,
    bool resetPipDecimalPlaces = false,
    bool resetAccountCurrency = false,
    bool resetRiskFieldType = false,
    bool resetStopLossPrice = false,
    bool resetStopLossPips = false,
    bool resetAccountSize = false,
    bool resetRiskPercent = false,
    bool resetRiskAmount = false,
    bool resetEntryPrice = false,
    bool resetCounter = false,
    bool resetBase = false,
  }) {
    return MatexForexPositionSizeCalculatorBlocFields(
      stopLossFieldType: resetStopLossFieldType ? null : stopLossFieldType,
      pipDecimalPlaces: resetPipDecimalPlaces ? null : pipDecimalPlaces,
      accountCurrency: resetAccountCurrency ? null : accountCurrency,
      riskFieldType: resetRiskFieldType ? null : riskFieldType,
      stopLossPrice: resetStopLossPrice ? null : stopLossPrice,
      stopLossPips: resetStopLossPips ? null : stopLossPips,
      accountSize: resetAccountSize ? null : accountSize,
      riskPercent: resetRiskPercent ? null : riskPercent,
      riskAmount: resetRiskAmount ? null : riskAmount,
      entryPrice: resetEntryPrice ? null : entryPrice,
      counter: resetCounter ? null : counter,
      base: resetBase ? null : base,
      delegate: delegate,
    );
  }

  @override
  MatexForexPositionSizeCalculatorBlocFields merge(
    covariant MatexForexPositionSizeCalculatorBlocFields model,
  ) {
    return copyWith(
      stopLossFieldType: model.stopLossFieldType,
      pipDecimalPlaces: model.pipDecimalPlaces,
      accountCurrency: model.accountCurrency,
      riskFieldType: model.riskFieldType,
      stopLossPrice: model.stopLossPrice,
      stopLossPips: model.stopLossPips,
      accountSize: model.accountSize,
      riskPercent: model.riskPercent,
      riskAmount: model.riskAmount,
      entryPrice: model.entryPrice,
      delegate: model.delegate,
      counter: model.counter,
      base: model.base,
    );
  }

  @override
  List<Object?> get props => [
        stopLossFieldType,
        pipDecimalPlaces,
        accountCurrency,
        riskFieldType,
        stopLossPrice,
        stopLossPips,
        accountSize,
        riskPercent,
        entryPrice,
        riskAmount,
        counter,
        base,
      ];
}
