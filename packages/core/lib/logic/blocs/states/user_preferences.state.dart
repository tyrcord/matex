// Package imports:
import 'package:collection/collection.dart' show IterableExtension;
import 'package:tbloc/tbloc.dart';

// Project imports:
import 'package:matex_core/core.dart';

/// The state of the MatexUserPreferencesBloc.
class MatexUserPreferencesBlocState extends BlocState {
  /// The list of user preferences.
  final List<MatexUserPreferenceEntity>? userPreferences;

  /// Creates a new instance of the [MatexUserPreferencesBlocState].
  const MatexUserPreferencesBlocState({
    bool isInitialized = false,
    bool isInitializing = false,
    this.userPreferences,
  }) : super(isInitialized: isInitialized, isInitializing: isInitializing);

  @override
  MatexUserPreferencesBlocState clone() => copyWith();

  @override
  MatexUserPreferencesBlocState copyWith({
    List<MatexUserPreferenceEntity>? userPreferences,
    bool? isInitialized,
    bool? isInitializing,
  }) {
    return MatexUserPreferencesBlocState(
      isInitialized: isInitialized ?? this.isInitialized,
      isInitializing: isInitializing ?? this.isInitializing,
      userPreferences: userPreferences ?? this.userPreferences,
    );
  }

  /// Gets the user preference with the specified key.
  MatexUserPreferenceEntity? getUserPreference(String key) {
    return userPreferences?.firstWhereOrNull((model) => model.key == key);
  }

  @override
  MatexUserPreferencesBlocState merge(
    covariant MatexUserPreferencesBlocState model,
  ) {
    return copyWith(
      isInitialized: model.isInitialized,
      isInitializing: model.isInitializing,
      userPreferences: model.userPreferences,
    );
  }

  @override
  List<Object?> get props => [userPreferences, isInitialized, isInitializing];
}
