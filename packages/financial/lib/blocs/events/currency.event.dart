// Package imports:
import 'package:matex_dart/matex_dart.dart';
import 'package:tbloc/tbloc.dart';

enum MatexCurrencyBlocEventType {
  init,
  initialized,
}

/// The [MatexCurrencyBlocEvent] class is used to represent events that can be
/// dispatched to the [MatexCurrencyBloc].
///
/// The [MatexCurrencyBlocEvent] class extends the [BlocEvent] class from the
/// [tbloc] package, and defines two event types: [init] and [initialized].
///
/// The [init] event is used to signal that the bloc should be initialized,
/// while the [initialized] event is used to signal that the bloc has been
/// initialized with a list of [MatexInstrumentMetadata] objects.
class MatexCurrencyBlocEvent extends BlocEvent<MatexCurrencyBlocEventType,
    List<MatexInstrumentMetadata>> {
  const MatexCurrencyBlocEvent.init()
      : super(type: MatexCurrencyBlocEventType.init);

  const MatexCurrencyBlocEvent.initialized(
    List<MatexInstrumentMetadata> currencies,
  ) : super(
          type: MatexCurrencyBlocEventType.initialized,
          payload: currencies,
        );
}
