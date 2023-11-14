import 'package:matex_financial/financial.dart';
import 'package:tmodel/tmodel.dart';

// FIXME: needs review from matex_dart
const _kDefaultPairLotsMetadata = MatexPairLotsMetadata(
  micro: 1000,
  mini: 10000,
  nano: 100,
  normalized: true,
  standard: 100000,
  unit: kMatexForexPairLotUnitMetadata,
);

class MatexPairLotsMetadata extends TModel {
  final int? micro;
  final int? mini;
  final int? nano;
  final bool? normalized;
  final int? standard;
  final MatexPairLotUnitMetadata unit;

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
      micro: json['micro'] as int?,
      mini: json['mini'] as int?,
      nano: json['nano'] as int?,
      normalized: json['normalized'] as bool?,
      standard: json['standard'] as int?,
      unit: MatexPairLotUnitMetadata.fromCache(json['unit'] as String),
    );
  }

  static MatexPairLotsMetadata defaultMetatada() => _kDefaultPairLotsMetadata;

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
