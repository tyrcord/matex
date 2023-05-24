import 'package:decimal/decimal.dart';

/// Applies a discount to a given price.
///
/// If [discountAmount] is greater than zero, it is subtracted from the [price].
/// If [discountRate] is greater than zero, it is multiplied by the [price] and
/// the result is subtracted from the [price].
///
/// Returns the discounted price.
double applyDiscount(
  double price, {
  double? discountAmount,
  double? discountRate,
}) {
  discountAmount ??= 0.0;
  discountRate ??= 0.0;

  Decimal dPrice = Decimal.parse(price.toString());
  Decimal dDiscountAmount = Decimal.parse(discountAmount.toString());
  Decimal dDiscountRate = Decimal.parse(discountRate.toString());
  Decimal discountedPrice = dPrice;

  if (dDiscountAmount > Decimal.zero) {
    discountedPrice -= dDiscountAmount;
  } else if (dDiscountRate > Decimal.zero) {
    discountedPrice -= (discountedPrice * dDiscountRate);
  }

  return discountedPrice.toDouble();
}
