// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexPipDeltaCalculatorDocument extends FastCalculatorDocument {
  late final String? pipDecimalPlaces;
  late final String? counter;
  late final String? priceA;
  late final String? priceB;
  late final String? base;

  MatexForexPipDeltaCalculatorDocument({
    String? pipDecimalPlaces,
    String? counter,
    String? priceA,
    String? priceB,
    String? base,
  }) {
    this.base = assignValue(base);
    this.counter = assignValue(counter);
    this.priceA = assignValue(priceA);
    this.priceB = assignValue(priceB);
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces) ??
        kMatexDefaultPipDecimalPlaces.toString();
  }

  @override
  MatexForexPipDeltaCalculatorDocument clone() => copyWith();

  @override
  MatexForexPipDeltaCalculatorDocument copyWith({
    String? pipDecimalPlaces,
    String? counter,
    String? priceA,
    String? priceB,
    String? base,
  }) {
    return MatexForexPipDeltaCalculatorDocument(
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      counter: counter ?? this.counter,
      priceA: priceA ?? this.priceA,
      priceB: priceB ?? this.priceB,
      base: base ?? this.base,
    );
  }

  @override
  MatexForexPipDeltaCalculatorDocument copyWithDefaults({
    bool resetPipDecimalPlaces = false,
    bool resetCounter = false,
    bool resetPriceA = false,
    bool resetPriceB = false,
    bool resetBase = false,
  }) {
    return MatexForexPipDeltaCalculatorDocument(
      pipDecimalPlaces: resetPipDecimalPlaces ? null : pipDecimalPlaces,
      counter: resetCounter ? null : counter,
      priceA: resetPriceA ? null : priceA,
      priceB: resetPriceB ? null : priceB,
      base: resetBase ? null : base,
    );
  }

  @override
  MatexForexPipDeltaCalculatorDocument merge(
    covariant MatexForexPipDeltaCalculatorDocument model,
  ) {
    return copyWith(
      pipDecimalPlaces: model.pipDecimalPlaces,
      counter: model.counter,
      priceA: model.priceA,
      priceB: model.priceB,
      base: model.base,
    );
  }

  @override
  MatexForexPipDeltaCalculatorBlocFields toFields() {
    return MatexForexPipDeltaCalculatorBlocFields(
      pipDecimalPlaces: pipDecimalPlaces,
      counter: counter,
      priceA: priceA,
      priceB: priceB,
      base: base,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'pipDecimalPlaces': pipDecimalPlaces,
      'counter': counter,
      'priceA': priceA,
      'priceB': priceB,
      'base': base,
      ...super.toJson(),
    };
  }

  static MatexForexPipDeltaCalculatorDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexForexPipDeltaCalculatorDocument(
      pipDecimalPlaces: json['pipDecimalPlaces'] as String?,
      counter: json['counter'] as String?,
      priceA: json['priceA'] as String?,
      priceB: json['priceB'] as String?,
      base: json['base'] as String?,
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
