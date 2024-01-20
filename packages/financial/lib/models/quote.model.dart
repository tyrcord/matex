// Package imports:
import 'package:tmodel/tmodel.dart';

/// Represents a financial quote with price, symbol, and a timestamp.
class MatexQuote extends TModel {
  final double price;
  final String symbol;
  final int timestamp;

  const MatexQuote({
    required this.price,
    required this.symbol,
    required this.timestamp,
  });

  /// Constructs a [MatexQuote] from a JSON map.
  factory MatexQuote.fromJson(Map<String, dynamic> json) {
    final symbol = json['symbol'] as String?;
    final price = json['price'] as double?;
    final timestamp = json['timestamp'] as int?;

    // Ensure all required fields are present.
    _validateJSONFields(symbol, price, timestamp);

    return MatexQuote(
      timestamp: timestamp as int,
      symbol: symbol as String,
      price: price as double,
    );
  }

  // Validates JSON fields and throws meaningful errors if they are null.
  static void _validateJSONFields(
    String? symbol,
    double? price,
    int? timestamp,
  ) {
    if (symbol == null) {
      throw ArgumentError.notNull('symbol');
    }

    if (price == null) {
      throw ArgumentError.notNull('price');
    }

    if (timestamp == null) {
      throw ArgumentError.notNull('timestamp');
    }
  }

  @override
  List<Object> get props => [price, symbol, timestamp];

  @override
  TModel clone() => copyWith();

  @override
  MatexQuote copyWith({
    double? price,
    String? symbol,
    int? timestamp,
  }) {
    return MatexQuote(
      timestamp: timestamp ?? this.timestamp,
      symbol: symbol ?? this.symbol,
      price: price ?? this.price,
    );
  }

  @override
  MatexQuote merge(covariant MatexQuote model) {
    return copyWith(
      timestamp: model.timestamp,
      symbol: model.symbol,
      price: model.price,
    );
  }
}
