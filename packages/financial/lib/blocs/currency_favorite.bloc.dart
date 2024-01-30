import 'package:flutter/foundation.dart';
import 'package:matex_financial/financial.dart';
import 'package:tbloc/tbloc.dart';

/// The [MatexCurrencyFavoriteBloc] is a BLoC for managing favorite currencies
/// in a trading app.
class MatexCurrencyFavoriteBloc extends BidirectionalBloc<
    MatexCurrencyFavoriteBlocEvent, MatexCurrencyFavoriteBlocState> {
  static bool _hasBeenInstantiated = false;
  static late MatexCurrencyFavoriteBloc instance;

  /// Initializes a new instance of the [MatexCurrencyFavoriteBloc] class.
  MatexCurrencyFavoriteBloc._({
    MatexCurrencyFavoriteBlocState? initialState,
  }) : super(initialState: initialState ?? MatexCurrencyFavoriteBlocState());

  factory MatexCurrencyFavoriteBloc({
    MatexCurrencyFavoriteBlocState? initialState,
  }) {
    if (!_hasBeenInstantiated) {
      instance = MatexCurrencyFavoriteBloc._(initialState: initialState);
      _hasBeenInstantiated = true;
    }

    return instance;
  }

  List<String> get favorites => currentState.favorites;

  bool get hasFavorites => currentState.favorites.isNotEmpty;

  /// Provides access to data source for managing favorite currencies.
  final dataProvider = MatexCurrencyFavoriteDataProvider();

  @override
  @mustCallSuper
  void close() {
    if (!closed && canClose()) {
      super.close();
      dataProvider.disconnect();
    }
  }

  @override
  Stream<MatexCurrencyFavoriteBlocState> mapEventToState(
    MatexCurrencyFavoriteBlocEvent event,
  ) async* {
    if (event.type == null) return;

    final type = event.type;
    final payload = event.payload;

    switch (type!) {
      case MatexCurrencyFavoriteBlocEventType.init:
        yield* handleInitEvent();
      case MatexCurrencyFavoriteBlocEventType.initialized:
        if (payload != null && payload is List<String>) {
          yield* handleInitializedEvent(payload);
        }
      case MatexCurrencyFavoriteBlocEventType.add:
        if (payload != null && payload is String) {
          yield* handleAddFavorite(payload);
        }
      case MatexCurrencyFavoriteBlocEventType.added:
        if (payload != null && payload is List<String>) {
          yield* handleFavoriteAdded(payload);
        }
      case MatexCurrencyFavoriteBlocEventType.remove:
        if (payload != null && payload is String) {
          yield* handleRemoveFavorite(payload);
        }
      case MatexCurrencyFavoriteBlocEventType.removeAll:
        yield* handleRemoveAllFavorites();
      case MatexCurrencyFavoriteBlocEventType.removed:
        if (payload != null && payload is List<String>) {
          yield* handleFavoriteRemoved(payload);
        }
    }
  }

// Event handlers implementation for CurrencyFavoriteBloc

  /// Handles the 'init' event, which loads the list of favorite currency codes
  /// from the data source.
  Stream<MatexCurrencyFavoriteBlocState> handleInitEvent() async* {
    if (canInitialize) {
      isInitializing = true;
      yield currentState.copyWith(isInitializing: isInitializing);
      await dataProvider.connect();

      final favoritesList = await dataProvider.retrieveFavorites();
      addEvent(MatexCurrencyFavoriteBlocEvent.initialized(favoritesList));
    }
  }

  /// Handles the 'initialized' event, which sets the list of favorite currency
  /// codes in the state after the list has been successfully loaded from the
  /// data source.
  Stream<MatexCurrencyFavoriteBlocState> handleInitializedEvent(
    List<String> favorites,
  ) async* {
    if (isInitializing) {
      isInitialized = true;

      yield currentState.copyWith(
        isInitializing: false,
        favorites: favorites,
        isInitialized: true,
      );
    }
  }

  /// Handles the 'add' event, which adds a new favorite currency code to
  /// the data source.
  Stream<MatexCurrencyFavoriteBlocState> handleAddFavorite(
    String currencyCode,
  ) async* {
    await dataProvider.addFavorite(currencyCode);
    final favoritesList = await dataProvider.retrieveFavorites();

    addEvent(MatexCurrencyFavoriteBlocEvent.added(favoritesList));
  }

  /// Handles the 'added' event, which updates the list of favorite currency
  /// codes in the state after a new favorite has been successfully added to
  /// the data source.
  Stream<MatexCurrencyFavoriteBlocState> handleFavoriteAdded(
    List<String> favorites,
  ) async* {
    yield currentState.copyWith(favorites: favorites);
  }

  /// Handles the 'remove' event, which removes a favorite currency code from
  /// the data source.
  Stream<MatexCurrencyFavoriteBlocState> handleRemoveFavorite(
    String currencyCode,
  ) async* {
    await dataProvider.removeFavorite(currencyCode);
    final favoritesList = await dataProvider.retrieveFavorites();

    addEvent(MatexCurrencyFavoriteBlocEvent.removed(favoritesList));
  }

  /// Handles the 'removeAll' event, which removes all favorite currency codes
  /// from the data source.
  Stream<MatexCurrencyFavoriteBlocState> handleRemoveAllFavorites() async* {
    await dataProvider.clearFavorites();
    final favoritesList = await dataProvider.retrieveFavorites();

    addEvent(MatexCurrencyFavoriteBlocEvent.removed(favoritesList));
  }

  /// Handles the 'removed' event, which updates the list of favorite currency
  /// codes in the state after a favorite has been successfully removed from the
  /// data source.
  Stream<MatexCurrencyFavoriteBlocState> handleFavoriteRemoved(
    List<String> favorites,
  ) async* {
    yield currentState.copyWith(favorites: favorites);
  }
}
