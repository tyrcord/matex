// Package imports:
import 'package:tmodel/tmodel.dart';

class MatexDividendPayoutRatioCalculatorResults extends TModel {
  // Define Properties
  final double? dividendPayoutRatio;

  // Constructor
  const MatexDividendPayoutRatioCalculatorResults({
    this.dividendPayoutRatio,
  });

  // Clone Method
  @override
  MatexDividendPayoutRatioCalculatorResults clone() => copyWith();

  // From JSON Factory
  factory MatexDividendPayoutRatioCalculatorResults.fromJson(
      Map<String, dynamic> json) {
    return MatexDividendPayoutRatioCalculatorResults(
      dividendPayoutRatio: json['dividendPayoutRatio'] as double?,
    );
  }

  // Copy With Method
  @override
  MatexDividendPayoutRatioCalculatorResults copyWith({
    double? dividendPayoutRatio,
  }) {
    return MatexDividendPayoutRatioCalculatorResults(
      dividendPayoutRatio: dividendPayoutRatio ?? this.dividendPayoutRatio,
    );
  }

  // Copy With Defaults Method
  @override
  MatexDividendPayoutRatioCalculatorResults copyWithDefaults({
    bool resetDividendPayoutRatio = false,
  }) {
    return MatexDividendPayoutRatioCalculatorResults(
      dividendPayoutRatio:
          resetDividendPayoutRatio ? null : dividendPayoutRatio,
    );
  }

  // Merge Method
  @override
  MatexDividendPayoutRatioCalculatorResults merge(
      covariant MatexDividendPayoutRatioCalculatorResults model) {
    return copyWith(
      dividendPayoutRatio: model.dividendPayoutRatio,
    );
  }

  // Props Getter
  @override
  List<Object?> get props => [dividendPayoutRatio];

  // To JSON Method
  Map<String, dynamic> toJson() {
    return {
      'dividendPayoutRatio': dividendPayoutRatio,
    };
  }
}
