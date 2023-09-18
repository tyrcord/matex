import 'package:matex_data/matex_data.dart';
import 'package:tbloc/tbloc.dart';

/// Represents a Bidirectional Bloc (Business Logic Component) for managing
/// country metadata.
class MatexCountryBloc
    extends BidirectionalBloc<MatexCountryBlocEvent, MatexCountryBlocState> {
  static MatexCountryBloc? _singleton;
  late final MatexCountryDataProvider _countryProvider;

  /// A private constructor to enforce the singleton pattern. Initializes the
  /// BLoC with an optional [initialState] and a JSON string [jsonData] for
  /// country data.
  MatexCountryBloc._({
    MatexCountryBlocState? initialState,
    String? jsonData,
  }) : super(initialState: initialState ?? MatexCountryBlocState()) {
    _countryProvider = MatexCountryDataProvider(jsonData: jsonData);
  }

  /// Factory constructor to provide a singleton instance of the
  /// [MatexCountryBloc]. If an instance doesn't exist, it will be created.
  factory MatexCountryBloc({
    String? jsonData,
    MatexCountryBlocState? initialState,
  }) {
    _singleton ??= MatexCountryBloc._(
      initialState: initialState,
      jsonData: jsonData,
    );

    return _singleton!;
  }

  /// Maps incoming [MatexCountryBlocEvent] to corresponding
  /// [MatexCountryBlocState].
  /// Processes events and updates states accordingly.
  @override
  Stream<MatexCountryBlocState> mapEventToState(event) async* {
    final payload = event.payload;
    final type = event.type;

    if (type == MatexCountryBlocEventType.init) {
      yield* handleInitEvent();
    } else if (type == MatexCountryBlocEventType.initialized) {
      yield* handleInitializedEvent(payload);
    } else {
      assert(false, 'MatexCountryBloc is not initialized yet.');
    }
  }

  /// Processes the initialization event. It fetches country metadata and
  /// triggers the initialized event.
  Stream<MatexCountryBlocState> handleInitEvent() async* {
    if (canInitialize) {
      isInitializing = true;
      yield MatexCountryBlocState(isInitializing: true);

      final countries = await _countryProvider.list();

      addEvent(MatexCountryBlocEvent.initialized(countries));
    }
  }

  /// Handles the initialized event by setting the provided country metadata
  /// [countries] to the state.
  Stream<MatexCountryBlocState> handleInitializedEvent(
    List<MatexCountryMetadata>? countries,
  ) async* {
    if (isInitializing) {
      isInitialized = true;

      yield currentState.copyWith(
        isInitializing: false,
        isInitialized: true,
        countries: countries,
      );
    }
  }
}
