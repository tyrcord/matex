import 'package:collection/collection.dart' show IterableExtension;
import 'package:matex_core/core.dart';
import 'package:tstore/tstore.dart';

/// A data provider class for user preferences.
class MatexUserPreferencesDataProvider extends TDataProvider {
  static const kStoreName = 'matexUserPreferences';

  /// Creates a new instance of [MatexUserPreferencesDataProvider].
  ///
  /// [storeName] is an optional parameter that specifies the name of the
  /// store to use. If not provided, the default store name will be used.
  MatexUserPreferencesDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? kStoreName);

  /// Returns a list of all user preferences.
  ///
  /// Each user preference is represented by a [MatexUserPreferenceEntity]
  /// object.
  Future<List<MatexUserPreferenceEntity>> listAllUserPreferences() async {
    final rawList = await store.list<Map<dynamic, dynamic>>();

    return rawList.map((Map<dynamic, dynamic> raw) {
      final json = Map<String, dynamic>.from(raw);

      return MatexUserPreferenceEntity.fromJson(json);
    }).toList();
  }

  /// Persists a user preference to the data store.
  ///
  /// [model] is the user preference to persist.
  Future<void> persistUserPreference(MatexUserPreferenceEntity model) async {
    return store.persist(model.key, model.toJson());
  }

  /// Persists a list of user preferences to the data store.
  ///
  /// [models] is the list of user preferences to persist.
  Future<void> persistUserPreferences(
    List<MatexUserPreferenceEntity>? models,
  ) async {
    if (models != null) {
      for (final model in models) {
        await persistUserPreference(model);
      }
    }
  }

  /// Finds a user preference by name.
  ///
  /// [name] is the name of the user preference to find.
  ///
  /// Returns the [MatexUserPreferenceEntity] object representing the user
  /// preference, or null if no user preference with the given name was found.
  Future<MatexUserPreferenceEntity?> findPreferenceByName(String name) async {
    final models = await listAllUserPreferences();

    return models.firstWhereOrNull((model) => model.key == name);
  }

  /// Deletes all user preferences from the data store.
  Future<void> deleteUserPreferences() => store.clear();
}
