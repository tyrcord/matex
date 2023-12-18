// Project imports:
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexFibonacciLevelsCalculatorState extends MatexCalculatorState {
  static const defaultTrend = MatexTrend.up;

  // Define Properties
  final double? highPrice;
  final double? lowPrice;
  final MatexTrend trend;

  // Constructor
  const MatexFibonacciLevelsCalculatorState({
    MatexTrend? trend,
    this.highPrice,
    this.lowPrice,
  }) : trend = trend ?? defaultTrend;

  // Clone Method
  @override
  MatexFibonacciLevelsCalculatorState clone() => copyWith();

  // Copy With Method
  @override
  MatexFibonacciLevelsCalculatorState copyWith({
    double? highPrice,
    double? lowPrice,
    MatexTrend? trend,
  }) {
    return MatexFibonacciLevelsCalculatorState(
      highPrice: highPrice ?? this.highPrice,
      lowPrice: lowPrice ?? this.lowPrice,
      trend: trend ?? this.trend,
    );
  }

  // Copy With Defaults Method
  @override
  MatexFibonacciLevelsCalculatorState copyWithDefaults({
    bool resetNetIncome = false,
    bool resetTotalDividends = false,
    bool resetMethod = false,
  }) {
    return MatexFibonacciLevelsCalculatorState(
      highPrice: resetNetIncome ? null : highPrice,
      lowPrice: resetTotalDividends ? null : lowPrice,
      trend: resetMethod ? MatexTrend.up : trend,
    );
  }

  // Merge Method
  @override
  MatexFibonacciLevelsCalculatorState merge(
    covariant MatexFibonacciLevelsCalculatorState model,
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
