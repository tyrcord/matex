import 'package:matex_core/core.dart';
import 'package:tbloc/tbloc.dart';

/// Enum representing the different types of events that can be handled by the
/// [MatexUserPreferencesBloc].
enum MatexUserPreferencesBlocEventType {
  load, // Load the user preferences
  loaded, // User preferences have been loaded
  retrieveUserPreferences, // Retrieve the user preferences
  userPreferencesRetrieved, // User preferences have been retrieved
  persitUserPreferences, // Persist the user preferences
  persitUserPreference, // Persist a single user preference
  deleteUserPreferences, // Delete the user preferences
}

/// Event class for the [MatexUserPreferencesBloc].
class MatexUserPreferencesBlocEvent extends BlocEvent<
    MatexUserPreferencesBlocEventType, List<MatexUserPreferenceEntity>> {
  /// Constructor for the [MatexUserPreferencesBlocEvent] that loads the user
  /// preferences.
  const MatexUserPreferencesBlocEvent.load({
    List<MatexUserPreferenceEntity>? userPreferences,
  }) : super(
          type: MatexUserPreferencesBlocEventType.load,
          payload: userPreferences,
        );

  /// Constructor for the [MatexUserPreferencesBlocEvent] that indicates that
  /// the user preferences have been loaded.
  const MatexUserPreferencesBlocEvent.loaded({
    List<MatexUserPreferenceEntity>? userPreferences,
  }) : super(
          type: MatexUserPreferencesBlocEventType.loaded,
          payload: userPreferences,
        );

  /// Constructor for the [MatexUserPreferencesBlocEvent] that retrieves the
  /// user preferences.
  const MatexUserPreferencesBlocEvent.retrieveUserPreferences()
      : super(type: MatexUserPreferencesBlocEventType.retrieveUserPreferences);

  /// Constructor for the [MatexUserPreferencesBlocEvent] that indicates that
  /// the user preferences have been retrieved.
  const MatexUserPreferencesBlocEvent.userPreferencesRetrieved(
    List<MatexUserPreferenceEntity> userPreferences,
  ) : super(
          type: MatexUserPreferencesBlocEventType.userPreferencesRetrieved,
          payload: userPreferences,
        );

  /// Constructor for the [MatexUserPreferencesBlocEvent] that persists the
  /// user preferences.
  const MatexUserPreferencesBlocEvent.persitUserPreferences(
    List<MatexUserPreferenceEntity> userPreferences,
  ) : super(
          type: MatexUserPreferencesBlocEventType.persitUserPreferences,
          payload: userPreferences,
        );

  /// Constructor for the [MatexUserPreferencesBlocEvent] that persists a
  /// single user preference.
  MatexUserPreferencesBlocEvent.persitUserPreference(
    MatexUserPreferenceEntity userPreference,
  ) : super(
          type: MatexUserPreferencesBlocEventType.persitUserPreference,
          payload: [userPreference],
        );

  /// Constructor for the [MatexUserPreferencesBlocEvent] that deletes the user
  /// preferences.
  const MatexUserPreferencesBlocEvent.deleteUserPreferences()
      : super(type: MatexUserPreferencesBlocEventType.deleteUserPreferences);
}
