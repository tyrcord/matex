// Package imports:
import 'package:tmodel/tmodel.dart';

class MatexForexPipValueCalculatorResults extends TModel {
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
