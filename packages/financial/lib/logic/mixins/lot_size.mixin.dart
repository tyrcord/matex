// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:lingua_units/lingua_units.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

mixin MatexLotSizeMixin {
  static const matadataKeys = {
    'instrument': 'instrumentMetadata',
    'standard': 'standardLotSize',
    'micro': 'microLotSize',
    'mini': 'miniLotSize',
    'nano': 'nanoLotSize',
  };

  String get instrumentMetadataKey => matadataKeys['instrument']!;

  String get standardLotSizeMatadataKey =>
      matadataKeys[MatexPositionSizeType.standard.name]!;

  String get microLotSizeMatadataKey =>
      matadataKeys[MatexPositionSizeType.micro.name]!;

  String get miniLotSizeMatadataKey =>
      matadataKeys[MatexPositionSizeType.mini.name]!;

  String get nanoLotSizeMatadataKey =>
      matadataKeys[MatexPositionSizeType.nano.name]!;

  String? localizeLotSizeCaption<B extends FastCalculatorBloc>({
    required B bloc,
    required key,
    String? localeCode,
  }) {
    final metadata = bloc.currentState.metadata;
    final instrument = metadata[instrumentMetadataKey] as MatexPairMetadata?;
    final lotMetadataKey = matadataKeys[key];
    final lotSize = metadata[lotMetadataKey] as double?;
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
