import 'package:matex_dart/matex_dart.dart';
import 'package:matex_financial/financial.dart';
import 'package:tbloc/tbloc.dart';

/// A BLoC (Business Logic Component) class for managing financial instruments.
class MatexCurrencyBloc
    extends BidirectionalBloc<MatexCurrencyBlocEvent, MatexCurrencyBlocState> {
  static MatexCurrencyBloc? _singleton;

  final _instrumentProvider = MatexInstrumentProvider();

  /// Private constructor for enforcing the singleton pattern.
  MatexCurrencyBloc._({MatexCurrencyBlocState? initialState})
      : super(initialState: initialState ?? MatexCurrencyBlocState());

  /// Factory constructor for creating or retrieving the singleton instance
  /// of [MatexCurrencyBloc].
  factory MatexCurrencyBloc() {
    _singleton ??= MatexCurrencyBloc._();

    return _singleton!;
  }

  @override
  Stream<MatexCurrencyBlocState> mapEventToState(event) async* {
    final payload = event.payload;
    final type = event.type;

    if (type == MatexCurrencyBlocEventType.init) {
      yield* handleInitEvent();
    } else if (type == MatexCurrencyBlocEventType.initialized) {
      yield* handleInitializedEvent(payload);
    } else {
      assert(false, 'MatexCurrencyBloc is not initialized yet.');
    }
  }

  /// Handles the initialization event by fetching instrument metadata and
  /// filtering currencies.
  Stream<MatexCurrencyBlocState> handleInitEvent() async* {
    if (canInitialize) {
      isInitializing = true;
      yield MatexCurrencyBlocState(isInitializing: true);

      final instrumentsMetadata = await _instrumentProvider.list();
      final instrumentsMetadataList = instrumentsMetadata.values;

      final currencies = instrumentsMetadataList.where(
        (MatexInstrumentMetadata instrumentMetadata) {
          return instrumentMetadata.type.main == 'currency';
        },
      ).toList();

      addEvent(MatexCurrencyBlocEvent.initialized(currencies));
    }
  }

  /// Handles the initialized event by updating the state.
  Stream<MatexCurrencyBlocState> handleInitializedEvent(
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
