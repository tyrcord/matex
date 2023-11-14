import 'package:tmodel/tmodel.dart';
import 'package:matex_financial/models/models.dart';

// FIXME: needs review from matex_dart
class MatexInstrumentMetadata extends TModel {
  final MatexInstrumentFormatMetadata? format;
  final MatexInstrumentSymbolMetadata? symbol;
  final MatexInstrumentNameMetadata? name;
  final MatexInstrumentTypeMetadata type;
  final String? icon;
  final String? code;

  const MatexInstrumentMetadata({
    required this.type,
    this.format,
    this.symbol,
    this.code,
    this.icon,
    this.name,
  });

  factory MatexInstrumentMetadata.fromJson(Map<String, dynamic> json) {
    return MatexInstrumentMetadata(
      code: json['code'] as String?,
      icon: json['icon'] as String?,
      format: MatexInstrumentFormatMetadata.fromJson(
        json['format'] as Map<String, dynamic>,
      ),
      name: MatexInstrumentNameMetadata.fromJson(
        json['name'] as Map<String, dynamic>,
      ),
      symbol: MatexInstrumentSymbolMetadata.fromJson(
        json['symbol'] as Map<String, dynamic>,
      ),
      type: MatexInstrumentTypeMetadata.fromCache(json['type'] as String),
    );
  }

  @override
  List<Object?> get props => [
        code,
        icon,
        format,
        name,
        symbol,
        type,
      ];

  @override
  MatexInstrumentMetadata clone() => copyWith();

  @override
  MatexInstrumentMetadata copyWith({
    MatexInstrumentFormatMetadata? format,
    MatexInstrumentSymbolMetadata? symbol,
    MatexInstrumentNameMetadata? name,
    MatexInstrumentTypeMetadata? type,
    String? icon,
    String? code,
  }) {
    return MatexInstrumentMetadata(
      code: code ?? this.code,
      icon: icon ?? this.icon,
      format: format ?? this.format,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      type: type ?? this.type,
    );
  }

  @override
  MatexInstrumentMetadata merge(
    covariant MatexInstrumentMetadata model,
  ) {
    return MatexInstrumentMetadata(
      code: model.code,
      icon: model.icon,
      format: model.format,
      name: model.name,
      symbol: model.symbol,
      type: model.type,
    );
  }
}
