import 'package:matex_financial/financial.dart';
import 'package:tstore/tstore.dart';

/// The default name for the store that holds the favorite financial
/// instruments.
const _kStoreName = 'matexInstrumentFavorite';

/// A provider for managing favorite financial instruments in a store.
class MatexInstrumentFavoriteDataProvider extends TDocumentDataProvider {
  /// Creates a new [MatexInstrumentFavoriteDataProvider] instance.
  ///
  /// The optional [storeName] parameter can be used to specify a custom name
  /// for the store.
  MatexInstrumentFavoriteDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? _kStoreName);

  /// Retrieves the favorite financial instrument document from the store.
  ///
  /// Returns a [MatexInstrumentFavoriteDocument] instance, which contains the
  /// list of favorite financial instruments.
  /// If the store is empty or does not exist, returns an empty
  /// [MatexInstrumentFavoriteDocument] instance.
  Future<MatexInstrumentFavoriteDocument> retreiveDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) return MatexInstrumentFavoriteDocument.fromJson(json);

    return const MatexInstrumentFavoriteDocument();
  }

  /// Retrieves the list of favorite financial instruments from the store.
  ///
  /// The optional [sort] parameter can be used to specify whether the list
  /// should be sorted by the `base` property in ascending order.
  /// If [sort] is `true`, the list is sorted. If [sort] is `false` or not
  /// provided, the list is returned as-is.
  ///
  /// Returns a list of [MatexInstrumentFavorite] instances.
  Future<List<MatexInstrumentFavorite>> retreiveFavorites({
    bool sort = false,
  }) async {
    final document = await retreiveDocument();
    var favorites = document.favorites ?? const [];

    if (sort) {
      favorites = [...favorites]..sort((a, b) => a.base.compareTo(b.base));
    }

    return favorites;
  }

  /// Adds a favorite financial instrument to the store.
  ///
  /// The [favorite] parameter specifies the financial instrument to add.
  ///
  /// Throws an [ArgumentError] if the `counter` or `base` property of the input
  ///  is empty.
  Future<void> addFavorite(MatexInstrumentFavorite favorite) async {
    final document = await retreiveDocument();
    final existingFavorites = document.favorites ?? const [];
    final alreadyExists = existingFavorites.any((f) {
      return f.counter == favorite.counter && f.base == favorite.base;
    });

    // The favorite already exists
    if (alreadyExists) {
      return;
    }

    // Validate the input
    if (favorite.counter.isEmpty) {
      throw ArgumentError('Counter currency code cannot be empty');
    }
    if (favorite.base.isEmpty) {
      throw ArgumentError('Base currency code cannot be empty');
    }

    final newFavorites = [...existingFavorites, favorite];

    return persistDocument(document.copyWith(favorites: newFavorites));
  }

  /// Persists a list of favorite financial instruments to the store.
  ///
  /// The [favorites] parameter specifies the list of financial instruments to
  /// persist.
  Future<void> persistFavorites(List<MatexInstrumentFavorite> favorites) async {
    final document = await retreiveDocument();

    return persistDocument(document.copyWith(favorites: favorites));
  }

  /// Removes a favorite financial instrument from the store.
  ///
  /// The [favorite] parameter specifies the financial instrument to remove.
  Future<void> removeFavorite(MatexInstrumentFavorite favorite) async {
    final document = await retreiveDocument();

    return persistDocument(
      document.copyWith(
        favorites: document.favorites?.where((f) {
          return !(f.counter == favorite.counter && f.base == favorite.base);
        }).toList(),
      ),
    );
  }

  /// Removes all favorite financial instruments from the store.
  Future<void> clearFavorites() async {
    final document = await retreiveDocument();

    return persistDocument(document.copyWith(favorites: const []));
  }
}
