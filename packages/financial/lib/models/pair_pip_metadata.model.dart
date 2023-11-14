import 'package:tmodel/tmodel.dart';

// FIXME: needs review from matex_dart
const _kDefault = MatexPairPipMetadata(
  pipette: 5,
  precision: 4,
  round: 5,
);

class MatexPairPipMetadata extends TModel {
  final int precision;
  final int pipette;
  final int round;

  const MatexPairPipMetadata({
    required this.precision,
    required this.pipette,
    required this.round,
  });

  factory MatexPairPipMetadata.fromJson(Map<String, dynamic> json) {
    return MatexPairPipMetadata(
      precision: json['precision'] as int,
      pipette: json['pipette'] as int,
      round: json['round'] as int,
    );
  }

  factory MatexPairPipMetadata.defaultMetatada() => _kDefault;

  @override
  List<Object> get props => [precision, pipette, round];

  @override
  MatexPairPipMetadata clone() => copyWith();

  @override
  MatexPairPipMetadata copyWith({
    int? precision,
    int? pipette,
    int? round,
  }) {
    return MatexPairPipMetadata(
      precision: precision ?? this.precision,
      pipette: pipette ?? this.pipette,
      round: round ?? this.round,
    );
  }

  @override
  MatexPairPipMetadata merge(covariant MatexPairPipMetadata model) {
    return copyWith(
      precision: model.precision,
      pipette: model.pipette,
      round: model.round,
    );
  }
}
