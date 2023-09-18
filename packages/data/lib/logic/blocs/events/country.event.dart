import 'package:matex_data/matex_data.dart';
import 'package:tbloc/tbloc.dart';

/// Enum that represents the type of events that can be dispatched to the
/// [MatexCountryBloc].
enum MatexCountryBlocEventType {
  init,
  initialized,
}

/// The [MatexCountryBlocEvent] class is used to represent events that can be
/// dispatched to the [MatexCountryBloc].
///
/// The [MatexCountryBlocEvent] class extends the [BlocEvent] class from the
/// [tbloc] package, and defines two event types: [init] and [initialized].
///
/// The [init] event is used to signal that the bloc should be initialized,
/// while the [initialized] event is used to signal that the bloc has been
/// initialized with a list of [MatexCountryMetadata] objects.
class MatexCountryBlocEvent
    extends BlocEvent<MatexCountryBlocEventType, List<MatexCountryMetadata>> {
  /// Constructs an [init] event for the [MatexCountryBloc].
  const MatexCountryBlocEvent.init()
      : super(type: MatexCountryBlocEventType.init);

  /// Constructs an [initialized] event for the [MatexCountryBloc] with a
  /// payload containing a list of [MatexCountryMetadata] objects.
  const MatexCountryBlocEvent.initialized(
    List<MatexCountryMetadata> countries,
  ) : super(
          type: MatexCountryBlocEventType.initialized,
          payload: countries,
        );
}
