// Package imports:
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexForexPipDeltaCalculatorState extends MatexCalculatorState {
  final int pipDecimalPlaces;
  final double? priceA;
  final double? priceB;

  const MatexForexPipDeltaCalculatorState({
    int? pipDecimalPlaces = kDefaultPipPipDecimalPlaces,
    this.priceA,
    this.priceB,
  }) : pipDecimalPlaces = pipDecimalPlaces ?? kDefaultPipPipDecimalPlaces;

  @override
  MatexForexPipDeltaCalculatorState clone() => copyWith();

  @override
  MatexForexPipDeltaCalculatorState copyWithDefaults({
    bool resetPipDecimalPlaces = false,
    bool resetPriceA = false,
    bool resetPriceB = false,
  }) {
    return MatexForexPipDeltaCalculatorState(
      pipDecimalPlaces: resetPipDecimalPlaces ? null : pipDecimalPlaces,
      priceA: resetPriceA ? null : priceA,
      priceB: resetPriceB ? null : priceB,
    );
  }

  @override
  MatexForexPipDeltaCalculatorState copyWith({
    double? priceA,
    double? priceB,
    int? pipDecimalPlaces,
  }) {
    return MatexForexPipDeltaCalculatorState(
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      priceA: priceA ?? this.priceA,
      priceB: priceB ?? this.priceB,
    );
  }

  @override
  MatexForexPipDeltaCalculatorState merge(
    covariant MatexForexPipDeltaCalculatorState model,
  ) {
    return copyWith(
      pipDecimalPlaces: model.pipDecimalPlaces,
      priceA: model.priceA,
      priceB: model.priceB,
    );
  }

  @override
  List<Object?> get props => [priceA, priceB, pipDecimalPlaces];
}
