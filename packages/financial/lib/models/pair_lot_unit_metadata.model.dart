import 'package:tmodel/tmodel.dart';

// TODO: needs review from matex_dart
const kMatexForexPairLotUnitMetadata = MatexPairLotUnitMetadata(
  key: 'forex',
  long: 'unit',
  short: 'unit',
);

class MatexPairLotUnitMetadata extends TModel {
  static const Map<String, MatexPairLotUnitMetadata> _cacheMap = {
    'forex': kMatexForexPairLotUnitMetadata,
    'barrel': MatexPairLotUnitMetadata(
      key: 'barrel',
      long: 'barrel',
      short: 'bbl',
    ),
    'mmbtu': MatexPairLotUnitMetadata(
      key: 'mmbtu',
      long: 'metric million british Thermal unit',
      short: 'MMBtu',
    ),
    'ounce': MatexPairLotUnitMetadata(
      key: 'ounce',
      long: 'ounce',
      short: 'oz',
    ),
    'ton': MatexPairLotUnitMetadata(
      key: 'ton',
      long: 'ton',
      short: 't',
    ),
    'pound': MatexPairLotUnitMetadata(
      key: 'pound',
      long: 'pound',
      short: 'lb',
    ),
    'busshel': MatexPairLotUnitMetadata(
      key: 'busshel',
      long: 'busshel',
      short: 'bu',
    ),
  };

  final String key;
  final String long;
  final String short;

  const MatexPairLotUnitMetadata({
    required this.key,
    required this.long,
    required this.short,
  });

  factory MatexPairLotUnitMetadata.fromJson(Map<String, dynamic> json) {
    return MatexPairLotUnitMetadata(
      key: json['key'] as String,
      long: json['long'] as String,
      short: json['short'] as String,
    );
  }

  factory MatexPairLotUnitMetadata.fromCache(String key) => _cacheMap[key]!;

  @override
  List<Object> get props => [key, long, short];

  @override
  MatexPairLotUnitMetadata clone() => copyWith();

  @override
  MatexPairLotUnitMetadata copyWith({
    String? key,
    String? long,
    String? short,
  }) {
    return MatexPairLotUnitMetadata(
      key: key ?? this.key,
      long: long ?? this.long,
      short: short ?? this.short,
    );
  }

  @override
  MatexPairLotUnitMetadata merge(covariant MatexPairLotUnitMetadata model) {
    return MatexPairLotUnitMetadata(
      key: model.key,
      long: model.long,
      short: model.short,
    );
  }
}
