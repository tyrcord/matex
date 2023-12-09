import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexForexProfitLossCalculatorBlocResults extends FastCalculatorResults {
  final double? profitAndLoss;
  final double? roi;

  final String? formattedProfitAndLoss;
  final String? formattedRoi;

  const MatexForexProfitLossCalculatorBlocResults({
    this.formattedProfitAndLoss,
    this.profitAndLoss,
    this.formattedRoi,
    this.roi,
  });

  @override
  MatexForexProfitLossCalculatorBlocResults clone() => copyWith();

  @override
  MatexForexProfitLossCalculatorBlocResults copyWith({
    String? formattedProfitAndLoss,
    double? profitAndLoss,
    String? formattedRoi,
    double? roi,
  }) {
    return MatexForexProfitLossCalculatorBlocResults(
      formattedProfitAndLoss:
          formattedProfitAndLoss ?? this.formattedProfitAndLoss,
      profitAndLoss: profitAndLoss ?? this.profitAndLoss,
      formattedRoi: formattedRoi ?? this.formattedRoi,
      roi: roi ?? this.roi,
    );
  }

  @override
  MatexForexProfitLossCalculatorBlocResults merge(
    covariant MatexForexProfitLossCalculatorBlocResults model,
  ) {
    return copyWith(
      formattedProfitAndLoss: model.formattedProfitAndLoss,
      profitAndLoss: model.profitAndLoss,
      formattedRoi: model.formattedRoi,
      roi: model.roi,
    );
  }

  @override
  List<Object?> get props => [
        formattedProfitAndLoss,
        profitAndLoss,
        formattedRoi,
        roi,
      ];
}
