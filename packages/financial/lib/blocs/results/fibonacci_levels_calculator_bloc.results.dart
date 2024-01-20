// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexFibonacciLevelsCalculatorBlocResults extends FastCalculatorResults {
  final List<MatexFibonacciLevel> retracementLevels;
  final List<MatexFibonacciLevel> extensionLevels;

  const MatexFibonacciLevelsCalculatorBlocResults({
    this.retracementLevels = const [],
    this.extensionLevels = const [],
  });

  @override
  List<Object> get props => [retracementLevels, extensionLevels];

  @override
  MatexFibonacciLevelsCalculatorBlocResults clone() => copyWith();

  @override
  MatexFibonacciLevelsCalculatorBlocResults copyWith({
    List<MatexFibonacciLevel>? retracementLevels,
    List<MatexFibonacciLevel>? extensionLevels,
  }) {
    return MatexFibonacciLevelsCalculatorBlocResults(
      retracementLevels: retracementLevels ?? this.retracementLevels,
      extensionLevels: extensionLevels ?? this.extensionLevels,
    );
  }

  @override
  MatexFibonacciLevelsCalculatorBlocResults merge(
    covariant MatexFibonacciLevelsCalculatorBlocResults model,
  ) {
    return copyWith(
      retracementLevels: model.retracementLevels,
      extensionLevels: model.extensionLevels,
    );
  }
}
