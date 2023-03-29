import 'package:decimal/decimal.dart';

double applyDiscount(
  double price,
  double discountAmount,
  double discountRate,
) {
  Decimal dPrice = Decimal.parse(price.toString());
  Decimal dDiscountAmount = Decimal.parse(discountAmount.toString());
  Decimal dDiscountPercentage = Decimal.parse(discountRate.toString());
  Decimal discountedPrice = dPrice;

  if (dDiscountAmount > Decimal.zero) {
    discountedPrice -= dDiscountAmount;
  } else if (dDiscountPercentage > Decimal.zero) {
    discountedPrice -= (discountedPrice * dDiscountPercentage);
  }

  return discountedPrice.toDouble();
}
