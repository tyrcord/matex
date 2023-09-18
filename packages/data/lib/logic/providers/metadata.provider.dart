// Required imports
import 'package:flutter/foundation.dart';
import 'package:matex_data/matex_data.dart';
import 'package:t_cache/cache_manager.dart';
import 'package:t_helpers/helpers.dart';

/// Abstract data provider class to fetch, parse, cache, and retrieve model
/// data.
///
/// - Generics:
///   - T: The type of data model this provider handles.
abstract class MatexDataProvider<T> {
  /// Default key used for JSON caching.
  static const String _defaultJsonCacheKey = 'data';

  /// Cache manager for raw JSON data.
  late final TCacheManager<Map<String, dynamic>> jsonCache;

  /// Cache manager for the parsed model.
  late final TCacheManager<T> modelCache;

  /// Debug label for this data provider.
  final String debugLabel;

  /// Time to live duration for cached data.
  final Duration ttl;

  /// Constructor for the data provider.
  ///
  /// - Parameters:
  ///   - debugLabel: Optional label for debugging.
  /// Defaults to 'MatexDataProvider'.
  ///   - ttl: Optional time to live duration for cache. Defaults to 1 day.
  MatexDataProvider({
    this.debugLabel = 'MatexDataProvider',
    this.ttl = const Duration(days: 1),
  }) {
    modelCache = TCacheManager<T>(debugLabel: '${debugLabel}ModelCache');
    jsonCache = TCacheManager<Map<String, dynamic>>(
      debugLabel: '${debugLabel}JsonCache',
    );
  }

  /// Abstract method to fetch raw data.
  ///
  /// This method should be implemented by subclasses.
  ///
  /// - Returns: A Future containing raw string data.
  Future<String> fetchData();

  /// Parse the provided JSON data into a model of type T using the given key.
  ///
  /// - Parameters:
  ///   - key: The key associated with the JSON data.
  ///   - jsonData: A Map containing the JSON data to parse.
  ///
  /// - Returns: A parsed model of type T or null if parsing fails.
  T? parse(String key, Map<String, dynamic> jsonData);

  /// Dispose both the model and JSON cache managers.
  void dispose() {
    modelCache.dispose();
    jsonCache.dispose();
  }

  /// Get the model of type T corresponding to the provided key.
  ///
  /// - Parameters:
  ///   - key: The key corresponding to the required data.
  ///
  /// - Returns: A Future containing model of type T or null if not found.
  Future<T?> get(String key) async {
    try {
      final cachedModel = modelCache.get(key);

      if (cachedModel != null) return cachedModel;

      final jsonData = await _fetchData();

      if (jsonData.containsKey(key)) {
        final modelJsonData = jsonData[key];

        if (modelJsonData is Map<String, dynamic>) {
          return _parseModel(key, modelJsonData);
        }
      }
    } catch (error) {
      debugLog('Failed to get $key', value: error);
    }

    return null;
  }

  /// Get all the models of type T.
  ///
  /// - Returns: A Future containing a list of models of type T.
  Future<List<T>> list() async {
    final models = <T>[];
    final jsonData = await _fetchData();

    for (final key in jsonData.keys) {
      if (jsonData[key] is Map<String, dynamic>) {
        final modelJsonData = jsonData[key];

        if (modelJsonData is Map<String, dynamic>) {
          final model = _parseModel(key, modelJsonData);

          if (model != null) {
            models.add(model);
          }
        }
      }
    }

    return models;
  }

  /// Fetch raw JSON data, either from cache or source.
  ///
  /// - Returns: A Future containing the JSON data as a Map.
  Future<Map<String, dynamic>> _fetchData() async {
    final cachedJson = jsonCache.get(_defaultJsonCacheKey);

    if (cachedJson != null) {
      return cachedJson;
    }

    final jsonString = await fetchData();
    final jsonData = await compute(parseMetadataJson, jsonString);

    jsonCache.put(_defaultJsonCacheKey, jsonData, ttl: ttl);

    return jsonData;
  }

  /// Parse and cache the model corresponding to the provided key.
  ///
  /// - Parameters:
  ///   - key: The key corresponding to the required data.
  ///   - jsonData: The JSON data for the provided key.
  ///
  /// - Returns: The parsed model of type T or null if parsing fails.
  T? _parseModel(String key, Map<String, dynamic> jsonData) {
    final model = parse(key, jsonData);
    _cacheModel(key, model);

    return model;
  }

  /// Cache the provided model with the given key.
  ///
  /// - Parameters:
  ///   - key: The key to associate with the cached model.
  ///   - model: The model of type T to cache.
  void _cacheModel(String key, T? model) {
    if (model != null) {
      modelCache.put(key, model, ttl: ttl);
    }
  }
}
