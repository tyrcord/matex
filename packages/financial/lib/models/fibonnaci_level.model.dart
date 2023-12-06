import 'package:tmodel/tmodel.dart';

class MatexFibonacciLevel extends TModel {
  static const defaultPrecision = 5;

  final String level;
  final double value;

  String get formattedValue => value.toStringAsFixed(defaultPrecision);

  const MatexFibonacciLevel({
    required this.level,
    required this.value,
  });

  @override
  List<Object> get props => [level, value];

  @override
  MatexFibonacciLevel clone() => copyWith();

  @override
  MatexFibonacciLevel copyWith({
    String? level,
    double? value,
    bool? isExtension,
  }) {
    return MatexFibonacciLevel(
      level: level ?? this.level,
      value: value ?? this.value,
    );
  }

  @override
  MatexFibonacciLevel merge(covariant MatexFibonacciLevel model) {
    return copyWith(
      level: model.level,
      value: model.value,
    );
  }
}
