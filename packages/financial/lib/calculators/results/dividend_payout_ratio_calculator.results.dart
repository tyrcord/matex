import 'package:tmodel/tmodel.dart';

class DividendPayoutRatioCalculatorResults extends TModel {
  // Define Properties
  final double? dividendPayoutRatio;

  // Constructor
  const DividendPayoutRatioCalculatorResults({
    this.dividendPayoutRatio,
  });

  // Clone Method
  @override
  DividendPayoutRatioCalculatorResults clone() => copyWith();

  // From JSON Factory
  factory DividendPayoutRatioCalculatorResults.fromJson(
      Map<String, dynamic> json) {
    return DividendPayoutRatioCalculatorResults(
      dividendPayoutRatio: json['dividendPayoutRatio'] as double?,
    );
  }

  // Copy With Method
  @override
  DividendPayoutRatioCalculatorResults copyWith({
    double? dividendPayoutRatio,
  }) {
    return DividendPayoutRatioCalculatorResults(
      dividendPayoutRatio: dividendPayoutRatio ?? this.dividendPayoutRatio,
    );
  }

  // Copy With Defaults Method
  @override
  DividendPayoutRatioCalculatorResults copyWithDefaults({
    bool resetDividendPayoutRatio = false,
  }) {
    return DividendPayoutRatioCalculatorResults(
      dividendPayoutRatio:
          resetDividendPayoutRatio ? null : dividendPayoutRatio,
    );
  }

  // Merge Method
  @override
  DividendPayoutRatioCalculatorResults merge(
      covariant DividendPayoutRatioCalculatorResults model) {
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
