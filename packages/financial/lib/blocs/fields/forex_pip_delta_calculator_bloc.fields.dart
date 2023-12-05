// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

class MatexForexPipDeltaCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin
    implements MatexFinancialInstrumentCalculatorBlocFields {
  @override
  late final String? base;
  @override
  late final String? counter;

  late final String? priceA;
  late final String? priceB;
  late final String? pipDecimalPlaces;

  String get formattedPriceA {
    final pipDecimalPlacesValue = parseFieldValueToDouble(pipDecimalPlaces);
    final value = parseFieldValueToDouble(priceA);

    return localizeCurrency(
      minimumFractionDigits: pipDecimalPlacesValue.toInt(),
      maximumFractionDigits: kMatexQuoteMaxFractionDigits,
      value: value,
    );
  }

  String get formattedPriceB {
    final pipDecimalPlacesValue = parseFieldValueToDouble(pipDecimalPlaces);
    final value = parseFieldValueToDouble(priceB);

    return localizeCurrency(
      minimumFractionDigits: pipDecimalPlacesValue.toInt(),
      maximumFractionDigits: kMatexQuoteMaxFractionDigits,
      value: value,
    );
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

  MatexForexPipDeltaCalculatorBlocFields({
    String? base,
    String? counter,
    String? priceA,
    String? priceB,
    String? pipDecimalPlaces,
    FastCalculatorBlocDelegate? delegate,
  }) {
    this.base = assignValue(base);
    this.counter = assignValue(counter);
    this.priceA = assignValue(priceA);
    this.priceB = assignValue(priceB);
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces);
    this.delegate = delegate;
  }

  @override
  MatexForexPipDeltaCalculatorBlocFields clone() => copyWith();

  @override
  MatexForexPipDeltaCalculatorBlocFields copyWithDefaults({
    bool resetPriceA = false,
    bool resetBase = false,
    bool resetCounter = false,
    bool resetPriceB = false,
    bool resetPipDecimalPlaces = false,
  }) {
    return MatexForexPipDeltaCalculatorBlocFields(
      priceA: resetPriceA ? null : priceA,
      base: resetBase ? null : base,
      counter: resetCounter ? null : counter,
      priceB: resetPriceB ? null : priceB,
      pipDecimalPlaces: resetPipDecimalPlaces
          ? kDefaultPipPipDecimalPlaces.toString()
          : pipDecimalPlaces,
      delegate: delegate,
    );
  }

  @override
  MatexForexPipDeltaCalculatorBlocFields copyWith({
    String? priceA,
    String? base,
    String? counter,
    String? priceB,
    String? pipDecimalPlaces,
    FastCalculatorBlocDelegate? delegate,
  }) {
    return MatexForexPipDeltaCalculatorBlocFields(
      priceA: priceA ?? this.priceA,
      base: base ?? this.base,
      counter: counter ?? this.counter,
      priceB: priceB ?? this.priceB,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      delegate: delegate ?? this.delegate,
    );
  }

  @override
  MatexForexPipDeltaCalculatorBlocFields merge(
    covariant MatexForexPipDeltaCalculatorBlocFields model,
  ) {
    return copyWith(
      priceA: model.priceA,
      base: model.base,
      counter: model.counter,
      priceB: model.priceB,
      pipDecimalPlaces: model.pipDecimalPlaces,
      delegate: model.delegate,
    );
  }

  @override
  List<Object?> get props => [
        priceA,
        base,
        counter,
        priceB,
        pipDecimalPlaces,
        delegate,
      ];
}
