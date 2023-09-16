import 'package:tmodel/tmodel.dart';

/// Represents metadata associated with a country, such as VAT rates and
/// currency.
///
/// Provides functionality to handle metadata like VAT rates and currency.
/// It also allows for cloning, copying with modifications, and merging
/// operations.
class MatexCountryMetadata extends TModel {
  /// A list of VAT rates applicable in the country.
  final List<double>? vatRates;

  /// Currency used in the country.
  final String currency;

  /// Constructs a country's metadata.
  ///
  /// [currency] is required and must be a non-empty string.
  /// [vatRates] is optional and represents the VAT rates in the country.
  const MatexCountryMetadata({
    required this.currency,
    this.vatRates,
  });

  /// Creates a [MatexCountryMetadata] instance from a JSON map.
  ///
  /// Throws [ArgumentError] if [currency] is either null, not a string,
  /// or an empty string.
  /// Converts the raw VAT rates into a list of doubles.
  factory MatexCountryMetadata.fromJson(Map<String, dynamic> json) {
    final currency = json['currency'];
    final rawVateRates = json['vatRates'];
    List<double>? vatRates;

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

    return MatexCountryMetadata(currency: currency, vatRates: vatRates);
  }

  /// Returns a cloned instance of the current object.
  @override
  MatexCountryMetadata clone() => copyWith();

  /// Returns a copy of the current object with modified properties.
  ///
  /// [vatRates] and [currency] are optional and will use the current values
  /// if not provided.
  @override
  MatexCountryMetadata copyWith({
    List<double>? vatRates,
    String? currency,
  }) {
    return MatexCountryMetadata(
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
      currency: model.currency,
      vatRates: model.vatRates ?? vatRates,
    );
  }

  /// Represents the properties used for identifying the uniqueness of
  /// the object.
  ///
  /// Useful when comparing two instances of the class.
  @override
  List<Object?> get props => [currency, vatRates];
}
