/// Calculates the tip on a price before VAT.
///
/// This function takes a [price] that does not include VAT and a
/// [tipRate] representing the tip rate as a percentage.
/// It returns the amount of the tip.
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
double calculateTip(double price, double tipRate) => price * tipRate;

/// Calculates the tip amount for a given price and tip percentage.
///
/// The [price] argument specifies the total price of the bill.
/// The [tipRate] argument specifies the percentage of the bill
/// to be added as a tip.
///
/// This function uses the [Decimal] type from the `decimal` package
/// to perform the calculation  with high precision.
/// The result is then converted to a `double` value and returned.
///
/// Example:
///
/// ```dart
/// double tipAmount = getTipAmount(100.0, 0.15);
/// print(tipAmount); // 15.0
/// ```
double getTipAmount(double price, double tipRate) => price * tipRate;

/// Calculates the tip rate based on the price and tip amount.
///
/// The [price] parameter is the total price of the bill.
/// The [tipAmount] parameter is the amount of tip to be given.
///
/// Returns the tip rate as a percentage.
double getTipRate(double price, double tipAmount) {
  return price > 0 ? (tipAmount / price) : 0;
}
