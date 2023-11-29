// Project imports:
import 'package:matex_core/core.dart';

class MatexDividendPayoutRatioCalculatorState extends MatexCalculatorState {
  // Define Properties
  final double? netIncome;
  final double? totalDividends;

  // Constructor
  const MatexDividendPayoutRatioCalculatorState({
    this.netIncome,
    this.totalDividends,
  });

  // Clone Method
  @override
  MatexDividendPayoutRatioCalculatorState clone() => copyWith();

  // From JSON Factory
  factory MatexDividendPayoutRatioCalculatorState.fromJson(
      Map<String, dynamic> json) {
    return MatexDividendPayoutRatioCalculatorState(
      netIncome: json['netIncome'] as double?,
      totalDividends: json['totalDividend'] as double?,
    );
  }

  // Copy With Method
  @override
  MatexDividendPayoutRatioCalculatorState copyWith({
    double? netIncome,
    double? totalDividends,
  }) {
    return MatexDividendPayoutRatioCalculatorState(
      netIncome: netIncome ?? this.netIncome,
      totalDividends: totalDividends ?? this.totalDividends,
    );
  }

  // Copy With Defaults Method
  @override
  MatexDividendPayoutRatioCalculatorState copyWithDefaults({
    bool resetNetIncome = false,
    bool resetTotalDividends = false,
  }) {
    return MatexDividendPayoutRatioCalculatorState(
      netIncome: resetNetIncome ? null : netIncome,
      totalDividends: resetTotalDividends ? null : totalDividends,
    );
  }

  // Merge Method
  @override
  MatexDividendPayoutRatioCalculatorState merge(
    covariant MatexDividendPayoutRatioCalculatorState model,
  ) {
    return copyWith(
      netIncome: model.netIncome,
      totalDividends: model.totalDividends,
    );
  }

  // Props Getter
  @override
  List<Object?> get props => [netIncome, totalDividends];
}
