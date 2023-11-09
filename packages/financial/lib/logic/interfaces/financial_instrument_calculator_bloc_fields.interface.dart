/// An abstract class representing the fields required for a financial
/// instrument calculator in the Matex package. This class serves as a
/// base to ensure consistency in calculator implementations which
/// require a base and a counter currency.
abstract class MatexFinancialInstrumentCalculatorBlocFields {
  /// The base currency is the first currency in a currency pair
  /// and is used to set the amount to convert from.
  late final String? baseCurrency;

  /// The counter currency is the second currency in the currency pair
  /// and is used to set the amount to convert to.
  late final String? counterCurrency;
}
