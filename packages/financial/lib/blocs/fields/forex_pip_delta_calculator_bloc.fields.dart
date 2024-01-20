// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexPipDeltaCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin
    implements MatexFinancialInstrumentCalculatorBlocFields {
  @override
  late final String? base;
  @override
  late final String? counter;

  late final String? pipDecimalPlaces;
  late final String? priceA;
  late final String? priceB;

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

  String get formattedFinancialInstrument {
    if (base == null || counter == null) return '';

    return financialInstrument?.formattedSymbol ?? '';
  }

  MatexFinancialInstrument? get financialInstrument {
    if (base == null || counter == null) return null;

    return MatexFinancialInstrument(counter: counter!, base: base!);
  }

  MatexForexPipDeltaCalculatorBlocFields({
    FastCalculatorBlocDelegate? delegate,
    String? pipDecimalPlaces,
    String? counter,
    String? priceA,
    String? priceB,
    String? base,
  }) {
    this.counter = assignValue(counter);
    this.priceA = assignValue(priceA);
    this.priceB = assignValue(priceB);
    this.base = assignValue(base);
    this.delegate = delegate;
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces) ??
        kMatexDefaultPipDecimalPlaces.toString();
  }

  @override
  MatexForexPipDeltaCalculatorBlocFields clone() => copyWith();

  @override
  MatexForexPipDeltaCalculatorBlocFields copyWithDefaults({
    bool resetPipDecimalPlaces = false,
    bool resetCounter = false,
    bool resetPriceA = false,
    bool resetPriceB = false,
    bool resetBase = false,
  }) {
    return MatexForexPipDeltaCalculatorBlocFields(
      pipDecimalPlaces: resetPipDecimalPlaces ? null : pipDecimalPlaces,
      counter: resetCounter ? null : counter,
      priceA: resetPriceA ? null : priceA,
      priceB: resetPriceB ? null : priceB,
      base: resetBase ? null : base,
      delegate: delegate,
    );
  }

  @override
  MatexForexPipDeltaCalculatorBlocFields copyWith({
    FastCalculatorBlocDelegate? delegate,
    String? pipDecimalPlaces,
    String? priceA,
    String? priceB,
    String? counter,
    String? base,
  }) {
    return MatexForexPipDeltaCalculatorBlocFields(
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      delegate: delegate ?? this.delegate,
      counter: counter ?? this.counter,
      priceA: priceA ?? this.priceA,
      priceB: priceB ?? this.priceB,
      base: base ?? this.base,
    );
  }

  @override
  MatexForexPipDeltaCalculatorBlocFields merge(
    covariant MatexForexPipDeltaCalculatorBlocFields model,
  ) {
    return copyWith(
      pipDecimalPlaces: model.pipDecimalPlaces,
      delegate: model.delegate,
      counter: model.counter,
      priceA: model.priceA,
      priceB: model.priceB,
      base: model.base,
    );
  }

  @override
  List<Object?> get props => [
        pipDecimalPlaces,
        counter,
        priceA,
        priceB,
        base,
      ];
}
