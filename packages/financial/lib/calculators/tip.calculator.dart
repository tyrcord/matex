import 'package:decimal/decimal.dart';

/// Calculates the tip on a price before VAT.
///
/// This function takes a [priceWithoutVAT] that does not include VAT and a [tipRate]
/// representing the tip rate as a percentage. It returns the amount of the tip.
///
/// The calculation is performed using the `decimal` package to avoid
/// rounding errors when working with decimal numbers.
///
/// Example:
///
/// ```dart
/// final tipAmount = calculateTip(100, 15);
/// print(tipAmount); // 15.0
/// ```
double calculateTip(double priceWithoutVAT, double tipRate) {
  final decimalPriceWithoutVAT = Decimal.parse(priceWithoutVAT.toString());
  final decimalTipRate = Decimal.parse(tipRate.toString());
  final result = decimalPriceWithoutVAT *
      (decimalTipRate / Decimal.fromInt(100))
          .toDecimal(scaleOnInfinitePrecision: 32);

  return result.toDouble();
}
