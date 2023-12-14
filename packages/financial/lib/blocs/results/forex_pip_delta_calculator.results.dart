import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexForexPipDeltaCalculatorBlocResults extends FastCalculatorResults {
  final String? formattedNumberOfPips;
  final double? numberOfPips;

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
      numberOfPips: numberOfPips ?? this.numberOfPips,
      formattedNumberOfPips:
          formattedNumberOfPips ?? this.formattedNumberOfPips,
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
  List<Object?> get props => [formattedNumberOfPips, numberOfPips];
}
