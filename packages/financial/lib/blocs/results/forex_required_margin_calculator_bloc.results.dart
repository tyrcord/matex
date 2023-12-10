import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexForexRequiredMarginCalculatorBlocResults
    extends FastCalculatorResults {
  final double? requiredMargin;

  final String? formattedRequiredMargin;

  const MatexForexRequiredMarginCalculatorBlocResults({
    this.formattedRequiredMargin,
    this.requiredMargin,
  });

  @override
  MatexForexRequiredMarginCalculatorBlocResults clone() => copyWith();

  @override
  MatexForexRequiredMarginCalculatorBlocResults copyWith({
    String? formattedRequiredMargin,
    double? requiredMargin,
  }) {
    return MatexForexRequiredMarginCalculatorBlocResults(
      formattedRequiredMargin:
          formattedRequiredMargin ?? this.formattedRequiredMargin,
      requiredMargin: requiredMargin ?? this.requiredMargin,
    );
  }

  @override
  MatexForexRequiredMarginCalculatorBlocResults merge(
      covariant MatexForexRequiredMarginCalculatorBlocResults model) {
    return copyWith(
      formattedRequiredMargin: model.formattedRequiredMargin,
      requiredMargin: model.requiredMargin,
    );
  }

  @override
  List<Object?> get props => [
        formattedRequiredMargin,
        requiredMargin,
      ];
}
