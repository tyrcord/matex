import 'package:matex_dart/matex_dart.dart';
import 'package:matex_financial/financial.dart';
import 'package:tbloc/tbloc.dart';

/// A BLoC (Business Logic Component) class for managing financial instruments.
class MatexInstrumentBloc extends BidirectionalBloc<MatexInstrumentBlocEvent,
    MatexInstrumentBlocState> {
  static MatexInstrumentBloc? _singleton;

  final _instrumentProvider = MatexInstrumentProvider();

  /// Private constructor for enforcing the singleton pattern.
  MatexInstrumentBloc._({MatexInstrumentBlocState? initialState})
      : super(initialState: initialState ?? const MatexInstrumentBlocState());

  /// Factory constructor for creating or retrieving the singleton instance
  /// of [MatexInstrumentBloc].
  factory MatexInstrumentBloc() {
    _singleton ??= MatexInstrumentBloc._();

    return _singleton!;
  }

  @override
  Stream<MatexInstrumentBlocState> mapEventToState(event) async* {
    final payload = event.payload;
    final type = event.type;

    if (type == MatexInstrumentBlocEventType.init) {
      yield* handleInitEvent();
    } else if (type == MatexInstrumentBlocEventType.initialized) {
      yield* handleInitializedEvent(payload);
    } else {
      assert(false, 'MatexInstrumentBloc is not initialized yet.');
    }
  }

  /// Handles the initialization event by fetching instrument metadata and
  /// filtering currencies.
  Stream<MatexInstrumentBlocState> handleInitEvent() async* {
    if (canInitialize) {
      isInitializing = true;
      yield const MatexInstrumentBlocState(isInitializing: true);

      final instrumentsMetadata = await _instrumentProvider.list();
      final instrumentsMetadataList = instrumentsMetadata.values;

      final currencies = instrumentsMetadataList.where(
        (MatexInstrumentMetadata instrumentMetadata) {
          return instrumentMetadata.type.main == 'currency';
        },
      ).toList();

      addEvent(MatexInstrumentBlocEvent.initialized(currencies));
    }
  }

  /// Handles the initialized event by updating the state.
  Stream<MatexInstrumentBlocState> handleInitializedEvent(
    List<MatexInstrumentMetadata>? currencies,
  ) async* {
    if (isInitializing) {
      isInitialized = true;

      yield currentState.copyWith(
        isInitializing: false,
        isInitialized: true,
        currencies: currencies,
      );
    }
  }
}
