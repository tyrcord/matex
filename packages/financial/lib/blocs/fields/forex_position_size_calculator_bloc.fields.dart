// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

class MatexForexPositionSizeCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin
    implements MatexFinancialInstrumentCalculatorBlocFields {
  // FIXME: Use constants
  static const String _kDefaultRiskFieldType = 'percent';
  static const String _kDefaultStopLossFieldType = 'price';

  @override
  late final String? base;
  @override
  late final String? counter;

  late final String? accountCurrency;
  late final String? pipDecimalPlaces;
  late final String? riskFieldType;
  late final String? stopLossFieldType;
  late final String? accountSize;
  late final String? riskAmount;
  late final String? riskPercent;
  late final String? stopLossPrice;
  late final String? stopLossPips;
  late final String? entryPrice;

  // FIXME: Move to a abstract class
  String get formattedFinancialInstrument {
    if (base == null || counter == null) return '';

    return formatCurrencyPair(
      counter: counter!,
      delimiter: '/',
      base: base!,
    );
  }

  // FIXME: Move to a abstract class
  MatexFinancialInstrument? get financialInstrument {
    if (base == null || counter == null) return null;

    return MatexFinancialInstrument(
      base: base!,
      counter: counter!,
    );
  }

  MatexForexPositionSizeCalculatorBlocFields({
    String? accountCurrency,
    String? base,
    String? counter,
    String? pipDecimalPlaces,
    String? riskFieldType,
    String? stopLossFieldType,
    String? accountSize,
    String? riskAmount,
    String? riskPercent,
    String? stopLossPrice,
    String? stopLossPips,
    FastCalculatorBlocDelegate? delegate,
    String? entryPrice,
  }) {
    this.accountCurrency = assignValue(accountCurrency);
    this.base = assignValue(base);
    this.counter = assignValue(counter);
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces);
    this.accountSize = assignValue(accountSize);
    this.riskAmount = assignValue(riskAmount);
    this.riskPercent = assignValue(riskPercent);
    this.stopLossPrice = assignValue(stopLossPrice);
    this.stopLossPips = assignValue(stopLossPips);
    this.entryPrice = assignValue(entryPrice);
    this.delegate = delegate;

    this.stopLossFieldType = stopLossFieldType ?? _kDefaultStopLossFieldType;
    this.riskFieldType = riskFieldType ?? _kDefaultRiskFieldType;
  }

  @override
  MatexForexPositionSizeCalculatorBlocFields clone() => copyWith();

  @override
  MatexForexPositionSizeCalculatorBlocFields copyWith({
    String? accountCurrency,
    String? base,
    String? counter,
    String? pipDecimalPlaces,
    String? riskFieldType,
    String? stopLossFieldType,
    String? accountSize,
    String? riskAmount,
    String? riskPercent,
    String? stopLossPrice,
    String? stopLossPips,
    String? entryPrice,
    FastCalculatorBlocDelegate? delegate,
  }) {
    return MatexForexPositionSizeCalculatorBlocFields(
      accountCurrency: accountCurrency ?? this.accountCurrency,
      base: base ?? this.base,
      counter: counter ?? this.counter,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      riskFieldType: riskFieldType ?? this.riskFieldType,
      stopLossFieldType: stopLossFieldType ?? this.stopLossFieldType,
      accountSize: accountSize ?? this.accountSize,
      riskAmount: riskAmount ?? this.riskAmount,
      riskPercent: riskPercent ?? this.riskPercent,
      stopLossPrice: stopLossPrice ?? this.stopLossPrice,
      stopLossPips: stopLossPips ?? this.stopLossPips,
      delegate: delegate ?? this.delegate,
      entryPrice: entryPrice ?? this.entryPrice,
    );
  }

  @override
  MatexForexPositionSizeCalculatorBlocFields copyWithDefaults({
    bool accountCurrency = false,
    bool base = false,
    bool counter = false,
    bool pipDecimalPlaces = false,
    bool riskFieldType = false,
    bool stopLossFieldType = false,
    bool accountSize = false,
    bool riskAmount = false,
    bool riskPercent = false,
    bool stopLossPrice = false,
    bool stopLossPips = false,
    bool entryPrice = false,
  }) {
    return MatexForexPositionSizeCalculatorBlocFields(
      accountCurrency: accountCurrency ? null : this.accountCurrency,
      base: base ? null : this.base,
      counter: counter ? null : this.counter,
      pipDecimalPlaces: pipDecimalPlaces
          ? kDefaultPipPipDecimalPlaces.toString()
          : this.pipDecimalPlaces,
      riskFieldType: riskFieldType ? null : this.riskFieldType,
      stopLossFieldType: stopLossFieldType ? null : this.stopLossFieldType,
      accountSize: accountSize ? null : this.accountSize,
      riskAmount: riskAmount ? null : this.riskAmount,
      riskPercent: riskPercent ? null : this.riskPercent,
      stopLossPrice: stopLossPrice ? null : this.stopLossPrice,
      stopLossPips: stopLossPips ? null : this.stopLossPips,
      entryPrice: entryPrice ? null : this.entryPrice,
    );
  }

  @override
  MatexForexPositionSizeCalculatorBlocFields merge(
    covariant MatexForexPositionSizeCalculatorBlocFields model,
  ) {
    return copyWith(
      accountCurrency: model.accountCurrency,
      base: model.base,
      counter: model.counter,
      pipDecimalPlaces: model.pipDecimalPlaces,
      riskFieldType: model.riskFieldType,
      stopLossFieldType: model.stopLossFieldType,
      accountSize: model.accountSize,
      riskAmount: model.riskAmount,
      riskPercent: model.riskPercent,
      stopLossPrice: model.stopLossPrice,
      stopLossPips: model.stopLossPips,
      delegate: model.delegate,
      entryPrice: model.entryPrice,
    );
  }

  @override
  List<Object?> get props => [
        accountCurrency,
        base,
        counter,
        pipDecimalPlaces,
        riskFieldType,
        stopLossFieldType,
        accountSize,
        riskAmount,
        riskPercent,
        stopLossPrice,
        stopLossPips,
        delegate,
        entryPrice,
      ];
}
