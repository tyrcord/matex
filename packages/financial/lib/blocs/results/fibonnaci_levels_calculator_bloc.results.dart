import 'package:matex_financial/financial.dart';
import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexFibonnaciLevelsCalculatorBlocResults extends FastCalculatorResults {
  final List<MatexFibonacciLevel> retracementLevels;
  final List<MatexFibonacciLevel> extensionLevels;

  const MatexFibonnaciLevelsCalculatorBlocResults({
    this.retracementLevels = const [],
    this.extensionLevels = const [],
  });

  @override
  List<Object> get props => [retracementLevels, extensionLevels];

  @override
  MatexFibonnaciLevelsCalculatorBlocResults clone() => copyWith();

  @override
  MatexFibonnaciLevelsCalculatorBlocResults copyWith({
    List<MatexFibonacciLevel>? retracementLevels,
    List<MatexFibonacciLevel>? extensionLevels,
  }) {
    return MatexFibonnaciLevelsCalculatorBlocResults(
      retracementLevels: retracementLevels ?? this.retracementLevels,
      extensionLevels: extensionLevels ?? this.extensionLevels,
    );
  }

  @override
  MatexFibonnaciLevelsCalculatorBlocResults merge(
    covariant MatexFibonnaciLevelsCalculatorBlocResults model,
  ) {
    return copyWith(
      retracementLevels: model.retracementLevels,
      extensionLevels: model.extensionLevels,
    );
  }
}
