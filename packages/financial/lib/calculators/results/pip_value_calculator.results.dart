import 'package:matex_core/core.dart';

class MatexPipValueCalculatorResults extends MatexCalculatorState {
  final double? pipValue;
  final double? customPipValue;
  final double? standardLotValue;
  final double? miniLotValue;
  final double? microLotValue;

  const MatexPipValueCalculatorResults({
    this.pipValue,
    this.customPipValue,
    this.standardLotValue,
    this.miniLotValue,
    this.microLotValue,
  });

  @override
  MatexPipValueCalculatorResults clone() => copyWith();

  @override
  MatexPipValueCalculatorResults copyWith({
    double? pipValue,
    double? customPipValue,
    double? standardLotValue,
    double? miniLotValue,
    double? microLotValue,
  }) {
    return MatexPipValueCalculatorResults(
      pipValue: pipValue ?? this.pipValue,
      customPipValue: customPipValue ?? this.customPipValue,
      standardLotValue: standardLotValue ?? this.standardLotValue,
      miniLotValue: miniLotValue ?? this.miniLotValue,
      microLotValue: microLotValue ?? this.microLotValue,
    );
  }

  @override
  MatexPipValueCalculatorResults merge(
    covariant MatexPipValueCalculatorResults model,
  ) {
    return copyWith(
      pipValue: model.pipValue,
      customPipValue: model.customPipValue,
      standardLotValue: model.standardLotValue,
      miniLotValue: model.miniLotValue,
      microLotValue: model.microLotValue,
    );
  }

  @override
  List<Object?> get props => [
        pipValue,
        customPipValue,
        standardLotValue,
        miniLotValue,
        microLotValue,
      ];
}
