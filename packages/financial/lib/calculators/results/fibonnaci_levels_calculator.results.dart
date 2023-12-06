import 'package:matex_financial/financial.dart';
import 'package:tmodel/tmodel.dart';

class MatexFibonnaciLevelsCalculatorResults extends TModel {
  final List<MatexFibonacciLevel> retracementLevels;
  final List<MatexFibonacciLevel> extensionLevels;

  const MatexFibonnaciLevelsCalculatorResults({
    this.retracementLevels = const [],
    this.extensionLevels = const [],
  });

  @override
  List<Object> get props => [retracementLevels, extensionLevels];

  @override
  MatexFibonnaciLevelsCalculatorResults clone() => copyWith();

  @override
  MatexFibonnaciLevelsCalculatorResults copyWith({
    List<MatexFibonacciLevel>? retracementLevels,
    List<MatexFibonacciLevel>? extensionLevels,
  }) {
    return MatexFibonnaciLevelsCalculatorResults(
      retracementLevels: retracementLevels ?? this.retracementLevels,
      extensionLevels: extensionLevels ?? this.extensionLevels,
    );
  }

  @override
  MatexFibonnaciLevelsCalculatorResults merge(
    covariant MatexFibonnaciLevelsCalculatorResults model,
  ) {
    return copyWith(
      retracementLevels: model.retracementLevels,
      extensionLevels: model.extensionLevels,
    );
  }
}
