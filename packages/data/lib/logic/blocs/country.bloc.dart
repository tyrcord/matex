import 'package:matex_data/matex_data.dart';
import 'package:tbloc/tbloc.dart';

/// Represents a Bidirectional Bloc (Business Logic Component) for managing
/// country metadata.
class MatexCountryBloc
    extends BidirectionalBloc<MatexCountryBlocEvent, MatexCountryBlocState> {
  // Static instance of the Bloc.
  static late MatexCountryBloc instance;

  // Boolean to determine if the Bloc instance has been created.
  static bool _hasBeenInstantiated = false;

  // Provider for country data interactions.
  late final MatexCountryDataProvider _countryProvider;

  // The JSON data representing country metadata.
  String? jsonData;

  /// A private constructor to enforce the singleton pattern. Initializes the
  /// BLoC with an optional [initialState] and a JSON string [jsonData] for
  /// country data.
  MatexCountryBloc._({
    MatexCountryBlocState? initialState,
    this.jsonData,
  }) : super(initialState: initialState ?? MatexCountryBlocState());

  /// Factory constructor to provide a singleton instance of the
  /// [MatexCountryBloc]. If an instance doesn't exist, it will be created.
  factory MatexCountryBloc({
    String? jsonData,
    MatexCountryBlocState? initialState,
  }) {
    if (!_hasBeenInstantiated) {
      _hasBeenInstantiated = true;
      instance = MatexCountryBloc._(
        initialState: initialState,
        jsonData: jsonData,
      );
    }

    return instance;
  }

  /// Retrieves country metadata by key.
  Future<MatexCountryMetadata?> get(String key) async {
    return _countryProvider.get(key);
  }

  /// Finds one country metadata based on the provided filter function.
  Future<MatexCountryMetadata?> findOne({
    required bool Function(MatexCountryMetadata) filter,
  }) async {
    return _countryProvider.findOne(filter: filter);
  }

  /// Maps incoming [MatexCountryBlocEvent] to corresponding
  /// [MatexCountryBlocState].
  /// Processes events and updates states accordingly.
  @override
  Stream<MatexCountryBlocState> mapEventToState(event) async* {
    final payload = event.payload;
    final type = event.type;

    if (type == MatexCountryBlocEventType.init) {
      yield* handleInitEvent(payload?.jsonData ?? jsonData);
    } else if (type == MatexCountryBlocEventType.initialized) {
      yield* handleInitializedEvent(payload?.countries);
    } else {
      assert(false, 'MatexCountryBloc is not initialized yet.');
    }
  }

  /// Processes the initialization event. It fetches country metadata and
  /// triggers the initialized event.
  Stream<MatexCountryBlocState> handleInitEvent(String? jsonData) async* {
    if (canInitialize) {
      isInitializing = true;
      yield MatexCountryBlocState(isInitializing: true);

      _countryProvider = MatexCountryDataProvider(jsonData: jsonData);
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
