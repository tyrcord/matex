// Package imports:
import 'package:tmodel/tmodel.dart';

const _kWeight = 0.0;

// TODO: needs review from matex_dart
class MatexInstrumentTypeMetadata extends TModel {
  static final Map<String, MatexInstrumentTypeMetadata> _cacheMap = {};
  final String key;
  final String main;
  final String? subKey;
  final String? sub;
  final double weight;

  const MatexInstrumentTypeMetadata({
    required this.key,
    required this.main,
    this.weight = _kWeight,
    this.subKey,
    this.sub,
  }) : super();

  factory MatexInstrumentTypeMetadata.fromJson(Map<String, dynamic> json) {
    final rawWeight = json['weight'];
    double? weight;

    if (rawWeight != null) {
      weight = double.parse(rawWeight.toString());
    }

    return MatexInstrumentTypeMetadata(
      key: json['key'] as String,
      main: json['main'] as String,
      subKey: json['subKey'] as String?,
      sub: json['sub'] as String?,
      weight: weight ?? _kWeight,
    );
  }

  factory MatexInstrumentTypeMetadata.addToCache(
    String key,
    Map<String, dynamic> json,
  ) {
    if (!_cacheMap.containsKey(key)) {
      _cacheMap[key] = MatexInstrumentTypeMetadata.fromJson(json);
    }

    return _cacheMap[key]!;
  }

  factory MatexInstrumentTypeMetadata.fromCache(String key) => _cacheMap[key]!;

  @override
  MatexInstrumentTypeMetadata clone() => copyWith();

  @override
  MatexInstrumentTypeMetadata copyWith({
    String? key,
    String? main,
    String? subKey,
    String? sub,
    double? weight,
  }) {
    return MatexInstrumentTypeMetadata(
      key: key ?? this.key,
      main: main ?? this.main,
      subKey: subKey ?? this.subKey,
      sub: sub ?? this.sub,
      weight: weight ?? this.weight,
    );
  }

  @override
  MatexInstrumentTypeMetadata merge(
    covariant MatexInstrumentTypeMetadata model,
  ) {
    return copyWith(
      key: model.key,
      main: model.main,
      subKey: model.subKey,
      sub: model.sub,
      weight: model.weight,
    );
  }

  @override
  List<Object?> get props => [key, main, subKey, sub, weight];
}
