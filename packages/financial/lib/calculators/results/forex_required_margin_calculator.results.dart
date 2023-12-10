// Package imports:
import 'package:tmodel/tmodel.dart';

class MatexForexRequiredMarginCalculatorResults extends TModel {
  final double? requiredMargin;

  const MatexForexRequiredMarginCalculatorResults({
    this.requiredMargin,
  });

  @override
  MatexForexRequiredMarginCalculatorResults clone() => copyWith();

  @override
  MatexForexRequiredMarginCalculatorResults copyWith({
    double? requiredMargin,
  }) {
    return MatexForexRequiredMarginCalculatorResults(
      requiredMargin: requiredMargin ?? this.requiredMargin,
    );
  }

  @override
  MatexForexRequiredMarginCalculatorResults merge(
    covariant MatexForexRequiredMarginCalculatorResults model,
  ) {
    return copyWith(requiredMargin: model.requiredMargin);
  }

  @override
  List<Object?> get props => [requiredMargin];
}
