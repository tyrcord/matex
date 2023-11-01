// Flutter imports:
import 'package:flutter/services.dart';

// Project imports:
import 'package:matex_data/matex_data.dart';

/// Constant representing the default asset path for country metadata.
const _kAssetPath = 'packages/matex_data/assets/meta/country.json';

/// A class that provides data related to countries by extending
/// [MatexDataProvider] for [MatexCountryMetadata].
///
/// It supports fetching data from a provided JSON string or
/// from the default asset path.
class MatexCountryDataProvider extends MatexDataProvider<MatexCountryMetadata> {
  /// An optional JSON string representing country data. If this is provided,
  /// the provider will use it directly instead of fetching from the asset.
  final String? jsonData;

  /// Creates an instance of [MatexCountryDataProvider].
  ///
  /// [jsonData] is an optional parameter, representing country data in JSON.
  MatexCountryDataProvider({
    this.jsonData,
  });

  /// Fetches country data.
  ///
  /// If [jsonData] is provided during class instantiation, it will be returned.
  /// Otherwise, the data is fetched from the default asset path.
  ///
  /// Returns a [Future] that completes with the country data in a string
  /// format.
  @override
  Future<String> fetchData() async {
    if (jsonData != null && jsonData!.isNotEmpty) {
      return jsonData!;
    }

    return rootBundle.loadString(_kAssetPath);
  }

  /// Parses the provided JSON data to return a [MatexCountryMetadata] object.
  ///
  /// [jsonData] is the Map representation of the JSON data.
  @override
  MatexCountryMetadata parse(String key, Map<String, dynamic> jsonData) {
    return MatexCountryMetadata.fromJson(key, jsonData);
  }
}
