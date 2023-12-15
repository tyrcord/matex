// Project imports:
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexFibonnaciLevelsCalculatorState extends MatexCalculatorState {
  static const defaultTrend = MatexTrend.up;

  // Define Properties
  final double? highPrice;
  final double? lowPrice;
  final MatexTrend trend;

  // Constructor
  const MatexFibonnaciLevelsCalculatorState({
    MatexTrend? trend,
    this.highPrice,
    this.lowPrice,
  }) : trend = trend ?? defaultTrend;

  // Clone Method
  @override
  MatexFibonnaciLevelsCalculatorState clone() => copyWith();

  // Copy With Method
  @override
  MatexFibonnaciLevelsCalculatorState copyWith({
    double? highPrice,
    double? lowPrice,
    MatexTrend? trend,
  }) {
    return MatexFibonnaciLevelsCalculatorState(
      highPrice: highPrice ?? this.highPrice,
      lowPrice: lowPrice ?? this.lowPrice,
      trend: trend ?? this.trend,
    );
  }

  // Copy With Defaults Method
  @override
  MatexFibonnaciLevelsCalculatorState copyWithDefaults({
    bool resetNetIncome = false,
    bool resetTotalDividends = false,
    bool resetTrend = false,
  }) {
    return MatexFibonnaciLevelsCalculatorState(
      highPrice: resetNetIncome ? null : highPrice,
      lowPrice: resetTotalDividends ? null : lowPrice,
      trend: resetTrend ? MatexTrend.up : trend,
    );
  }

  // Merge Method
  @override
  MatexFibonnaciLevelsCalculatorState merge(
    covariant MatexFibonnaciLevelsCalculatorState model,
  ) {
    return copyWith(
      highPrice: model.highPrice,
      lowPrice: model.lowPrice,
      trend: model.trend,
    );
  }

  // Props Getter
  @override
  List<Object?> get props => [highPrice, lowPrice, trend];
}
