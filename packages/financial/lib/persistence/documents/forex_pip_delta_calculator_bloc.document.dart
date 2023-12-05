// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexForexPipDeltaCalculatorDocument extends FastCalculatorDocument {
  late final String? base;
  late final String? counter;

  late final String? priceA;
  late final String? priceB;
  late final String? pipDecimalPlaces;

  MatexForexPipDeltaCalculatorDocument({
    String? base,
    String? counter,
    String? priceA,
    String? priceB,
    String? pipDecimalPlaces,
  }) {
    this.base = assignValue(base);
    this.counter = assignValue(counter);
    this.priceA = assignValue(priceA);
    this.priceB = assignValue(priceB);
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces);
  }

  @override
  MatexForexPipDeltaCalculatorDocument clone() => copyWith();

  @override
  MatexForexPipDeltaCalculatorDocument copyWithDefaults({
    bool resetPriceA = false,
    bool resetBase = false,
    bool resetCounter = false,
    bool resetPriceB = false,
    bool resetPipDecimalPlaces = false,
  }) {
    return MatexForexPipDeltaCalculatorDocument(
      priceA: resetPriceA ? null : priceA,
      base: resetBase ? null : base,
      counter: resetCounter ? null : counter,
      priceB: resetPriceB ? null : priceB,
      pipDecimalPlaces: resetPipDecimalPlaces
          ? kDefaultPipPipDecimalPlaces.toString()
          : pipDecimalPlaces,
    );
  }

  @override
  MatexForexPipDeltaCalculatorDocument copyWith({
    String? priceA,
    String? base,
    String? counter,
    String? priceB,
    String? pipDecimalPlaces,
  }) {
    return MatexForexPipDeltaCalculatorDocument(
      priceA: priceA ?? this.priceA,
      base: base ?? this.base,
      counter: counter ?? this.counter,
      priceB: priceB ?? this.priceB,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
    );
  }

  @override
  MatexForexPipDeltaCalculatorDocument merge(
    covariant MatexForexPipDeltaCalculatorDocument model,
  ) {
    return copyWith(
      priceA: model.priceA,
      base: model.base,
      counter: model.counter,
      priceB: model.priceB,
      pipDecimalPlaces: model.pipDecimalPlaces,
    );
  }

  @override
  MatexForexPipDeltaCalculatorBlocFields toFields() {
    return MatexForexPipDeltaCalculatorBlocFields(
      priceA: priceA,
      base: base,
      counter: counter,
      priceB: priceB,
      pipDecimalPlaces: pipDecimalPlaces,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'base': base,
      'counter': counter,
      'priceA': priceA,
      'priceB': priceB,
      'pipDecimalPlaces': pipDecimalPlaces,
      ...super.toJson(),
    };
  }

  static MatexForexPipDeltaCalculatorDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexForexPipDeltaCalculatorDocument(
      base: json['base'] as String?,
      counter: json['counter'] as String?,
      priceA: json['priceA'] as String?,
      priceB: json['priceB'] as String?,
      pipDecimalPlaces: json['pipDecimalPlaces'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        priceA,
        base,
        counter,
        priceB,
        pipDecimalPlaces,
      ];
}
