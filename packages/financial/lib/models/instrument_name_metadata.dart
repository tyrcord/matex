// Package imports:
import 'package:tmodel/tmodel.dart';

// TODO: needs review from matex_dart
class MatexInstrumentNameMetadata extends TModel {
  final String key;
  final String localized;

  const MatexInstrumentNameMetadata({
    required this.key,
    required this.localized,
  });

  static MatexInstrumentNameMetadata fromJson(Map<String, dynamic> json) {
    return MatexInstrumentNameMetadata(
      key: json['key'] as String,
      localized: json['localized'] as String,
    );
  }

  @override
  List<Object?> get props => [key, localized];

  @override
  MatexInstrumentNameMetadata clone() => copyWith();

  @override
  MatexInstrumentNameMetadata copyWith({
    String? key,
    String? localized,
  }) {
    return MatexInstrumentNameMetadata(
      key: key ?? this.key,
      localized: localized ?? this.localized,
    );
  }

  @override
  MatexInstrumentNameMetadata merge(
    covariant MatexInstrumentNameMetadata model,
  ) {
    return MatexInstrumentNameMetadata(
      key: model.key,
      localized: model.localized,
    );
  }
}
