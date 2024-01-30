// Import the required packages.

// Package imports:
import 'package:tbloc/tbloc.dart';

/// Event types for the [MatexCurrencyFavoriteBloc].
enum MatexCurrencyFavoriteBlocEventType {
  init,
  initialized,
  add,
  added,
  remove,
  removeAll,
  removed,
}

/// Event class for the [MatexCurrencyFavoriteBloc].
class MatexCurrencyFavoriteBlocEvent
    extends BlocEvent<MatexCurrencyFavoriteBlocEventType, dynamic> {
  // Define constructor for the `load` event type, which has no payload.
  const MatexCurrencyFavoriteBlocEvent.init()
      : super(type: MatexCurrencyFavoriteBlocEventType.init);

  // Define constructor for the `loaded` event type, which takes a list of
  // favorites as its payload.
  const MatexCurrencyFavoriteBlocEvent.initialized(List<String> favorites)
      : super(
          type: MatexCurrencyFavoriteBlocEventType.initialized,
          payload: favorites,
        );

  // Define constructor for the `add` event type, which takes a favorite as
  // its payload.
  const MatexCurrencyFavoriteBlocEvent.add(String favorite)
      : super(type: MatexCurrencyFavoriteBlocEventType.add, payload: favorite);

  // Define constructor for the `added` event type, which takes a list of
  // favorites as its payload.
  const MatexCurrencyFavoriteBlocEvent.added(
    List<String> favorites,
  ) : super(type: MatexCurrencyFavoriteBlocEventType.added, payload: favorites);

  // Define constructor for the `remove` event type, which takes a favorite as
  // its payload.
  const MatexCurrencyFavoriteBlocEvent.remove(
    String favorite,
  ) : super(type: MatexCurrencyFavoriteBlocEventType.remove, payload: favorite);

  // Define constructor for the `removeAll` event type, which has no payload.
  const MatexCurrencyFavoriteBlocEvent.removeAll()
      : super(type: MatexCurrencyFavoriteBlocEventType.removeAll);

  // Define constructor for the `removed` event type, which takes a list of
  // favorites as its payload.
  const MatexCurrencyFavoriteBlocEvent.removed(
    List<String> favorites,
  ) : super(
          type: MatexCurrencyFavoriteBlocEventType.removed,
          payload: favorites,
        );

  // Define constructor for the `removeAll` event type, which has no payload.
  const MatexCurrencyFavoriteBlocEvent.clear()
      : super(type: MatexCurrencyFavoriteBlocEventType.removeAll);

  // Define constructor for the `removed` event type, which takes a list of
  // favorites as its payload.
  const MatexCurrencyFavoriteBlocEvent.cleared(
    List<String> favorites,
  ) : super(
          type: MatexCurrencyFavoriteBlocEventType.removed,
          payload: favorites,
        );
}
