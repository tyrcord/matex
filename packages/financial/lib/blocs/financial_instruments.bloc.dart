// Package imports:
import 'package:matex_dart/matex_dart.dart';
import 'package:tbloc/tbloc.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexFinancialInstrumentsBloc extends BidirectionalBloc<
    MatexFinancialInstrumentsBlocEvent, MatexFinancialInstrumentsBlocState> {
  static late MatexFinancialInstrumentsBloc instance;
  static bool _hasBeenInstantiated = false;

  final _instrumentsProvider = MatexPairMetadataProvider();
  final _instrumentProvider = MatexInstrumentProvider();

  MatexFinancialInstrumentsBloc._(
      MatexFinancialInstrumentsBlocState? initialState)
      : super(
            initialState: initialState ?? MatexFinancialInstrumentsBlocState());

  factory MatexFinancialInstrumentsBloc({
    MatexFinancialInstrumentsBlocState? initialState,
  }) {
    if (!_hasBeenInstantiated) {
      instance = MatexFinancialInstrumentsBloc._(initialState);
      _hasBeenInstantiated = true;
    }

    return instance;
  }

  @override
  Stream<MatexFinancialInstrumentsBlocState> mapEventToState(
    MatexFinancialInstrumentsBlocEvent event,
  ) async* {
    final payload = event.payload;
    final type = event.type;

    if (type == MatexFinancialInstrumentsBlocEventType.init) {
      yield* handleInitEvent();
    } else if (type == MatexFinancialInstrumentsBlocEventType.initialized) {
      yield* handleInitializedEvent(payload);
    } else {
      assert(false, 'MatexFinancialInstrumentsBloc is not initialized yet.');
    }
  }

  Stream<MatexFinancialInstrumentsBlocState> handleInitEvent() async* {
    if (canInitialize) {
      isInitializing = true;
      yield currentState.copyWith(isInitializing: true);

      final instruments = await _loadInstrumentPairsMetadata();

      addEvent(MatexFinancialInstrumentsBlocEvent.initialized(instruments));
    }
  }

  /// Handles the initialized event by updating the state.
  Stream<MatexFinancialInstrumentsBlocState> handleInitializedEvent(
    List<MatexPairMetadata>? instruments,
  ) async* {
    if (isInitializing) {
      isInitialized = true;

      yield currentState.copyWith(
        instruments: instruments,
        isInitializing: false,
        isInitialized: true,
      );
    }
  }

  Future<List<MatexPairMetadata>> _loadInstrumentPairsMetadata() async {
    final instrumentsMetadata = await _instrumentsProvider.list();
    final instruments = <MatexPairMetadata>[];

    for (final instrument in instrumentsMetadata.values.toList()) {
      instruments.add(instrument.copyWith(
        baseInstrumentMetadata:
            await _instrumentProvider.metadata(instrument.baseCode),
        counterInstrumentMetadata:
            await _instrumentProvider.metadata(instrument.counterCode),
      ));
    }

    print('instruments: $instruments');

    return instruments;
  }
}
