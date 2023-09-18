import 'package:matex_data/matex_data.dart';
import 'package:tbloc/tbloc.dart';

/// Represents the state for `MatexCountryBloc` which manages country data.
class MatexCountryBlocState extends BlocState {
  /// Holds the metadata about countries.
  final List<MatexCountryMetadata> countries;

  /// Constructs a `MatexCountryBlocState` with given properties.
  ///
  /// - [countries] specifies the list of countries this state should hold.
  ///   Defaults to an empty list if not provided.
  MatexCountryBlocState({
    List<MatexCountryMetadata>? countries,
    super.isInitializing = false,
    super.isInitialized = false,
  }) : countries = countries ?? const [];

  /// Creates a copy of this state but with the given fields replaced with the
  /// new values. If a value is not provided, it defaults to the current value.
  @override
  MatexCountryBlocState copyWith({
    List<MatexCountryMetadata>? countries,
    bool? isInitializing,
    bool? isInitialized,
  }) {
    return MatexCountryBlocState(
      countries: countries ?? this.countries,
      isInitialized: isInitialized ?? this.isInitialized,
      isInitializing: isInitializing ?? this.isInitializing,
    );
  }

  /// Creates a new instance of `MatexCountryBlocState` with same properties.
  @override
  MatexCountryBlocState clone() => copyWith();

  /// Merges the given [model] into this state by overwriting properties.
  @override
  MatexCountryBlocState merge(covariant MatexCountryBlocState model) {
    return copyWith(
      countries: model.countries,
      isInitialized: model.isInitialized,
      isInitializing: model.isInitializing,
    );
  }

  /// Returns a list of properties which are used for comparison.
  @override
  List<Object> get props => [
        countries,
        isInitializing,
        isInitialized,
      ];
}
