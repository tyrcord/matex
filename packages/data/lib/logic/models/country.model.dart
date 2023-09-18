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

  /// The country's code.
  final String code;

  /// Constructs a country's metadata.
  ///
  /// [id], [currency], and [code] are required and must be non-empty strings.
  /// [vatRates] is optional and represents the VAT rates in the country.
  const MatexCountryMetadata({
    required this.id,
    required this.currency,
    required this.code,
    this.vatRates,
  });

  /// Creates a [MatexCountryMetadata] instance from a JSON map.
  ///
  /// Throws [ArgumentError] if [id], [currency], or [code] is either null,
  /// not a string, or an empty string.
  /// Converts the raw VAT rates into a list of doubles.
  factory MatexCountryMetadata.fromJson(String id, Map<String, dynamic> json) {
    final rawVateRates = json['vatRates'];
    final currency = json['currency'];
    final code = json['code'];
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

    if (code == null || code is! String || code.isEmpty) {
      throw ArgumentError.value(
        code,
        'code',
        'Must be a non-empty string.',
      );
    }

    if (rawVateRates != null && rawVateRates is List) {
      vatRates = rawVateRates
          .whereType<num>()
          .map((value) => value.toDouble())
          .toList();
    }

    return MatexCountryMetadata(
      vatRates: vatRates,
      currency: currency,
      code: code,
      id: id,
    );
  }

  /// Returns a cloned instance of the current object.
  @override
  MatexCountryMetadata clone() => copyWith();

  /// Returns a copy of the current object with modified properties.
  ///
  /// [id], [vatRates], [currency], and [code] are optional and will use
  /// the current values if not provided.
  @override
  MatexCountryMetadata copyWith({
    List<double>? vatRates,
    String? currency,
    String? code,
    String? id,
  }) {
    return MatexCountryMetadata(
      currency: currency ?? this.currency,
      vatRates: vatRates ?? this.vatRates,
      code: code ?? this.code,
      id: id ?? this.id,
    );
  }

  /// Merges the current object with another [MatexCountryMetadata] model.
  ///
  /// Prioritizes the properties of the provided [model] unless they're null,
  /// then it uses the current properties.
  @override
  MatexCountryMetadata merge(covariant MatexCountryMetadata model) {
    return MatexCountryMetadata(
      vatRates: model.vatRates ?? vatRates,
      currency: model.currency,
      code: model.code,
      id: model.id,
    );
  }

  /// Represents the properties used for identifying the uniqueness of
  /// the object.
  ///
  /// Useful when comparing two instances of the class.
  @override
  List<Object?> get props => [id, currency, code, vatRates];
}
