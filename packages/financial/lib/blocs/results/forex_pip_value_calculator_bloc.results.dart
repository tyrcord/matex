// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexForexPipValueCalculatorBlocResults extends FastCalculatorResults {
  final double? pipValue;
  final double? customPipValue;
  final double? standardLotValue;
  final double? miniLotValue;
  final double? microLotValue;

  final String? formattedPipValue;
  final String? formattedCustomPipValue;
  final String? formattedStandardLotValue;
  final String? formattedMiniLotValue;
  final String? formattedMicroLotValue;

  const MatexForexPipValueCalculatorBlocResults({
    this.pipValue,
    this.customPipValue,
    this.standardLotValue,
    this.miniLotValue,
    this.microLotValue,
    this.formattedPipValue,
    this.formattedCustomPipValue,
    this.formattedStandardLotValue,
    this.formattedMiniLotValue,
    this.formattedMicroLotValue,
  });

  @override
  MatexForexPipValueCalculatorBlocResults clone() => copyWith();

  @override
  MatexForexPipValueCalculatorBlocResults copyWith({
    double? pipValue,
    double? customPipValue,
    double? standardLotValue,
    double? miniLotValue,
    double? microLotValue,
    String? formattedPipValue,
    String? formattedCustomPipValue,
    String? formattedStandardLotValue,
    String? formattedMiniLotValue,
    String? formattedMicroLotValue,
  }) {
    return MatexForexPipValueCalculatorBlocResults(
      pipValue: pipValue ?? this.pipValue,
      customPipValue: customPipValue ?? this.customPipValue,
      standardLotValue: standardLotValue ?? this.standardLotValue,
      miniLotValue: miniLotValue ?? this.miniLotValue,
      microLotValue: microLotValue ?? this.microLotValue,
      formattedPipValue: formattedPipValue ?? this.formattedPipValue,
      formattedCustomPipValue:
          formattedCustomPipValue ?? this.formattedCustomPipValue,
      formattedStandardLotValue:
          formattedStandardLotValue ?? this.formattedStandardLotValue,
      formattedMiniLotValue:
          formattedMiniLotValue ?? this.formattedMiniLotValue,
      formattedMicroLotValue:
          formattedMicroLotValue ?? this.formattedMicroLotValue,
    );
  }

  @override
  MatexForexPipValueCalculatorBlocResults merge(
    covariant MatexForexPipValueCalculatorBlocResults model,
  ) {
    return copyWith(
      pipValue: model.pipValue,
      customPipValue: model.customPipValue,
      standardLotValue: model.standardLotValue,
      miniLotValue: model.miniLotValue,
      microLotValue: model.microLotValue,
      formattedPipValue: model.formattedPipValue,
      formattedCustomPipValue: model.formattedCustomPipValue,
      formattedStandardLotValue: model.formattedStandardLotValue,
      formattedMiniLotValue: model.formattedMiniLotValue,
      formattedMicroLotValue: model.formattedMicroLotValue,
    );
  }

  @override
  List<Object?> get props => [
        pipValue,
        customPipValue,
        standardLotValue,
        miniLotValue,
        microLotValue,
        formattedPipValue,
        formattedCustomPipValue,
        formattedStandardLotValue,
        formattedMiniLotValue,
        formattedMicroLotValue,
      ];
}
