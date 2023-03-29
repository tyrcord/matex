import 'package:decimal/decimal.dart';

/// Adds VAT to a price.
///
/// This function takes a [price] that does not include VAT and a [vatRate]
/// representing the VAT rate as a percentage. It returns the price with
/// the VAT added.
///
/// The calculation is performed using the `decimal` package to avoid
/// rounding errors when working with decimal numbers.
///
/// Example:
///
/// ```dart
/// final priceWithVAT = addVAT(100, 20);
/// print(priceWithVAT); // 120.0
/// ```
double addVAT(double price, double vatRate) {
  final decimalPrice = Decimal.parse(price.toString());
  final decimalVatRate = Decimal.parse(vatRate.toString());
  final rationalVatRatePercent = decimalVatRate / Decimal.fromInt(100);
  final decimalVatRatePercent =
      rationalVatRatePercent.toDecimal(scaleOnInfinitePrecision: 32);
  final result = decimalPrice * (Decimal.one + decimalVatRatePercent);

  return result.toDouble();
}

/// Removes the VAT from a price.
///
/// This function takes a [priceWithVAT] that includes VAT and a [vatRate]
/// representing the VAT rate as a percentage. It returns the price before
/// VAT was added.
///
/// The calculation is performed using the `decimal` package to avoid
/// rounding errors when working with decimal numbers.
///
/// Example:
///
/// ```dart
/// final priceBeforeVAT = removeVAT(120, 20);
/// print(priceBeforeVAT); // 100.0
/// ```
double removeVAT(double priceWithVAT, double vatRate) {
  final decimalPriceWithVAT = Decimal.parse(priceWithVAT.toString());
  final decimalVatRate = Decimal.parse(vatRate.toString());
  final result = decimalPriceWithVAT /
      (Decimal.one +
          (decimalVatRate / Decimal.fromInt(100))
              .toDecimal(scaleOnInfinitePrecision: 32));

  return result.toDouble();
}

/// Calculates the amount of VAT between two prices.
///
/// This function takes a [priceWithVAT] that includes VAT and
/// a [priceWithoutVAT] that does not include VAT.
/// It returns the amount of VAT between the two prices.
///
/// The calculation is performed using the `decimal` package to avoid
/// rounding errors when working with decimal numbers.
///
/// Example:
///
/// ```dart
/// final vatAmount = getVATAmount(120, 100);
/// print(vatAmount); // 20.0
/// ```
double getVATAmount(double priceWithVAT, double priceWithoutVAT) {
  final decimalPriceWithVAT = Decimal.parse(priceWithVAT.toString());
  final decimalPriceWithoutVAT = Decimal.parse(priceWithoutVAT.toString());
  final result = decimalPriceWithVAT - decimalPriceWithoutVAT;

  return result.toDouble();
}
