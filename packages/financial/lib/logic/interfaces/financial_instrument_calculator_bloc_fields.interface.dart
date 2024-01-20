// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

/// An abstract class representing fields for a financial instrument
/// calculator in a Bloc pattern. This class provides the foundation
/// for handling calculations related to various financial instruments
/// like currency pairs or stocks against a currency.
abstract class MatexFinancialInstrumentCalculatorBlocFields
    extends FastCalculatorFields {
  /// The 'base' part of a financial instrument. In the context of
  /// currency pairs, this represents the base currency. For example,
  /// in a currency pair 'EUR/USD', 'EUR' is the base currency.
  late final String? base;

  /// The 'counter' part of a financial instrument. In currency pairs,
  /// this is the quote currency. For instance, in 'EUR/USD', 'USD'
  /// would be the counter or quote currency. It represents the amount
  /// of the counter currency required to buy one unit of the base
  /// currency.
  late final String? counter;
}
