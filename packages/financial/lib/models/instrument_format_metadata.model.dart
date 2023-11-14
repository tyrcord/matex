import 'package:tmodel/tmodel.dart';

// FIXME: needs review from matex_dart
class MatexInstrumentFormatMetadata extends TModel {
  final int round;

  const MatexInstrumentFormatMetadata({required this.round});

  static MatexInstrumentFormatMetadata fromJson(Map<String, dynamic> json) {
    return MatexInstrumentFormatMetadata(round: json['round'] as int);
  }

  @override
  List<Object?> get props => [round];

  @override
  MatexInstrumentFormatMetadata clone() => copyWith();

  @override
  MatexInstrumentFormatMetadata copyWith({int? round}) {
    return MatexInstrumentFormatMetadata(
      round: round ?? this.round,
    );
  }

  @override
  MatexInstrumentFormatMetadata merge(
    covariant MatexInstrumentFormatMetadata model,
  ) {
    return MatexInstrumentFormatMetadata(
      round: model.round,
    );
  }
}
