// Import the required packages.

// Package imports:
import 'package:tbloc/tbloc.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

/// Define an enumeration for the different types of events that can occur in
/// the [MatexInstrumentFavoriteBloc].
enum MatexInstrumentFavoriteBlocEventType {
  init, // Indicates that the favorites should be loaded from storage.
  initialized, // Indicates that the favorites have been loaded from storage.
  add, // Indicates that a new favorite should be added to the list.
  added, // Indicates that a new favorite has been added to the list.
  remove, // Indicates that a favorite should be removed from the list.
  removeAll, // Indicates that all favorites should be removed from the list.
  removed, // Indicates that a favorite has been removed from the list.
}

// Define a class to represent an event in the BLoC.
class MatexInstrumentFavoriteBlocEvent
    extends BlocEvent<MatexInstrumentFavoriteBlocEventType, dynamic> {
  // Define constructor for the `load` event type, which has no payload.
  const MatexInstrumentFavoriteBlocEvent.init()
      : super(type: MatexInstrumentFavoriteBlocEventType.init);

  // Define constructor for the `loaded` event type, which takes a list of
  // favorites as its payload.
  const MatexInstrumentFavoriteBlocEvent.initialized(
    List<MatexInstrumentFavorite> favorites,
  ) : super(
          type: MatexInstrumentFavoriteBlocEventType.initialized,
          payload: favorites,
        );

  // Define constructor for the `add` event type, which takes a favorite as
  // its payload.
  const MatexInstrumentFavoriteBlocEvent.add(
    MatexInstrumentFavorite favorite,
  ) : super(
          type: MatexInstrumentFavoriteBlocEventType.add,
          payload: favorite,
        );

  // Define constructor for the `added` event type, which takes a list of
  // favorites as its payload.
  const MatexInstrumentFavoriteBlocEvent.added(
    List<MatexInstrumentFavorite> favorites,
  ) : super(
          type: MatexInstrumentFavoriteBlocEventType.added,
          payload: favorites,
        );

  // Define constructor for the `remove` event type, which takes a favorite as
  // its payload.
  const MatexInstrumentFavoriteBlocEvent.remove(
    MatexInstrumentFavorite favorite,
  ) : super(
          type: MatexInstrumentFavoriteBlocEventType.remove,
          payload: favorite,
        );

  // Define constructor for the `removed` event type, which takes a list of
  // favorites as its payload.
  const MatexInstrumentFavoriteBlocEvent.removed(
    List<MatexInstrumentFavorite> favorites,
  ) : super(
          type: MatexInstrumentFavoriteBlocEventType.removed,
          payload: favorites,
        );

  // Define constructor for the `removeAll` event type, which has no payload.
  const MatexInstrumentFavoriteBlocEvent.removeAll()
      : super(type: MatexInstrumentFavoriteBlocEventType.removeAll);
}
