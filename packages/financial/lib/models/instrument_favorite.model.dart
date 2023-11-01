import 'package:tmodel/tmodel.dart';

/// This class represents a favorite financial instrument.
///
/// Extends the [TModel] class from the [tmodel] package, which provides basic
/// functionality for immutable objects.
class MatexInstrumentFavorite extends TModel {
  /// The currency code of the counter currency.
  final String counter;

  /// The currency code of the base currency.
  final String base;

  /// Create a new instance of the class.
  ///
  /// [counter]: The currency code of the counter currency.
  /// [base]: The currency code of the base currency.
  const MatexInstrumentFavorite({required this.counter, required this.base});

  /// Create a new instance of the class from a JSON object.
  ///
  /// [json]: The JSON object to create the instance from.
  ///
  /// Returns a new instance of the class with the [counter] and [base]
  /// properties initialized with the values from the JSON object.
  factory MatexInstrumentFavorite.fromJson(Map<dynamic, dynamic> json) {
    return MatexInstrumentFavorite(
      counter: json['counter'] as String,
      base: json['base'] as String,
    );
  }

  /// Convert an instance of the class to a JSON object.
  ///
  /// Returns a `Map<String, dynamic>` object with the [counter] and [base]
  /// properties.
  Map<String, dynamic> toJson() => {'counter': counter, 'base': base};

  /// Create a new instance of the class with some or all of its properties
  /// updated.
  ///
  /// [counter]: The currency code of the counter currency. If `null`, use the
  /// current value.
  /// [base]: The currency code of the base currency. If `null`, use the current
  /// value.
  ///
  /// Returns a new instance of the class with the specified properties updated.
  @override
  MatexInstrumentFavorite copyWith({String? counter, String? base}) {
    return MatexInstrumentFavorite(
      counter: counter ?? this.counter,
      base: base ?? this.base,
    );
  }

  /// Create a new instance of the class with the same values as the current
  /// instance.
  ///
  /// Returns a new instance of the class with the same values as the current
  /// instance.
  @override
  MatexInstrumentFavorite clone() => copyWith();

  /// Merge two instances of the class.
  ///
  /// [model]: The instance of the class to merge with.
  ///
  /// Returns a new instance of the class with the [counter] and [base]
  /// properties updated to the values of the [model] instance.
  @override
  MatexInstrumentFavorite merge(covariant MatexInstrumentFavorite model) {
    return MatexInstrumentFavorite(counter: model.counter, base: model.base);
  }

  /// A list of objects used to determine if two instances of the class are
  /// equal.
  ///
  /// Returns a list of the [counter] and [base] properties.
  @override
  List<Object?> get props => [counter, base];
}
