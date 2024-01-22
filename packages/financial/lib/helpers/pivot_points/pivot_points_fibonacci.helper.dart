// Project imports:
import 'package:matex_financial/financial.dart';

const _fibonacci382 = 0.382;
const _fibonacci618 = 0.618;

MatexPivotPointsCalculatorResults pivotPointsFibonacci(
  double? high,
  double? low,
  double? close,
) {
  close ??= 0;
  high ??= 0;
  low ??= 0;

  final pivotPoint = (high + low + close) / 3;
  final delta = high - low;

  final dResistance1 = pivotPoint + (delta * _fibonacci382);
  final dResistance2 = pivotPoint + (delta * _fibonacci618);
  final dResistance3 = pivotPoint + delta;

  final dSupport1 = pivotPoint - (delta * _fibonacci382);
  final dSupport2 = pivotPoint - (delta * _fibonacci618);
  final dSupport3 = pivotPoint - delta;

  return MatexPivotPointsCalculatorResults(
    resistances: [dResistance1, dResistance2, dResistance3],
    supports: [dSupport1, dSupport2, dSupport3],
    pivotPoint: pivotPoint,
  );
}
