// Project imports:
import 'package:matex_core/core.dart';

class DividendPayoutRatioCalculatorState extends MatexCalculatorState {
  // Define Properties
  final double? netIncome;
  final double? totalDividend;

  // Constructor
  const DividendPayoutRatioCalculatorState({
    this.netIncome,
    this.totalDividend,
  });

  // Clone Method
  @override
  DividendPayoutRatioCalculatorState clone() => copyWith();

  // From JSON Factory
  factory DividendPayoutRatioCalculatorState.fromJson(
      Map<String, dynamic> json) {
    return DividendPayoutRatioCalculatorState(
      netIncome: json['netIncome'] as double?,
      totalDividend: json['totalDividend'] as double?,
    );
  }

  // Copy With Method
  @override
  DividendPayoutRatioCalculatorState copyWith({
    double? netIncome,
    double? totalDividends,
  }) {
    return DividendPayoutRatioCalculatorState(
      netIncome: netIncome ?? this.netIncome,
      totalDividend: totalDividends ?? this.totalDividend,
    );
  }

  // Copy With Defaults Method
  @override
  DividendPayoutRatioCalculatorState copyWithDefaults({
    bool resetNetIncome = false,
    bool resetTotalDividend = false,
  }) {
    return DividendPayoutRatioCalculatorState(
      netIncome: resetNetIncome ? null : netIncome,
      totalDividend: resetTotalDividend ? null : totalDividend,
    );
  }

  // Merge Method
  @override
  DividendPayoutRatioCalculatorState merge(
    covariant DividendPayoutRatioCalculatorState model,
  ) {
    return copyWith(
      netIncome: model.netIncome,
      totalDividends: model.totalDividend,
    );
  }

  // Props Getter
  @override
  List<Object?> get props => [netIncome, totalDividend];
}
