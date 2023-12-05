import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexForexPipDeltaCalculatorBlocResults extends FastCalculatorResults {
  final double? numberOfPips;

  final String? formattedNumberOfPips;

  const MatexForexPipDeltaCalculatorBlocResults({
    this.formattedNumberOfPips,
    this.numberOfPips,
  });

  @override
  MatexForexPipDeltaCalculatorBlocResults clone() => copyWith();

  @override
  MatexForexPipDeltaCalculatorBlocResults copyWith({
    String? formattedNumberOfPips,
    double? numberOfPips,
  }) {
    return MatexForexPipDeltaCalculatorBlocResults(
      formattedNumberOfPips:
          formattedNumberOfPips ?? this.formattedNumberOfPips,
      numberOfPips: numberOfPips ?? this.numberOfPips,
    );
  }

  @override
  MatexForexPipDeltaCalculatorBlocResults merge(
      covariant MatexForexPipDeltaCalculatorBlocResults model) {
    return copyWith(
      formattedNumberOfPips: model.formattedNumberOfPips,
      numberOfPips: model.numberOfPips,
    );
  }

  @override
  List<Object?> get props => [
        formattedNumberOfPips,
        numberOfPips,
      ];
}
