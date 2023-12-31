import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';
import 'package:tenhance/decimal.dart';

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
    pivotPoint: dPivotPoint.toSafeDouble(),
    resistances: [
      dResistance1.toSafeDouble(),
      dResistance2.toSafeDouble(),
      dResistance3.toSafeDouble(),
    ],
    supports: [
      dSupport1.toSafeDouble(),
      dSupport2.toSafeDouble(),
      dSupport3.toSafeDouble(),
    ],
  );
}
