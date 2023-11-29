// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexDividendPayoutRatioCalculatorBlocResults
    extends FastCalculatorResults {
  final double? dividendRatioPayout;
  final String? formattedRatioPayout;

  const MatexDividendPayoutRatioCalculatorBlocResults({
    this.dividendRatioPayout,
    this.formattedRatioPayout,
  });

  @override
  MatexDividendPayoutRatioCalculatorBlocResults clone() => copyWith();

  @override
  MatexDividendPayoutRatioCalculatorBlocResults copyWith({
    double? dividendRatioPayout,
    String? formattedRatioPayout,
  }) {
    return MatexDividendPayoutRatioCalculatorBlocResults(
      dividendRatioPayout: dividendRatioPayout ?? this.dividendRatioPayout,
      formattedRatioPayout: formattedRatioPayout ?? this.formattedRatioPayout,
    );
  }

  @override
  MatexDividendPayoutRatioCalculatorBlocResults merge(
    covariant MatexDividendPayoutRatioCalculatorBlocResults model,
  ) {
    return copyWith(
      dividendRatioPayout: model.dividendRatioPayout,
      formattedRatioPayout: model.formattedRatioPayout,
    );
  }

  @override
  List<Object?> get props => [
        dividendRatioPayout,
        formattedRatioPayout,
      ];
}
