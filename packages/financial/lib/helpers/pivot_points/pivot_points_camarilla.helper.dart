// Project imports:
import 'package:matex_financial/financial.dart';

const List<double> _dividers = [12.0, 6.0, 4.0, 2.0];
const _multiplier = 1.1;

MatexPivotPointsCalculatorResults pivotPointsCamarilla(
  double? high,
  double? low,
  double? close,
) {
  high ??= 0;
  low ??= 0;
  close ??= 0;

  return MatexPivotPointsCalculatorResults(
    resistances: _calculateResistances(high, low, close),
    pivotPoint: _calculatePivotPoint(high, low, close),
    supports: _calculateSupports(high, low, close),
  );
}

// Helper function to calculate the pivot point
double _calculatePivotPoint(double high, double low, double close) {
  return (high + low + close) / 3;
}

// Helper function to calculate resistances
List<double> _calculateResistances(double high, double low, double close) {
  return _calculatePricePoints(high, low, close, false);
}

// Helper function to calculate supports
List<double> _calculateSupports(double high, double low, double close) {
  return _calculatePricePoints(high, low, close, true);
}

// Generalized function for calculating price points
List<double> _calculatePricePoints(
  double high,
  double low,
  double close,
  bool isSupport,
) {
  return _dividers.map((divider) {
    final difference = (high - low) * _multiplier;
    final priceDifference = (difference / divider);

    if (isSupport) return (close - priceDifference);

    return close + priceDifference;
  }).toList();
}
