// Project imports:
import 'package:matex_financial/financial.dart';

MatexPivotPointsCalculatorResults pivotPointsStandard(
  double? high,
  double? low,
  double? close,
) {
  close ??= 0;
  high ??= 0;
  low ??= 0;

  final dPivotPoint = ((high + low + close) / 3);

  final dResistance1 = dPivotPoint * 2 - low;
  final dResistance2 = dPivotPoint + (high - low);
  final dResistance3 = (dPivotPoint - low) * 2 + high;

  final dSupport1 = dPivotPoint * 2 - high;
  final dSupport2 = dPivotPoint - (high - low);
  final dSupport3 = (high - dPivotPoint) * (-2) + low;

  return MatexPivotPointsCalculatorResults(
    resistances: [dResistance1, dResistance2, dResistance3],
    supports: [dSupport1, dSupport2, dSupport3],
    pivotPoint: dPivotPoint,
  );
}
