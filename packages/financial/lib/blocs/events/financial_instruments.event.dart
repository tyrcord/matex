// Package imports:
import 'package:matex_dart/matex_dart.dart' show MatexPairMetadata;
import 'package:tbloc/tbloc.dart';

enum MatexFinancialInstrumentsBlocEventType {
  init,
  initialized,
}

class MatexFinancialInstrumentsBlocEvent extends BlocEvent<
    MatexFinancialInstrumentsBlocEventType, List<MatexPairMetadata>> {
  const MatexFinancialInstrumentsBlocEvent.init()
      : super(type: MatexFinancialInstrumentsBlocEventType.init);

  const MatexFinancialInstrumentsBlocEvent.initialized(
    List<MatexPairMetadata> instrumentpairs,
  ) : super(
          type: MatexFinancialInstrumentsBlocEventType.initialized,
          payload: instrumentpairs,
        );
}
