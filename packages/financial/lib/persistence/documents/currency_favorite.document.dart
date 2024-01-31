// Package imports:
import 'package:tstore/tstore.dart';

/// Represents a document that contains a list of favorite currency codes.
class MatexCurrencyFavoriteDocument extends TDocument {
  final List<String> favorites;

  const MatexCurrencyFavoriteDocument({
    List<String>? favorites,
  }) : favorites = favorites ?? const [];

  /// Parses a JSON map and returns a [MatexCurrencyFavoriteDocument] object.
  static MatexCurrencyFavoriteDocument fromJson(Map<String, dynamic> json) {
    final raw = json['favorites'] as List<dynamic>?;

    return MatexCurrencyFavoriteDocument(
      favorites: raw?.map((e) => e.toString()).toList() ?? [],
    );
  }

  @override
  MatexCurrencyFavoriteDocument clone() => copyWith();

  @override
  MatexCurrencyFavoriteDocument copyWith({
    List<String>? favorites,
  }) {
    return MatexCurrencyFavoriteDocument(
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  MatexCurrencyFavoriteDocument merge(
    covariant MatexCurrencyFavoriteDocument model,
  ) {
    return MatexCurrencyFavoriteDocument(favorites: model.favorites);
  }

  @override
  Map<String, dynamic> toJson() {
    final superMap = super.toJson();

    return {
      'favorites': favorites,
      ...superMap,
    };
  }

  @override
  List<Object?> get props => [favorites];
}
