// Package imports:
import 'package:matex_core/core.dart';

class MatexForexPositionSizeCalculatorResults extends MatexCalculatorState {
  final double? pipValue;

  const MatexForexPositionSizeCalculatorResults({this.pipValue});

  @override
  MatexForexPositionSizeCalculatorResults clone() => copyWith();

  @override
  MatexForexPositionSizeCalculatorResults copyWith({
    double? pipValue,
  }) {
    return MatexForexPositionSizeCalculatorResults(
      pipValue: pipValue ?? this.pipValue,
    );
  }

  @override
  MatexForexPositionSizeCalculatorResults merge(
    covariant MatexForexPositionSizeCalculatorResults model,
  ) {
    return copyWith(pipValue: model.pipValue);
  }

  @override
  List<Object?> get props => [pipValue];
}
