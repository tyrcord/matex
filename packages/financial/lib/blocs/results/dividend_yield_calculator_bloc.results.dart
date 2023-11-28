// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexDividendYieldCalculatorBlocResults extends FastCalculatorResults {
  final double? dividendYield;
  final double? totalDividends;
  final double? sharePrice;
  final String? formattedDividendYield;
  final String? formattedTotalDividends;
  final String? formattedSharePrice;

  const MatexDividendYieldCalculatorBlocResults({
    this.dividendYield,
    this.totalDividends,
    this.sharePrice,
    this.formattedDividendYield,
    this.formattedTotalDividends,
    this.formattedSharePrice,
  });

  @override
  MatexDividendYieldCalculatorBlocResults clone() => copyWith();

  @override
  MatexDividendYieldCalculatorBlocResults copyWith({
    double? dividendYield,
    double? totalDividends,
    double? sharePrice,
    String? formattedDividendYield,
    String? formattedTotalDividends,
    String? formattedSharePrice,
  }) {
    return MatexDividendYieldCalculatorBlocResults(
      dividendYield: dividendYield ?? this.dividendYield,
      totalDividends: totalDividends ?? this.totalDividends,
      sharePrice: sharePrice ?? this.sharePrice,
      formattedDividendYield:
          formattedDividendYield ?? this.formattedDividendYield,
      formattedTotalDividends:
          formattedTotalDividends ?? this.formattedTotalDividends,
      formattedSharePrice: formattedSharePrice ?? this.formattedSharePrice,
    );
  }

  @override
  MatexDividendYieldCalculatorBlocResults merge(
    covariant MatexDividendYieldCalculatorBlocResults model,
  ) {
    return copyWith(
      dividendYield: model.dividendYield,
      totalDividends: model.totalDividends,
      sharePrice: model.sharePrice,
      formattedDividendYield: model.formattedDividendYield,
      formattedTotalDividends: model.formattedTotalDividends,
      formattedSharePrice: model.formattedSharePrice,
    );
  }

  @override
  List<Object?> get props => [
        dividendYield,
        totalDividends,
        sharePrice,
        formattedDividendYield,
        formattedTotalDividends,
        formattedSharePrice,
      ];
}
