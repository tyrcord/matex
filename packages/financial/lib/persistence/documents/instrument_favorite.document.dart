import 'package:matex_financial/financial.dart';
import 'package:tstore/tstore.dart';

/// Represents a document that contains a list of favorite financial
/// instruments.
class MatexInstrumentFavoriteDocument extends TDocument {
  /// The list of favorite financial instruments.
  final List<MatexInstrumentFavorite>? favorites;

  /// Creates a new instance of the [MatexInstrumentFavoriteDocument] class.
  const MatexInstrumentFavoriteDocument({
    this.favorites = const [],
  });

  /// Parses a JSON map and returns a [MatexInstrumentFavoriteDocument] object.
  static MatexInstrumentFavoriteDocument fromJson(
    Map<String, dynamic> json,
  ) {
    final raw = json['favorites'] as List<dynamic>?;

    return MatexInstrumentFavoriteDocument(
      favorites: raw?.where(
        (element) {
          final counter = element['counter'] as String?;
          final base = element['base'] as String?;

          return counter != null && base != null;
        },
      ).map((element) {
        final json = {
          'counter': element['counter'] as String,
          'base': element['base'] as String,
        };

        return MatexInstrumentFavorite.fromJson(json);
      }).toList(),
    );
  }

  /// Returns a new instance of [MatexInstrumentFavoriteDocument] that is a
  /// copy of the current instance.
  @override
  MatexInstrumentFavoriteDocument clone() => copyWith();

  /// Returns a new instance of [MatexInstrumentFavoriteDocument] with the
  /// [favorites] field replaced by the provided argument, or the current
  /// [favorites] list if no argument is provided.
  @override
  MatexInstrumentFavoriteDocument copyWith({
    List<MatexInstrumentFavorite>? favorites,
  }) {
    return MatexInstrumentFavoriteDocument(
      favorites: favorites ?? this.favorites,
    );
  }

  /// Returns a new instance of [MatexInstrumentFavoriteDocument] with the
  /// [favorites] field replaced by the [favorites] list of the provided
  /// [MatexInstrumentFavoriteDocument] argument.
  @override
  MatexInstrumentFavoriteDocument merge(
    covariant MatexInstrumentFavoriteDocument model,
  ) {
    return MatexInstrumentFavoriteDocument(favorites: model.favorites);
  }

  /// Returns a JSON map representation of the [MatexInstrumentFavoriteDocument]
  /// object.
  @override
  Map<String, dynamic> toJson() {
    final superMap = super.toJson();

    if (favorites == null) return superMap;

    return {
      'favorites': favorites!.map((favorite) => favorite.toJson()).toList(),
      ...superMap,
    };
  }

  /// Returns a list of objects used for equality comparison.
  @override
  List<Object?> get props => [favorites];
}
