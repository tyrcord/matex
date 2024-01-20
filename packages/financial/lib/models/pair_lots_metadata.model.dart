// Package imports:
import 'package:tmodel/tmodel.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

// TODO: needs review from matex_dart
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
  final double? standard;
  final double? micro;
  final double? mini;
  final double? nano;

  const MatexPairLotsMetadata({
    this.micro,
    this.mini,
    this.nano,
    this.normalized,
    this.standard,
    required this.unit,
  });

  static MatexPairLotsMetadata fromJson(Map<String, dynamic> json) {
    final standard = json[MatexPositionSizeType.standard.name] as num?;
    final micro = json[MatexPositionSizeType.micro.name] as num?;
    final mini = json[MatexPositionSizeType.mini.name] as num?;
    final nano = json[MatexPositionSizeType.nano.name] as num?;

    return MatexPairLotsMetadata(
      unit: MatexPairLotUnitMetadata.fromCache(json['unit'] as String),
      standard: standard?.toDouble(),
      micro: micro?.toDouble(),
      mini: mini?.toDouble(),
      nano: nano?.toDouble(),
      normalized: json['normalized'] as bool?,
    );
  }

  static MatexPairLotsMetadata defaultMetatada() => _kDefaultPairLotsMetadata;

  double operator [](MatexPositionSizeType size) {
    switch (size) {
      case MatexPositionSizeType.micro:
        return micro ?? 0.0;
      case MatexPositionSizeType.mini:
        return mini ?? 0.0;
      case MatexPositionSizeType.nano:
        return nano ?? 0.0;
      case MatexPositionSizeType.standard:
        return standard ?? 0.0;
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
    double? micro,
    double? mini,
    double? nano,
    bool? normalized,
    double? standard,
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
