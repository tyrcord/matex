import 'package:decimal/decimal.dart';
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

final List<Decimal> _dividers = [12.0, 6.0, 4.0, 2.0].map((double divider) {
  return Decimal.parse(divider.toString());
}).toList();

final _multiplier = Decimal.parse('1.1');

MatexPivotPointsCalculatorResults pivotPointsCamarilla(
  double? high,
  double? low,
  double? close,
) {
  final dHighPrice = toDecimalOrDefault(high);
  final dLowPrice = toDecimalOrDefault(low);
  final dClosePrice = toDecimalOrDefault(close);

  return MatexPivotPointsCalculatorResults(
    resistances: _calculateResistances(dHighPrice, dLowPrice, dClosePrice),
    pivotPoint: _calculatePivotPoint(dHighPrice, dLowPrice, dClosePrice),
    supports: _calculateSupports(dHighPrice, dLowPrice, dClosePrice),
  );
}

// Helper function to calculate the pivot point
double _calculatePivotPoint(Decimal high, Decimal low, Decimal close) {
  return decimalFromRational((high + low + close) / dThree).toDouble();
}

// Helper function to calculate resistances
List<double> _calculateResistances(Decimal high, Decimal low, Decimal close) {
  return _calculatePricePoints(high, low, close, false);
}

// Helper function to calculate supports
List<double> _calculateSupports(Decimal high, Decimal low, Decimal close) {
  return _calculatePricePoints(high, low, close, true);
}

// Generalized function for calculating price points
List<double> _calculatePricePoints(
  Decimal high,
  Decimal low,
  Decimal close,
  bool isSupport,
) {
  return _dividers.map((divider) {
    final difference = high - low * _multiplier;
    final priceDifference = decimalFromRational(difference / divider);

    if (isSupport) {
      return (close - priceDifference).toDouble();
    }

    return (close + priceDifference).toDouble();
  }).toList();
}
