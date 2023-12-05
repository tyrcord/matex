// Package imports:
import 'package:matex_core/core.dart';

class MatexForexPipValueCalculatorResults extends MatexCalculatorState {
  final double? pipValue;

  const MatexForexPipValueCalculatorResults({this.pipValue});

  @override
  MatexForexPipValueCalculatorResults clone() => copyWith();

  @override
  MatexForexPipValueCalculatorResults copyWith({
    double? pipValue,
  }) {
    return MatexForexPipValueCalculatorResults(
      pipValue: pipValue ?? this.pipValue,
    );
  }

  @override
  MatexForexPipValueCalculatorResults merge(
    covariant MatexForexPipValueCalculatorResults model,
  ) {
    return copyWith(pipValue: model.pipValue);
  }

  @override
  List<Object?> get props => [pipValue];
}
