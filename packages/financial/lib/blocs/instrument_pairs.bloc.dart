import 'package:matex_dart/matex_dart.dart';
import 'package:matex_financial/financial.dart';
import 'package:tbloc/tbloc.dart';

class MatexInstrumentPairsBloc extends BidirectionalBloc<
    MatexInstrumentPairsBlocEvent, MatexInstrumentPairsBlocState> {
  static MatexInstrumentPairsBloc? _singleton;

  final _instrumentIairProvider = MatexPairMetadataProvider();
  final _instrumentProvider = MatexInstrumentProvider();

  MatexInstrumentPairsBloc._({MatexInstrumentPairsBlocState? initialState})
      : super(initialState: initialState ?? MatexInstrumentPairsBlocState());

  factory MatexInstrumentPairsBloc() {
    _singleton ??= MatexInstrumentPairsBloc._();

    return _singleton!;
  }

  @override
  Stream<MatexInstrumentPairsBlocState> mapEventToState(
    MatexInstrumentPairsBlocEvent event,
  ) async* {
    final payload = event.payload;
    final type = event.type;

    if (type == MatexInstrumentPairsBlocEventType.init) {
      yield* handleInitEvent();
    } else if (type == MatexInstrumentPairsBlocEventType.initialized) {
      yield* handleInitializedEvent(payload);
    } else {
      assert(false, 'MatexCurrencyBloc is not initialized yet.');
    }
  }

  Stream<MatexInstrumentPairsBlocState> handleInitEvent() async* {
    if (canInitialize) {
      isInitializing = true;
      yield currentState.copyWith(isInitializing: true);

      final instrumentPairs = await _loadInstrumentPairsMetadata();

      addEvent(MatexInstrumentPairsBlocEvent.initialized(instrumentPairs));
    }
  }

  /// Handles the initialized event by updating the state.
  Stream<MatexInstrumentPairsBlocState> handleInitializedEvent(
    List<MatexPairMetadata>? instrumentPairs,
  ) async* {
    if (isInitializing) {
      isInitialized = true;

      yield currentState.copyWith(
        instrumentPairs: instrumentPairs,
        isInitializing: false,
        isInitialized: true,
      );
    }
  }

  Future<List<MatexPairMetadata>> _loadInstrumentPairsMetadata() async {
    final instrumentPairsMetadata = await _instrumentIairProvider.list();
    final instrumentPairs = <MatexPairMetadata>[];

    for (final instrument in instrumentPairsMetadata.values.toList()) {
      instrumentPairs.add(instrument.copyWith(
        baseInstrumentMetadata:
            await _instrumentProvider.metadata(instrument.baseCode),
        counterInstrumentMetadata:
            await _instrumentProvider.metadata(instrument.counterCode),
      ));
    }

    return instrumentPairs;
  }
}
