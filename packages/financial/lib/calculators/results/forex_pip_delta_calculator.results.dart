// Package imports:
import 'package:tmodel/tmodel.dart';

class MatexForexPipDeltaCalculatorResults extends TModel {
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
