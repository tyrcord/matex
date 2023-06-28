import 'package:matex_dart/matex_dart.dart';
import 'package:tbloc/tbloc.dart';

enum MatexInstrumentBlocEventType {
  init,
  initialized,
}

/// The [MatexInstrumentBlocEvent] class is used to represent events that can be
/// dispatched to the [MatexInstrumentBloc].
///
/// The [MatexInstrumentBlocEvent] class extends the [BlocEvent] class from the
/// [tbloc] package, and defines two event types: [init] and [initialized].
///
/// The [init] event is used to signal that the bloc should be initialized,
/// while the [initialized] event is used to signal that the bloc has been
/// initialized with a list of [MatexInstrumentMetadata] objects.
class MatexInstrumentBlocEvent extends BlocEvent<MatexInstrumentBlocEventType,
    List<MatexInstrumentMetadata>> {
  const MatexInstrumentBlocEvent.init()
      : super(type: MatexInstrumentBlocEventType.init);

  const MatexInstrumentBlocEvent.initialized(
    List<MatexInstrumentMetadata> currencies,
  ) : super(
          type: MatexInstrumentBlocEventType.initialized,
          payload: currencies,
        );
}
