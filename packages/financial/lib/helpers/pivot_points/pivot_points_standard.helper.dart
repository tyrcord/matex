import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

MatexPivotPointsCalculatorResults pivotPointsStandard(
  double? high,
  double? low,
  double? close,
) {
  final dHighPrice = toDecimalOrDefault(high);
  final dLowPrice = toDecimalOrDefault(low);
  final dClosePrice = toDecimalOrDefault(close);

  final dPivotPoint =
      decimalFromRational((dHighPrice + dLowPrice + dClosePrice) / dThree);

  final dResistance1 = dPivotPoint * dTwo - dLowPrice;
  final dResistance2 = dPivotPoint + (dHighPrice - dLowPrice);
  final dResistance3 = (dPivotPoint - dLowPrice) * dTwo + dHighPrice;

  final dSupport1 = dPivotPoint * dTwo - dHighPrice;
  final dSupport2 = dPivotPoint - (dHighPrice - dLowPrice);
  final dSupport3 = (dHighPrice - dPivotPoint) * (-dTwo) + dLowPrice;

  return MatexPivotPointsCalculatorResults(
    pivotPoint: dPivotPoint.toDouble(),
    resistances: [
      dResistance1.toDouble(),
      dResistance2.toDouble(),
      dResistance3.toDouble(),
    ],
    supports: [
      dSupport1.toDouble(),
      dSupport2.toDouble(),
      dSupport3.toDouble(),
    ],
  );
}
