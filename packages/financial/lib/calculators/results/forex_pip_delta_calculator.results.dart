// Package imports:
import 'package:matex_core/core.dart';

class MatexForexPipDeltaCalculatorResults extends MatexCalculatorState {
  final double? numberOfPips;

  const MatexForexPipDeltaCalculatorResults({this.numberOfPips});

  @override
  MatexForexPipDeltaCalculatorResults clone() => copyWith();

  @override
  MatexForexPipDeltaCalculatorResults copyWith({
    double? numberOfPips,
  }) {
    return MatexForexPipDeltaCalculatorResults(
      numberOfPips: numberOfPips ?? this.numberOfPips,
    );
  }

  @override
  MatexForexPipDeltaCalculatorResults merge(
    covariant MatexForexPipDeltaCalculatorResults model,
  ) {
    return copyWith(numberOfPips: model.numberOfPips);
  }

  @override
  List<Object?> get props => [numberOfPips];
}
