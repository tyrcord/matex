// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexDividendYieldCalculatorBlocResults extends FastCalculatorResults {
  final double? dividendYield;

  final String? formattedDividendYield;

  const MatexDividendYieldCalculatorBlocResults({
    this.dividendYield,
    this.formattedDividendYield,
  });

  @override
  MatexDividendYieldCalculatorBlocResults clone() => copyWith();

  @override
  MatexDividendYieldCalculatorBlocResults copyWith({
    double? dividendYield,
    String? formattedDividendYield,
  }) {
    return MatexDividendYieldCalculatorBlocResults(
      dividendYield: dividendYield ?? this.dividendYield,
      formattedDividendYield:
          formattedDividendYield ?? this.formattedDividendYield,
    );
  }

  @override
  MatexDividendYieldCalculatorBlocResults merge(
    covariant MatexDividendYieldCalculatorBlocResults model,
  ) {
    return copyWith(
      dividendYield: model.dividendYield,
      formattedDividendYield: model.formattedDividendYield,
    );
  }

  @override
  List<Object?> get props => [dividendYield, formattedDividendYield];
}
