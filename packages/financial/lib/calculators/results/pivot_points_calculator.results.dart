// Package imports:
import 'package:tmodel/tmodel.dart';

class MatexPivotPointsCalculatorResults extends TModel {
  final List<double> resistances;
  final List<double> supports;
  final double? pivotPoint;

  const MatexPivotPointsCalculatorResults({
    this.resistances = const [],
    this.supports = const [],
    this.pivotPoint,
  });

  @override
  MatexPivotPointsCalculatorResults clone() => copyWith();

  @override
  MatexPivotPointsCalculatorResults copyWith({
    List<double>? resistances,
    List<double>? supports,
    double? pivotPoint,
  }) {
    return MatexPivotPointsCalculatorResults(
      resistances: resistances ?? this.resistances,
      supports: supports ?? this.supports,
      pivotPoint: pivotPoint ?? this.pivotPoint,
    );
  }

  @override
  MatexPivotPointsCalculatorResults merge(
    covariant MatexPivotPointsCalculatorResults model,
  ) {
    return copyWith(
      resistances: model.resistances,
      supports: model.supports,
      pivotPoint: model.pivotPoint,
    );
  }

  @override
  List<Object?> get props => [
        resistances,
        supports,
        pivotPoint,
      ];
}
