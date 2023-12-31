import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';
import 'package:matex_financial/financial.dart';
import 'package:tenhance/decimal.dart';

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
    final dHighPrice = toDecimalOrDefault(state.highPrice);
    final dLowPrice = toDecimalOrDefault(state.lowPrice);
    final dDelta = toDecimalOrDefault(dHighPrice - dLowPrice);

    if (trend == MatexTrend.up) {
      return [...kMatexFibonacciExtensionLevels].reversed.map((double level) {
        final dLevel = toDecimalOrDefault(level);
        final dLevelRate = decimalFromRational(dLevel / dHundred);
        final parsedValue = isValid ? dLevelRate * dDelta + dHighPrice : dOne;

        return _makeFibonacciLevel(
          dLevelRate.toSafeDouble(),
          parsedValue.toSafeDouble(),
        );
      }).toList();
    }

    return kMatexFibonacciExtensionLevels.map((double level) {
      final dLevel = toDecimalOrDefault(level);
      final dLevelRate = decimalFromRational(dLevel / dHundred);
      final parsedValue = isValid ? -(dLevelRate * dDelta) + dLowPrice : dOne;

      return _makeFibonacciLevel(
        dLevelRate.toSafeDouble(),
        parsedValue.toSafeDouble(),
      );
    }).toList();
  }

  List<MatexFibonacciLevel> _computeRetracements() {
    final trend = state.trend;
    final dHighPrice = toDecimalOrDefault(state.highPrice);
    final dLowPrice = toDecimalOrDefault(state.lowPrice);
    final dDelta = toDecimalOrDefault(dHighPrice - dLowPrice);

    if (trend == MatexTrend.down) {
      return [...kMatexFibonacciRetracementLevels].reversed.map((double level) {
        final dLevel = toDecimalOrDefault(level);
        final dLevelRate = decimalFromRational(dLevel / dHundred);
        final parsedValue = isValid ? dLevelRate * dDelta + dLowPrice : dOne;

        return _makeFibonacciLevel(
          dLevelRate.toSafeDouble(),
          parsedValue.toSafeDouble(),
        );
      }).toList();
    }

    return kMatexFibonacciRetracementLevels.map((double level) {
      final dLevel = toDecimalOrDefault(level);
      final dLevelRate = decimalFromRational(dLevel / dHundred);
      final parsedValue = isValid ? -(dLevelRate * dDelta) + dHighPrice : dOne;

      return _makeFibonacciLevel(
        dLevelRate.toSafeDouble(),
        parsedValue.toSafeDouble(),
      );
    }).toList();
  }

  MatexFibonacciLevel _makeFibonacciLevel(double level, double value) {
    return MatexFibonacciLevel(level: level, value: value);
  }
}
