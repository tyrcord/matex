import 'package:matex_data/matex_data.dart';

/// Represents a payload for the `MatexCountryBlocEvent`.
///
/// This class holds data related to a list of `MatexCountryMetadata` and
/// an optional JSON data string.
class MatexCountryBlocEventPayload {
  /// A list of metadata related to countries.
  ///
  /// This can be null, meaning that there might be cases where no countries
  /// metadata is provided.
  final List<MatexCountryMetadata>? countries;

  /// A JSON formatted string representing data.
  ///
  /// This can be null, implying that there might be occasions where no JSON
  /// data is provided.
  final String? jsonData;

  /// Creates an instance of the `MatexCountryBlocEventPayload`.
  ///
  /// Both parameters are optional.
  ///
  /// - [countries]: A list of `MatexCountryMetadata` instances.
  /// - [jsonData]: A JSON formatted string.
  MatexCountryBlocEventPayload({
    this.countries,
    this.jsonData,
  });
}
