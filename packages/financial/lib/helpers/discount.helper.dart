import 'package:decimal/decimal.dart';

double applyDiscount(
  double price,
  double discountAmount,
  double discountRate,
) {
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
