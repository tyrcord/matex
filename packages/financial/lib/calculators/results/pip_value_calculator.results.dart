import 'package:matex_core/core.dart';

class MatexPipValueCalculatorResults extends MatexCalculatorState {
  final double? pipValue;

  const MatexPipValueCalculatorResults({this.pipValue});

  @override
  MatexPipValueCalculatorResults clone() => copyWith();

  @override
  MatexPipValueCalculatorResults copyWith({
    double? pipValue,
  }) {
    return MatexPipValueCalculatorResults(pipValue: pipValue ?? this.pipValue);
  }

  @override
  MatexPipValueCalculatorResults merge(
    covariant MatexPipValueCalculatorResults model,
  ) {
    return copyWith(pipValue: model.pipValue);
  }

  @override
  List<Object?> get props => [pipValue];
}
