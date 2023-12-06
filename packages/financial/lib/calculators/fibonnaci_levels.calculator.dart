import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';
import 'package:matex_financial/financial.dart';

class MatexFibonnaciLevelsCalculator extends MatexCalculator<
    MatexFibonnaciLevelsCalculatorState,
    MatexFibonnaciLevelsCalculatorResults> {
  MatexFibonnaciLevelsCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: fibonacciLevelsValidators);

  @override
  MatexFibonnaciLevelsCalculatorState initializeState() =>
      const MatexFibonnaciLevelsCalculatorState();

  @override
  MatexFibonnaciLevelsCalculatorState initializeDefaultState() =>
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

  static const defaultResults = MatexFibonnaciLevelsCalculatorResults();

  @override
  MatexFibonnaciLevelsCalculatorResults value() {
    if (!isValid) return defaultResults;

    return MatexFibonnaciLevelsCalculatorResults(
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

        return _makeFibonacciLevel(level, parsedValue.toDouble());
      }).toList();
    }

    return kMatexFibonacciExtensionLevels.map((double level) {
      final dLevel = toDecimalOrDefault(level);
      final dLevelRate = decimalFromRational(dLevel / dHundred);
      final parsedValue = isValid ? -(dLevelRate * dDelta) + dLowPrice : dOne;

      return _makeFibonacciLevel(level, parsedValue.toDouble());
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

        return _makeFibonacciLevel(level, parsedValue.toDouble());
      }).toList();
    }

    return kMatexFibonacciRetracementLevels.map((double level) {
      final dLevel = toDecimalOrDefault(level);
      final dLevelRate = decimalFromRational(dLevel / dHundred);
      final parsedValue = isValid ? -(dLevelRate * dDelta) + dHighPrice : dOne;

      return _makeFibonacciLevel(level, parsedValue.toDouble());
    }).toList();
  }

  MatexFibonacciLevel _makeFibonacciLevel(double level, double value) {
    return MatexFibonacciLevel(
      level: _formatLevelLabel(level),
      value: _formatLevelValue(value),
    );
  }

  String _formatLevelLabel(double level) {
    final dLevel = toDecimalOrDefault(level);
    final fixedValue = dLevel.toStringAsFixed(level % 1 == 0 ? 0 : 1);

    return '$fixedValue%';
  }

  double _formatLevelValue(double value) {
    final dValue = toDecimalOrDefault(value);
    final sValue = dValue.toStringAsFixed(MatexFibonacciLevel.defaultPrecision);

    return toDecimalOrDefault(sValue).toDouble();
  }
}
