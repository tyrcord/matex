// Package imports:
import 'package:tbloc/tbloc.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

/// This class represents the state of a BLoC for managing a list of favorite
/// financial instruments.
class MatexInstrumentFavoriteBlocState extends BlocState {
  /// The list of favorite instruments.
  final List<MatexInstrumentFavorite> favorites;

  /// Create a new instance of the class.
  ///
  /// [favorites]: The list of favorite instruments. Defaults to an empty list.
  /// [isInitializing]: Whether the BLoC is initializing. Defaults to `false`.
  /// [isInitialized]: Whether the BLoC is initialized. Defaults to `false`.
  MatexInstrumentFavoriteBlocState({
    this.favorites = const [],
    super.isInitializing,
    super.isInitialized,
  });

  /// Create a new instance of the class with some or all of its properties
  /// updated.
  ///
  /// [favorites]: The list of favorite instruments. If `null`, use the current
  /// value.
  /// [isInitializing]: Whether the BLoC is initializing. If `null`, use the
  /// current value.
  /// [isInitialized]: Whether the BLoC is initialized. If `null`, use the
  /// current value.
  ///
  /// Returns a new instance of the class with the specified properties updated.
  @override
  MatexInstrumentFavoriteBlocState copyWith({
    List<MatexInstrumentFavorite>? favorites,
    bool? isInitializing,
    bool? isInitialized,
  }) {
    return MatexInstrumentFavoriteBlocState(
      favorites: favorites ?? this.favorites,
      isInitialized: isInitialized ?? this.isInitialized,
      isInitializing: isInitializing ?? this.isInitializing,
    );
  }

  /// A list of objects used to determine if two instances of the class are
  /// equal.
  ///
  /// Returns a list of the [favorites], [isInitializing], and [isInitialized]
  /// properties.
  @override
  List<Object> get props => [favorites, isInitializing, isInitialized];

  /// Create a new instance of the class with the same values as the current
  /// instance.
  ///
  /// Returns a new instance of the class with the same values as the current
  /// instance.
  @override
  MatexInstrumentFavoriteBlocState clone() => copyWith();

  /// Merge two instances of the class.
  ///
  /// [model]: The instance of the class to merge with.
  ///
  /// Returns a new instance of the class with the [favorites],
  /// [isInitializing], and [isInitialized] properties updated to the values of
  /// the [model] instance.
  @override
  MatexInstrumentFavoriteBlocState merge(
    covariant MatexInstrumentFavoriteBlocState model,
  ) {
    return copyWith(
      favorites: model.favorites,
      isInitialized: model.isInitialized,
      isInitializing: model.isInitializing,
    );
  }
}
