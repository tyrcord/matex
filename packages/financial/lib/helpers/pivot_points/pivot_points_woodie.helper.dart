// Package imports:
import 'package:t_helpers/helpers.dart';
import 'package:tenhance/decimal.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

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
    pivotPoint: pivotPoint.toSafeDouble(),
    resistances: [dResistance1.toSafeDouble(), dResistance2.toSafeDouble()],
    supports: [dSupport1.toSafeDouble(), dSupport2.toSafeDouble()],
  );
}
