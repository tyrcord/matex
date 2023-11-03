import 'package:matex_financial/financial.dart';
import 'package:flutter/foundation.dart';
import 'package:tbloc/tbloc.dart';

/// The [MatexInstrumentFavoriteBloc] is a BLoC for managing favorites of
/// financial instruments in a trading app.
class MatexInstrumentFavoriteBloc extends BidirectionalBloc<
    MatexInstrumentFavoriteBlocEvent, MatexInstrumentFavoriteBlocState> {
  static bool _hasBeenInstantiated = false;
  static late MatexInstrumentFavoriteBloc instance;

  /// Initializes a new instance of the [MatexInstrumentFavoriteBloc] class.
  MatexInstrumentFavoriteBloc._({
    MatexInstrumentFavoriteBlocState? initialState,
  }) : super(initialState: initialState ?? MatexInstrumentFavoriteBlocState());

  factory MatexInstrumentFavoriteBloc({
    MatexInstrumentFavoriteBlocState? initialState,
  }) {
    if (!_hasBeenInstantiated) {
      instance = MatexInstrumentFavoriteBloc._(initialState: initialState);
      _hasBeenInstantiated = true;
    }

    return instance;
  }

  List<MatexInstrumentFavorite> get favorites => currentState.favorites;

  bool get hasFavorites => currentState.favorites.isNotEmpty;

  /// Provides access to data source for managing favorites.
  final dataProvider = MatexInstrumentFavoriteDataProvider();

  @override
  @mustCallSuper
  void close() {
    if (!closed && canClose()) {
      super.close();
      dataProvider.disconnect();
    }
  }

  @override
  Stream<MatexInstrumentFavoriteBlocState> mapEventToState(
    MatexInstrumentFavoriteBlocEvent event,
  ) async* {
    if (event.type == null) return;

    final payload = event.payload;
    final type = event.type;

    switch (type!) {
      case MatexInstrumentFavoriteBlocEventType.init:
        yield* handleInitEvent();
      case MatexInstrumentFavoriteBlocEventType.initialized:
        if (payload != null && payload is List<MatexInstrumentFavorite>) {
          yield* handleInitializedEvent(payload);
        }
      case MatexInstrumentFavoriteBlocEventType.add:
        if (payload != null && payload is MatexInstrumentFavorite) {
          yield* handleAddFavorite(payload);
        }
      case MatexInstrumentFavoriteBlocEventType.added:
        if (payload != null && payload is List<MatexInstrumentFavorite>) {
          yield* handleFavoriteAdded(payload);
        }
      case MatexInstrumentFavoriteBlocEventType.remove:
        if (payload != null && payload is MatexInstrumentFavorite) {
          yield* handleRemoveFavorite(payload);
        }
      case MatexInstrumentFavoriteBlocEventType.removeAll:
        yield* handleRemoveAllFavorites();
      case MatexInstrumentFavoriteBlocEventType.removed:
        if (payload != null && payload is List<MatexInstrumentFavorite>) {
          yield* handleFavoriteRemoved(payload);
        }
    }
  }

  /// Handles the 'init' event, which loads the list of favorite instruments
  /// from the data source.
  Stream<MatexInstrumentFavoriteBlocState> handleInitEvent() async* {
    if (canInitialize) {
      isInitializing = true;
      yield currentState.copyWith(isInitializing: isInitializing);
      await dataProvider.connect();

      final favoritesList = await dataProvider.retreiveFavorites();
      addEvent(MatexInstrumentFavoriteBlocEvent.initialized(favoritesList));
    }
  }

  /// Handles the 'isInitialized' event, which sets the list of favorite
  /// instruments in the state after the list has been successfully
  /// loaded from the data source.
  Stream<MatexInstrumentFavoriteBlocState> handleInitializedEvent(
    List<MatexInstrumentFavorite> favorites,
  ) async* {
    if (isInitializing) {
      isInitialized = true;

      yield currentState.copyWith(
        favorites: favorites,
        isInitializing: false,
        isInitialized: true,
      );
    }
  }

  /// Handles the 'add' event, which adds a new favorite instrument to the data
  /// source.
  Stream<MatexInstrumentFavoriteBlocState> handleAddFavorite(
    MatexInstrumentFavorite favorite,
  ) async* {
    await dataProvider.addFavorite(favorite);
    final favoritesList = await dataProvider.retreiveFavorites();

    addEvent(MatexInstrumentFavoriteBlocEvent.added(favoritesList));
  }

  /// Handles the 'added' event, which sets the list of favorite instruments in
  /// the state after a new favorite has been successfully added to the data
  /// source.
  Stream<MatexInstrumentFavoriteBlocState> handleFavoriteAdded(
    List<MatexInstrumentFavorite> favorites,
  ) async* {
    yield currentState.copyWith(favorites: favorites);
  }

  /// Handles the 'remove' event, which removes a favorite instrument from the
  /// data source.
  Stream<MatexInstrumentFavoriteBlocState> handleRemoveFavorite(
    MatexInstrumentFavorite favorite,
  ) async* {
    await dataProvider.removeFavorite(favorite);
    final favoritesList = await dataProvider.retreiveFavorites();

    addEvent(MatexInstrumentFavoriteBlocEvent.removed(favoritesList));
  }

  /// Handles the 'removeAll' event, which removes all favorite instruments from
  /// the data source.
  Stream<MatexInstrumentFavoriteBlocState> handleRemoveAllFavorites() async* {
    await dataProvider.clearFavorites();
    final favoritesList = await dataProvider.retreiveFavorites();

    addEvent(MatexInstrumentFavoriteBlocEvent.removed(favoritesList));
  }

  /// Handles the 'removed' event, which sets the list of favorite instruments
  /// in the state after a favorite has been successfully removed from the data
  /// source.
  Stream<MatexInstrumentFavoriteBlocState> handleFavoriteRemoved(
    List<MatexInstrumentFavorite> favorites,
  ) async* {
    yield currentState.copyWith(favorites: favorites);
  }
}
