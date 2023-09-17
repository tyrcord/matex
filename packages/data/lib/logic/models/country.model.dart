import 'package:tmodel/tmodel.dart';

/// Represents metadata associated with a country, such as VAT rates and
/// currency.
///
/// Provides functionality to handle metadata like VAT rates and currency.
/// It also allows for cloning, copying with modifications, and merging
/// operations.
class MatexCountryMetadata extends TModel {
  /// Identifier for the metadata.
  final String id;

  /// A list of VAT rates applicable in the country.
  final List<double>? vatRates;

  /// Currency used in the country.
  final String currency;

  /// Constructs a country's metadata.
  ///
  /// [id] and [currency] are required and must be non-empty strings.
  /// [vatRates] is optional and represents the VAT rates in the country.
  const MatexCountryMetadata({
    required this.id,
    required this.currency,
    this.vatRates,
  });

  /// Creates a [MatexCountryMetadata] instance from a JSON map.
  ///
  /// Throws [ArgumentError] if [id] or [currency] is either null, not a string,
  /// or an empty string.
  /// Converts the raw VAT rates into a list of doubles.
  factory MatexCountryMetadata.fromJson(String id, Map<String, dynamic> json) {
    final currency = json['currency'];
    final rawVateRates = json['vatRates'];
    List<double>? vatRates;

    if (id.isEmpty) {
      throw ArgumentError.value(
        id,
        'id',
        'Must be a non-empty string.',
      );
    }

    if (currency == null || currency is! String || currency.isEmpty) {
      throw ArgumentError.value(
        currency,
        'currency',
        'Must be a non-empty string.',
      );
    }

    if (rawVateRates != null && rawVateRates is List) {
      vatRates = rawVateRates
          .whereType<num>()
          .map((value) => value.toDouble())
          .toList();
    }

    return MatexCountryMetadata(id: id, currency: currency, vatRates: vatRates);
  }

  /// Returns a cloned instance of the current object.
  @override
  MatexCountryMetadata clone() => copyWith();

  /// Returns a copy of the current object with modified properties.
  ///
  /// [id], [vatRates], and [currency] are optional and will use the current
  /// values if not provided.
  @override
  MatexCountryMetadata copyWith({
    String? id,
    List<double>? vatRates,
    String? currency,
  }) {
    return MatexCountryMetadata(
      id: id ?? this.id,
      currency: currency ?? this.currency,
      vatRates: vatRates ?? this.vatRates,
    );
  }

  /// Merges the current object with another [MatexCountryMetadata] model.
  ///
  /// Prioritizes the properties of the provided [model] unless they're null,
  /// then it uses the current properties.
  @override
  MatexCountryMetadata merge(covariant MatexCountryMetadata model) {
    return MatexCountryMetadata(
      id: model.id,
      currency: model.currency,
      vatRates: model.vatRates ?? vatRates,
    );
  }

  /// Represents the properties used for identifying the uniqueness of
  /// the object.
  ///
  /// Useful when comparing two instances of the class.
  @override
  List<Object?> get props => [id, currency, vatRates];
}
