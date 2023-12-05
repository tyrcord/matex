// Package imports:
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexForexPipDeltaCalculatorState extends MatexCalculatorState {
  final double? priceA;
  final double? priceB;
  final int pipDecimalPlaces;

  const MatexForexPipDeltaCalculatorState({
    this.pipDecimalPlaces = kDefaultPipPipDecimalPlaces,
    this.priceA,
    this.priceB,
  });

  @override
  MatexForexPipDeltaCalculatorState clone() => copyWith();

  @override
  MatexForexPipDeltaCalculatorState copyWithDefaults({
    bool resetPriceA = false,
    bool resetBase = false,
    bool resetCounter = false,
    bool resetPriceB = false,
    bool resetPipDecimalPlaces = false,
  }) {
    return MatexForexPipDeltaCalculatorState(
      priceA: resetPriceA ? null : priceA,
      priceB: resetPriceB ? null : priceB,
      pipDecimalPlaces: resetPipDecimalPlaces
          ? kDefaultPipPipDecimalPlaces
          : pipDecimalPlaces,
    );
  }

  @override
  MatexForexPipDeltaCalculatorState copyWith({
    double? priceA,
    double? base,
    double? counter,
    double? priceB,
    int? pipDecimalPlaces,
  }) {
    return MatexForexPipDeltaCalculatorState(
      priceA: priceA ?? this.priceA,
      priceB: priceB ?? this.priceB,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
    );
  }

  @override
  MatexForexPipDeltaCalculatorState merge(
    covariant MatexForexPipDeltaCalculatorState model,
  ) {
    return copyWith(
      priceA: model.priceA,
      priceB: model.priceB,
      pipDecimalPlaces: model.pipDecimalPlaces,
    );
  }

  @override
  List<Object?> get props => [
        priceA,
        priceB,
        pipDecimalPlaces,
      ];
}
