import 'package:matex_financial/financial.dart';
import 'package:tmodel/tmodel.dart';

class MatexFibonacciLevelsCalculatorResults extends TModel {
  final List<MatexFibonacciLevel> retracementLevels;
  final List<MatexFibonacciLevel> extensionLevels;

  const MatexFibonacciLevelsCalculatorResults({
    this.retracementLevels = const [],
    this.extensionLevels = const [],
  });

  @override
  List<Object> get props => [retracementLevels, extensionLevels];

  @override
  MatexFibonacciLevelsCalculatorResults clone() => copyWith();

  @override
  MatexFibonacciLevelsCalculatorResults copyWith({
    List<MatexFibonacciLevel>? retracementLevels,
    List<MatexFibonacciLevel>? extensionLevels,
  }) {
    return MatexFibonacciLevelsCalculatorResults(
      retracementLevels: retracementLevels ?? this.retracementLevels,
      extensionLevels: extensionLevels ?? this.extensionLevels,
    );
  }

  @override
  MatexFibonacciLevelsCalculatorResults merge(
    covariant MatexFibonacciLevelsCalculatorResults model,
  ) {
    return copyWith(
      retracementLevels: model.retracementLevels,
      extensionLevels: model.extensionLevels,
    );
  }
}
