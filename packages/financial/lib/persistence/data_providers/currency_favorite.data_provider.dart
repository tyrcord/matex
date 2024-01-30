import 'package:matex_financial/financial.dart';
import 'package:tstore/tstore.dart';

/// A provider for managing favorite currencies in a store.
class MatexCurrencyFavoriteDataProvider extends TDocumentDataProvider {
  static const defaultStoreName = 'matexCurrencyFavoriteStore';

  /// Creates a new [MatexCurrencyFavoriteDataProvider] instance.
  ///
  /// The optional [storeName] parameter can be used to specify a custom name
  /// for the store.
  MatexCurrencyFavoriteDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? defaultStoreName);

  /// Retrieves the favorite currency document from the store.
  ///
  /// Returns a [MatexCurrencyFavoriteDocument] instance, which contains the
  /// list of favorite currency codes.
  /// If the store is empty or does not exist, returns an empty
  /// [MatexCurrencyFavoriteDocument] instance.
  Future<MatexCurrencyFavoriteDocument> retrieveDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) return MatexCurrencyFavoriteDocument.fromJson(json);

    return const MatexCurrencyFavoriteDocument();
  }

  /// Retrieves the list of favorite currency codes from the store.
  ///
  /// The optional [sort] parameter can be used to specify whether the list
  /// should be sorted in ascending order.
  /// If [sort] is `true`, the list is sorted. If [sort] is `false` or not
  /// provided, the list is returned as-is.
  ///
  /// Returns a list of currency codes as strings.
  Future<List<String>> retrieveFavorites({bool sort = false}) async {
    final document = await retrieveDocument();
    var favorites = document.favorites;

    if (sort) favorites = [...favorites]..sort();

    return favorites;
  }

  /// Adds a favorite currency code to the store.
  ///
  /// The [currencyCode] parameter specifies the currency code to add.
  ///
  /// Throws an [ArgumentError] if the currency code is empty.
  Future<void> addFavorite(String currencyCode) async {
    if (currencyCode.isEmpty) {
      throw ArgumentError('Currency code cannot be empty');
    }

    final document = await retrieveDocument();
    final existingFavorites = document.favorites;

    // Check if the currency code already exists to prevent duplicates
    if (!existingFavorites.contains(currencyCode)) {
      final newFavorites = [...existingFavorites, currencyCode];

      return persistDocument(document.copyWith(favorites: newFavorites));
    }
  }

  /// Persists a list of favorite currency codes to the store.
  ///
  /// The [favorites] parameter specifies the list of currency codes to persist.
  Future<void> persistFavorites(List<String> favorites) async {
    final document = await retrieveDocument();

    return persistDocument(document.copyWith(favorites: favorites));
  }

  /// Removes a favorite currency code from the store.
  ///
  /// The [currencyCode] parameter specifies the currency code to remove.
  Future<void> removeFavorite(String currencyCode) async {
    final document = await retrieveDocument();

    return persistDocument(
      document.copyWith(
        favorites: document.favorites.where((f) => f != currencyCode).toList(),
      ),
    );
  }

  /// Removes all favorite currency codes from the store.
  Future<void> clearFavorites() async {
    return persistDocument(const MatexCurrencyFavoriteDocument(favorites: []));
  }
}
