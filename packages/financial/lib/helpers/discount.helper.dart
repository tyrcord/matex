// Package imports:

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
  var discountedPrice = price;
  discountAmount ??= 0.0;
  discountRate ??= 0.0;

  if (discountAmount > 0) {
    discountedPrice -= discountAmount;
  } else if (discountRate > 0) {
    discountedPrice -= (discountedPrice * discountRate);
  }

  return discountedPrice;
}
