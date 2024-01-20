// Project imports:
import 'package:matex_financial/models/models.dart';

/// An abstract class representing the exchange service for financial
/// instruments within the Matex application. It provides a contract
/// for the exchange rate querying and resource disposal.
abstract class MatexFinancialInstrumentExchangeService {
  const MatexFinancialInstrumentExchangeService();

  /// Retrieves the exchange rate for a given financial instrument symbol.
  ///
  /// This asynchronous method returns a [Future] that completes with a
  /// [MatexQuote] object representing the current exchange rate of the
  /// specified symbol. It may complete with null if no rate is available.
  ///
  /// The [symbol] parameter is the identifier of the financial instrument
  /// whose rate is to be fetched.
  ///
  /// Returns a [Future<MatexQuote?>] representing the exchange rate.
  Future<MatexQuote?> rate(String symbol);

  /// Releases any resources or connections held by the service.
  ///
  /// Implementing classes should override this method to dispose of any
  /// long-lived resources in an appropriate manner when the service is
  /// no longer needed.
  void dispose();
}
