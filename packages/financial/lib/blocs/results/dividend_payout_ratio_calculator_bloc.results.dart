// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexDividendPayoutRatioCalculatorBlocResults
    extends FastCalculatorResults {
  final double? dividendPayoutRatio;
  final String? formattedDividendPayoutRatio;
  final String? dividendPayoutLevel;

  const MatexDividendPayoutRatioCalculatorBlocResults({
    this.dividendPayoutRatio,
    this.formattedDividendPayoutRatio,
    this.dividendPayoutLevel,
  });

  @override
  MatexDividendPayoutRatioCalculatorBlocResults clone() => copyWith();

  @override
  MatexDividendPayoutRatioCalculatorBlocResults copyWith({
    double? dividendPayoutRatio,
    String? formattedDividendPayoutRatio,
    String? dividendPayoutLevel,
  }) {
    return MatexDividendPayoutRatioCalculatorBlocResults(
      dividendPayoutRatio: dividendPayoutRatio ?? this.dividendPayoutRatio,
      formattedDividendPayoutRatio:
          formattedDividendPayoutRatio ?? this.formattedDividendPayoutRatio,
      dividendPayoutLevel: dividendPayoutLevel ?? this.dividendPayoutLevel,
    );
  }

  @override
  MatexDividendPayoutRatioCalculatorBlocResults merge(
    covariant MatexDividendPayoutRatioCalculatorBlocResults model,
  ) {
    return copyWith(
      dividendPayoutRatio: model.dividendPayoutRatio,
      formattedDividendPayoutRatio: model.formattedDividendPayoutRatio,
      dividendPayoutLevel: model.dividendPayoutLevel,
    );
  }

  @override
  List<Object?> get props => [
        dividendPayoutRatio,
        formattedDividendPayoutRatio,
        dividendPayoutLevel,
      ];
}
