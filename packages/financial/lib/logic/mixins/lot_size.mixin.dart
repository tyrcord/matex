import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';
import 'package:lingua_units/lingua_units.dart';

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
    String? localeCode,
  }) {
    final metadata = bloc.currentState.metadata;
    final instrument = metadata[instrumentMetadataKey] as MatexPairMetadata?;
    final lotMetadataKey = matadataKeys[key];
    final lotSize = metadata[lotMetadataKey] as int?;
    String? captionText;

    if (instrument != null && lotSize != null && instrument.lots != null) {
      final unitKey = instrument.lots!.unit.key;

      captionText = localizeUnitSize(
        localeCode: localeCode,
        unitKey: unitKey,
        value: lotSize,
      );
    }

    return captionText;
  }
}
