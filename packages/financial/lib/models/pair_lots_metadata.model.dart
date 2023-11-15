import 'package:matex_financial/financial.dart';
import 'package:tmodel/tmodel.dart';

// FIXME: needs review from matex_dart
const _kDefaultPairLotsMetadata = MatexPairLotsMetadata(
  unit: kMatexForexPairLotUnitMetadata,
  normalized: true,
  standard: 100000,
  micro: 1000,
  mini: 10000,
  nano: 100,
);

class MatexPairLotsMetadata extends TModel {
  final MatexPairLotUnitMetadata unit;
  final bool? normalized;
  final int? standard;
  final int? micro;
  final int? mini;
  final int? nano;

  const MatexPairLotsMetadata({
    this.micro,
    this.mini,
    this.nano,
    this.normalized,
    this.standard,
    required this.unit,
  });

  static MatexPairLotsMetadata fromJson(Map<String, dynamic> json) {
    return MatexPairLotsMetadata(
      unit: MatexPairLotUnitMetadata.fromCache(json['unit'] as String),
      standard: json[MatexPositionSizeType.standard.name] as int?,
      micro: json[MatexPositionSizeType.micro.name] as int?,
      mini: json[MatexPositionSizeType.mini.name] as int?,
      nano: json[MatexPositionSizeType.nano.name] as int?,
      normalized: json['normalized'] as bool?,
    );
  }

  static MatexPairLotsMetadata defaultMetatada() => _kDefaultPairLotsMetadata;

  int operator [](MatexPositionSizeType size) {
    switch (size) {
      case MatexPositionSizeType.micro:
        return micro ?? 0;
      case MatexPositionSizeType.mini:
        return mini ?? 0;
      case MatexPositionSizeType.nano:
        return nano ?? 0;
      case MatexPositionSizeType.standard:
        return standard ?? 0;
      default:
        return 0;
    }
  }

  @override
  List<Object?> get props => [
        micro,
        mini,
        nano,
        normalized,
        standard,
        unit,
      ];

  @override
  MatexPairLotsMetadata clone() => copyWith();

  @override
  MatexPairLotsMetadata copyWith({
    int? micro,
    int? mini,
    int? nano,
    bool? normalized,
    int? standard,
    MatexPairLotUnitMetadata? unit,
  }) {
    return MatexPairLotsMetadata(
      micro: micro ?? this.micro,
      mini: mini ?? this.mini,
      nano: nano ?? this.nano,
      normalized: normalized ?? this.normalized,
      standard: standard ?? this.standard,
      unit: unit ?? this.unit,
    );
  }

  @override
  MatexPairLotsMetadata merge(covariant MatexPairLotsMetadata model) {
    return copyWith(
      micro: model.micro,
      mini: model.mini,
      nano: model.nano,
      normalized: model.normalized,
      standard: model.standard,
      unit: model.unit,
    );
  }
}
