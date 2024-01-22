// Project imports:
import 'package:matex_financial/financial.dart';

MatexPivotPointsCalculatorResults pivotPointsWoodie(
  double? high,
  double? low,
  double? close,
) {
  close ??= 0;
  high ??= 0;
  low ??= 0;

  final pivotPoint = (close * 2 + low + high) / 4;

  final dResistance1 = pivotPoint * 2 - low;
  final dResistance2 = pivotPoint + high - low;

  final dSupport1 = pivotPoint * 2 - high;
  final dSupport2 = pivotPoint - high + low;

  return MatexPivotPointsCalculatorResults(
    resistances: [dResistance1, dResistance2],
    supports: [dSupport1, dSupport2],
    pivotPoint: pivotPoint,
  );
}
