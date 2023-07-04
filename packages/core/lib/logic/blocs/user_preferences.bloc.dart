// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:tbloc/tbloc.dart';
import 'package:tstore/tstore.dart';

// Project imports:
import 'package:matex_core/core.dart';

/// A bloc that manages user preferences for the Matex app.
class MatexUserPreferencesBloc extends BidirectionalBloc<
    MatexUserPreferencesBlocEvent, MatexUserPreferencesBlocState> {
  late MatexUserPreferencesDataProvider dataProvider;

  static MatexUserPreferencesBloc? _singleton;

  /// Creates a new instance of the bloc.
  ///
  /// If an instance of the bloc already exists and is not closed, it will be
  /// returned instead of creating a new instance.
  factory MatexUserPreferencesBloc({
    MatexUserPreferencesBlocState? initialState,
  }) {
    if (_singleton == null || (_singleton != null && _singleton!.isClosed)) {
      _singleton = MatexUserPreferencesBloc._(initialState: initialState);
    }

    return _singleton!;
  }

  MatexUserPreferencesBloc._({
    MatexUserPreferencesBlocState? initialState,
  }) : super(
          initialState: initialState ?? MatexUserPreferencesBlocState(),
        ) {
    dataProvider = MatexUserPreferencesDataProvider();
  }

  @override
  @mustCallSuper
  void close() {
    if (!closed && canClose()) {
      super.close();
      dataProvider.disconnect();
    }
  }

  @override
  Stream<MatexUserPreferencesBlocState> mapEventToState(
    MatexUserPreferencesBlocEvent event,
  ) async* {
    if (event.type != null) {
      final payload = event.payload;

      switch (event.type!) {
        case MatexUserPreferencesBlocEventType.load:
          yield* handleLoadUserPreferences(payload);
        case MatexUserPreferencesBlocEventType.loaded:
          yield* handleUserPreferencesLoaded(payload);
        case MatexUserPreferencesBlocEventType.retrieveUserPreferences:
          yield* handleRetreiveUserPreferences();
        case MatexUserPreferencesBlocEventType.userPreferencesRetrieved:
          yield* handleUserPreferencesRetrieved(payload);
        case MatexUserPreferencesBlocEventType.persitUserPreferences:
        case MatexUserPreferencesBlocEventType.persitUserPreference:
          yield* handlePersitUserPreferences(payload);
        case MatexUserPreferencesBlocEventType.deleteUserPreferences:
          yield* handleDeleteUserPreferences();
      }
    }
  }

  /// Handles the `load` event.
  ///
  /// Connects to the data provider, listens for changes, and retrieves user
  /// preferences.
  Stream<MatexUserPreferencesBlocState> handleLoadUserPreferences(
    List<MatexUserPreferenceEntity>? preferences,
  ) async* {
    if (canInitialize) {
      isInitializing = true;
      yield currentState.copyWith(isInitializing: isInitializing);
      await dataProvider.connect();

      subxList.add(
        dataProvider.onChanges.listen((TStoreChanges changes) {
          addEvent(
            const MatexUserPreferencesBlocEvent.retrieveUserPreferences(),
          );
        }),
      );

      if (preferences != null) {
        await dataProvider.persistUserPreferences(preferences);
      }

      final userPreferences = await _retrieveUserPreferences();

      addEvent(MatexUserPreferencesBlocEvent.loaded(
        userPreferences: userPreferences,
      ));
    }
  }

  /// Handles the `loaded` event.
  ///
  /// Sets the user preferences and marks the bloc as initialized.
  Stream<MatexUserPreferencesBlocState> handleUserPreferencesLoaded(
    List<MatexUserPreferenceEntity>? preferences,
  ) async* {
    isInitialized = true;

    yield currentState.copyWith(
      userPreferences: preferences ?? const [],
      isInitializing: false,
      isInitialized: true,
    );
  }

  /// Handles the `retrieveUserPreferences` event.
  ///
  /// Retrieves user preferences from the data provider.
  Stream<MatexUserPreferencesBlocState> handleRetreiveUserPreferences() async* {
    final userPreferences = await _retrieveUserPreferences();

    addEvent(MatexUserPreferencesBlocEvent.userPreferencesRetrieved(
      userPreferences,
    ));
  }

  /// Handles the `userPreferencesRetrieved` event.
  ///
  /// Sets the user preferences.
  Stream<MatexUserPreferencesBlocState> handleUserPreferencesRetrieved(
    List<MatexUserPreferenceEntity>? preferences,
  ) async* {
    yield currentState.copyWith(userPreferences: preferences ?? const []);
  }

  /// Handles the `persitUserPreferences` and `persitUserPreference` events.
  ///
  /// Persists user preferences to the data provider.
  Stream<MatexUserPreferencesBlocState> handlePersitUserPreferences(
    List<MatexUserPreferenceEntity>? preferences,
  ) async* {
    await dataProvider.persistUserPreferences(preferences);
  }

  /// Handles the `deleteUserPreferences` event.
  ///
  /// Deletes user preferences from the data provider.
  Stream<MatexUserPreferencesBlocState> handleDeleteUserPreferences() async* {
    await dataProvider.deleteUserPreferences();
  }

  /// Retrieves user preferences from the data provider.
  Future<List<MatexUserPreferenceEntity>> _retrieveUserPreferences() async {
    return dataProvider.listAllUserPreferences();
  }
}
