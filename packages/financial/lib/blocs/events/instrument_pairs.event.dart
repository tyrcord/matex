// Package imports:
import 'package:matex_dart/matex_dart.dart' show MatexPairMetadata;
import 'package:tbloc/tbloc.dart';

enum MatexInstrumentPairsBlocEventType {
  init,
  initialized,
}

class MatexInstrumentPairsBlocEvent extends BlocEvent<
    MatexInstrumentPairsBlocEventType, List<MatexPairMetadata>> {
  const MatexInstrumentPairsBlocEvent.init()
      : super(type: MatexInstrumentPairsBlocEventType.init);

  const MatexInstrumentPairsBlocEvent.initialized(
    List<MatexPairMetadata> instrumentpairs,
  ) : super(
          type: MatexInstrumentPairsBlocEventType.initialized,
          payload: instrumentpairs,
        );
}
