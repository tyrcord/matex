import 'package:fastyle_financial/fastyle_financial.dart';
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_dart/matex_dart.dart' show MatexPairMetadata;

mixin MatexLotSizeMixin {
  static const matadataKeys = {
    'instrument': 'instrumentMetadata',
    'standard': 'standardLotSize',
    'micro': 'microLotSize',
    'mini': 'miniLotSize',
  };

  String get instrumentMetadataKey => matadataKeys['instrument']!;
  String get standardLotSizeMatadataKey => matadataKeys['standard']!;
  String get microLotSizeMatadataKey => matadataKeys['micro']!;
  String get miniLotSizeMatadataKey => matadataKeys['mini']!;

  String? localizeLotSizeCaption<B extends FastCalculatorBloc>({
    required B bloc,
    required key,
  }) {
    final metadata = bloc.currentState.metadata;
    final instrument = metadata[instrumentMetadataKey] as MatexPairMetadata?;
    final lotMetadataKey = matadataKeys[key];
    final lotSize = metadata[lotMetadataKey] as int?;
    String? captionText;

    if (instrument != null && lotSize != null) {
      captionText = localizeLotSize(
        metadata: instrument,
        lotSize: lotSize,
      );
    }

    return captionText;
  }
}
