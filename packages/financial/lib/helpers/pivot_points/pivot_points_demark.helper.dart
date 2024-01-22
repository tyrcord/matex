// Project imports:
import 'package:matex_financial/financial.dart';

MatexPivotPointsCalculatorResults pivotPointsDeMark(
  double? high,
  double? low,
  double? close,
  double? open,
) {
  double pivotPoint;
  close ??= 0;
  open ??= 0;
  high ??= 0;
  low ??= 0;

  if (close < open) {
    pivotPoint = low * 2 + high + close;
  } else if (close > open) {
    pivotPoint = 2 * high + low + close;
  } else {
    pivotPoint = close * 2 + high + low;
  }

  final pivotPointDividedBy2 = pivotPoint / 2;
  final pivotPointDividedBy4 = pivotPoint / 4;
  final resistance = pivotPointDividedBy2 - low;
  final support = pivotPointDividedBy2 - high;

  return MatexPivotPointsCalculatorResults(
    pivotPoint: pivotPointDividedBy4,
    resistances: [resistance],
    supports: [support],
  );
}
