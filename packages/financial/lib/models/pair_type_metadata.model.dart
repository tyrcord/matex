import 'package:tmodel/tmodel.dart';

const _kWeight = 0.0;

// TODO: needs review from matex_dart
class MatexPairTypeMetadata extends TModel {
  static final Map<String, MatexPairTypeMetadata> _cacheMap = {};
  final String key;
  final String main;
  final String? subKey;
  final String? sub;
  final double weight;

  const MatexPairTypeMetadata({
    required this.key,
    required this.main,
    this.weight = _kWeight,
    this.subKey,
    this.sub,
  });

  factory MatexPairTypeMetadata.fromJson(Map<String, dynamic> json) {
    final rawWeight = json['weight'];
    double? weight;

    if (rawWeight != null) {
      weight = double.parse(rawWeight.toString());
    }

    return MatexPairTypeMetadata(
      key: json['key'] as String,
      main: json['main'] as String,
      subKey: json['subKey'] as String?,
      sub: json['sub'] as String?,
      weight: weight ?? _kWeight,
    );
  }

  factory MatexPairTypeMetadata.addToCache(
    String key,
    Map<String, dynamic> json,
  ) {
    if (!_cacheMap.containsKey(key)) {
      _cacheMap[key] = MatexPairTypeMetadata.fromJson(json);
    }

    return _cacheMap[key]!;
  }

  factory MatexPairTypeMetadata.fromCache(String key) => _cacheMap[key]!;

  @override
  List<Object?> get props => [key, main, subKey, sub, weight];

  @override
  MatexPairTypeMetadata clone() => copyWith();

  @override
  MatexPairTypeMetadata copyWith({
    String? key,
    String? main,
    String? subKey,
    String? sub,
    double? weight,
  }) {
    return MatexPairTypeMetadata(
      key: key ?? this.key,
      main: main ?? this.main,
      subKey: subKey ?? this.subKey,
      sub: sub ?? this.sub,
      weight: weight ?? this.weight,
    );
  }

  @override
  MatexPairTypeMetadata merge(covariant MatexPairTypeMetadata model) {
    return copyWith(
      key: model.key,
      main: model.main,
      subKey: model.subKey,
      sub: model.sub,
      weight: model.weight,
    );
  }
}
