import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

MatexPivotPointsCalculatorResults pivotPointsWoodie(
  double? high,
  double? low,
  double? close,
) {
  final dHighPrice = toDecimalOrDefault(high);
  final dLowPrice = toDecimalOrDefault(low);
  final dClosePrice = toDecimalOrDefault(close);

  final pivotPoint = decimalFromRational(
      (dClosePrice * dTwo + dLowPrice + dHighPrice) / dFour);

  final dResistance1 = pivotPoint * dTwo - dLowPrice;
  final dResistance2 = pivotPoint + dHighPrice - dLowPrice;

  final dSupport1 = pivotPoint * dTwo - dHighPrice;
  final dSupport2 = pivotPoint - dHighPrice + dLowPrice;

  return MatexPivotPointsCalculatorResults(
    pivotPoint: pivotPoint.toDouble(),
    resistances: [dResistance1.toDouble(), dResistance2.toDouble()],
    supports: [dSupport1.toDouble(), dSupport2.toDouble()],
  );
}
