// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexPivotPointsCalculatorBlocResults extends FastCalculatorResults {
  final List<String>? formattedResistances;
  final List<String>? formattedSupports;
  final List<double>? resistances;
  final List<double>? supports;

  final double? pivotPoint;
  final String? formattedPivotPoint;

  const MatexPivotPointsCalculatorBlocResults({
    this.formattedResistances,
    this.formattedSupports,
    this.pivotPoint,
    this.formattedPivotPoint,
    this.resistances,
    this.supports,
  });

  @override
  MatexPivotPointsCalculatorBlocResults clone() => copyWith();

  @override
  MatexPivotPointsCalculatorBlocResults copyWith({
    List<String>? formattedResistances,
    List<String>? formattedSupports,
    List<double>? resistances,
    List<double>? supports,
    double? pivotPoint,
    String? formattedPivotPoint,
  }) {
    return MatexPivotPointsCalculatorBlocResults(
      formattedResistances: formattedResistances ?? this.formattedResistances,
      formattedSupports: formattedSupports ?? this.formattedSupports,
      pivotPoint: pivotPoint ?? this.pivotPoint,
      formattedPivotPoint: formattedPivotPoint ?? this.formattedPivotPoint,
      resistances: resistances ?? this.resistances,
      supports: supports ?? this.supports,
    );
  }

  @override
  MatexPivotPointsCalculatorBlocResults merge(
    covariant MatexPivotPointsCalculatorBlocResults model,
  ) {
    return copyWith(
      formattedResistances: model.formattedResistances,
      formattedSupports: model.formattedSupports,
      pivotPoint: model.pivotPoint,
      formattedPivotPoint: model.formattedPivotPoint,
      resistances: model.resistances,
      supports: model.supports,
    );
  }

  @override
  List<Object?> get props => [
        formattedResistances,
        formattedSupports,
        pivotPoint,
        formattedPivotPoint,
        resistances,
        supports,
      ];
}
