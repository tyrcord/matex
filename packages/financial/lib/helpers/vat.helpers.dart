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
/// final priceWithVAT = addVAT(100, 0.2);
/// print(priceWithVAT); // 120.0
/// ```
double addVAT(double price, double vatRate) => price * (1 + vatRate);

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
/// final priceBeforeVAT = removeVAT(120, 0.2);
/// print(priceBeforeVAT); // 100.0
/// ```
double removeVAT(double priceWithVAT, double vatRate) {
  return priceWithVAT / (1 + vatRate);
}

/// Calculates the VAT amount for a given price and VAT rate.
///
/// The [price] argument specifies the total price of the item or service.
/// The [vatRate] argument specifies the VAT rate as a percentage of the price.
///
/// This function uses the [Decimal] type from the `decimal` package
/// to perform the calculation with high precision.
/// The result is then converted to a `double` value and returned.
///
/// Example:
///
/// ```dart
/// double vatAmount = getVATAmount(100.0, 0.2);
/// print(vatAmount); // 20.0
/// ```
double getVATAmount(double price, double vatRate) => price * vatRate;
