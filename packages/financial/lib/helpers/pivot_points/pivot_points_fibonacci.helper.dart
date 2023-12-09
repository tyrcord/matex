import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

final _fibonacci382 = toDecimalOrDefault('0.382');
final _fibonacci618 = toDecimalOrDefault('0.618');

MatexPivotPointsCalculatorResults pivotPointsFibonacci(
  double? high,
  double? low,
  double? close,
) {
  final dHighPrice = toDecimalOrDefault(high);
  final dLowPrice = toDecimalOrDefault(low);
  final dClosePrice = toDecimalOrDefault(close);

  final pivotPoint =
      decimalFromRational((dHighPrice + dLowPrice + dClosePrice) / dThree);
  final delta = dHighPrice - dLowPrice;

  final dResistance1 = pivotPoint + (delta * _fibonacci382);
  final dResistance2 = pivotPoint + (delta * _fibonacci618);
  final dResistance3 = pivotPoint + delta;

  final dSupport1 = pivotPoint - (delta * _fibonacci382);
  final dSupport2 = pivotPoint - (delta * _fibonacci618);
  final dSupport3 = pivotPoint - delta;

  return MatexPivotPointsCalculatorResults(
    pivotPoint: pivotPoint.toDouble(),
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
