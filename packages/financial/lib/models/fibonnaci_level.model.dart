import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:tmodel/tmodel.dart';

class MatexFibonacciLevel extends TModel with MatexCalculatorFormatterMixin {
  static const defaultPrecision = 5;

  final double level;
  final double value;

  String get formattedValue {
    return localizeNumber(
      value: value,
      maximumFractionDigits: defaultPrecision,
    );
  }

  String get formattedLevel {
    return localizePercentage(value: level, maximumFractionDigits: 1);
  }

  MatexFibonacciLevel({
    required this.level,
    required this.value,
    FastCalculatorBlocDelegate? delegate,
  }) {
    this.delegate = delegate;
  }

  @override
  List<Object> get props => [level, value];

  @override
  MatexFibonacciLevel clone() => copyWith();

  @override
  MatexFibonacciLevel copyWith({
    double? level,
    double? value,
    FastCalculatorBlocDelegate? delegate,
  }) {
    return MatexFibonacciLevel(
      delegate: delegate ?? this.delegate,
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
