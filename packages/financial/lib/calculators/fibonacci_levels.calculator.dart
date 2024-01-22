// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexFibonacciLevelsCalculator extends MatexCalculator<
    MatexFibonacciLevelsCalculatorState,
    MatexFibonacciLevelsCalculatorResults> {
  MatexFibonacciLevelsCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: fibonacciLevelsValidators);

  @override
  MatexFibonacciLevelsCalculatorState initializeState() =>
      const MatexFibonacciLevelsCalculatorState();

  @override
  MatexFibonacciLevelsCalculatorState initializeDefaultState() =>
      initializeState();

  double? get lowPrice => state.lowPrice;

  set lowPrice(double? value) {
    setState(state.copyWith(lowPrice: value));
  }

  double? get highPrice => state.highPrice;

  set highPrice(double? value) {
    setState(state.copyWith(highPrice: value));
  }

  MatexTrend get trend => state.trend;

  set trend(MatexTrend value) {
    setState(state.copyWith(trend: value));
  }

  static const defaultResults = MatexFibonacciLevelsCalculatorResults();

  @override
  MatexFibonacciLevelsCalculatorResults value() {
    if (!isValid) return defaultResults;

    return MatexFibonacciLevelsCalculatorResults(
      extensionLevels: _computeExtensions(),
      retracementLevels: _computeRetracements(),
    );
  }

  List<MatexFibonacciLevel> _computeExtensions() {
    final trend = state.trend;
    final highPrice = state.highPrice ?? 0.0;
    final lowPrice = state.lowPrice ?? 0.0;
    final delta = highPrice - lowPrice;

    if (trend == MatexTrend.up) {
      return [...kMatexFibonacciExtensionLevels].reversed.map((double level) {
        final levelRate = level / 100;
        final parsedValue = isValid ? levelRate * delta + highPrice : 1.0;

        return _makeFibonacciLevel(levelRate, parsedValue);
      }).toList();
    }

    return kMatexFibonacciExtensionLevels.map((double level) {
      final levelRate = level / 100;
      final parsedValue = isValid ? -(levelRate * delta) + lowPrice : 1.0;

      return _makeFibonacciLevel(levelRate, parsedValue);
    }).toList();
  }

  List<MatexFibonacciLevel> _computeRetracements() {
    final trend = state.trend;
    final highPrice = state.highPrice ?? 0.0;
    final lowPrice = state.lowPrice ?? 0.0;
    final delta = highPrice - lowPrice;

    if (trend == MatexTrend.down) {
      return [...kMatexFibonacciRetracementLevels].reversed.map((double level) {
        final levelRate = level / 100;
        final parsedValue = isValid ? levelRate * delta + lowPrice : 1.0;

        return _makeFibonacciLevel(levelRate, parsedValue);
      }).toList();
    }

    return kMatexFibonacciRetracementLevels.map((double level) {
      final levelRate = level / 100;
      final parsedValue = isValid ? -(levelRate * delta) + highPrice : 1.0;

      return _makeFibonacciLevel(levelRate, parsedValue);
    }).toList();
  }

  MatexFibonacciLevel _makeFibonacciLevel(double level, double value) {
    return MatexFibonacciLevel(level: level, value: value);
  }
}
