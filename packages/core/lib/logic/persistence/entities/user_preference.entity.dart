import 'package:tstore/tstore.dart';

/// Represents a user preference entity.
class MatexUserPreferenceEntity extends TEntity {
  /// The key of the preference.
  final String key;

  /// The value of the preference.
  final dynamic value;

  /// Creates a new instance of [MatexUserPreferenceEntity].
  const MatexUserPreferenceEntity({
    required this.key,
    this.value,
  });

  /// Creates a new instance of [MatexUserPreferenceEntity] from a JSON map.
  factory MatexUserPreferenceEntity.fromJson(Map<String, dynamic> json) {
    return MatexUserPreferenceEntity(
      key: json['key'] as String,
      value: json['value'] as dynamic,
    );
  }

  /// Converts this entity to a JSON map.
  @override
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }

  /// Creates a copy of this entity with the specified properties changed.
  @override
  MatexUserPreferenceEntity copyWith({
    String? key,
    dynamic value,
  }) {
    return MatexUserPreferenceEntity(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  /// Merges this entity with another entity.
  @override
  MatexUserPreferenceEntity merge(covariant MatexUserPreferenceEntity model) {
    return copyWith(key: model.key, value: model.value);
  }

  /// Creates a clone of this entity.
  @override
  MatexUserPreferenceEntity clone() => copyWith();

  /// Returns a list of properties used for equality checking.
  @override
  List<Object?> get props => [key, value];
}
