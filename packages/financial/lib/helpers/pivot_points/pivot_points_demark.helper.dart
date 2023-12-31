import 'package:decimal/decimal.dart';
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';
import 'package:tenhance/decimal.dart';

MatexPivotPointsCalculatorResults pivotPointsDeMark(
  double? high,
  double? low,
  double? close,
  double? open,
) {
  final dHighPrice = toDecimalOrDefault(high);
  final dLowPrice = toDecimalOrDefault(low);
  final dClosePrice = toDecimalOrDefault(close);
  final dOpenPrice = toDecimalOrDefault(open);
  Decimal pivotPoint;

  if (dClosePrice < dOpenPrice) {
    pivotPoint = dLowPrice * dTwo + dHighPrice + dClosePrice;
  } else if (dClosePrice > dOpenPrice) {
    pivotPoint = dTwo * dHighPrice + dLowPrice + dClosePrice;
  } else {
    pivotPoint = dClosePrice * dTwo + dHighPrice + dLowPrice;
  }

  final pivotPointDividedBy2 = decimalFromRational(pivotPoint / dTwo);
  final pivotPointDividedBy4 = decimalFromRational(pivotPoint / dFour);
  final resistance = pivotPointDividedBy2 - dLowPrice;
  final support = pivotPointDividedBy2 - dHighPrice;

  return MatexPivotPointsCalculatorResults(
    pivotPoint: pivotPointDividedBy4.toSafeDouble(),
    resistances: [resistance.toSafeDouble()],
    supports: [support.toSafeDouble()],
  );
}
