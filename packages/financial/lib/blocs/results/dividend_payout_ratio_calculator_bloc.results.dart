// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexDividendPayoutRatioCalculatorBlocResults
    extends FastCalculatorResults {
  final double? dividendPayoutRatio;
  final String? formattedDividendPayoutRatio;

  const MatexDividendPayoutRatioCalculatorBlocResults({
    this.dividendPayoutRatio,
    this.formattedDividendPayoutRatio,
  });

  @override
  MatexDividendPayoutRatioCalculatorBlocResults clone() => copyWith();

  @override
  MatexDividendPayoutRatioCalculatorBlocResults copyWith({
    double? dividendPayoutRatio,
    String? formattedDividendPayoutRatio,
  }) {
    return MatexDividendPayoutRatioCalculatorBlocResults(
      dividendPayoutRatio: dividendPayoutRatio ?? this.dividendPayoutRatio,
      formattedDividendPayoutRatio:
          formattedDividendPayoutRatio ?? this.formattedDividendPayoutRatio,
    );
  }

  @override
  MatexDividendPayoutRatioCalculatorBlocResults merge(
    covariant MatexDividendPayoutRatioCalculatorBlocResults model,
  ) {
    return copyWith(
      dividendPayoutRatio: model.dividendPayoutRatio,
      formattedDividendPayoutRatio: model.formattedDividendPayoutRatio,
    );
  }

  @override
  List<Object?> get props => [
        dividendPayoutRatio,
        formattedDividendPayoutRatio,
      ];
}
