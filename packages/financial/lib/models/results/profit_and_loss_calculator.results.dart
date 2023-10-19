import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexProfitAndLossCalculatorBlocResults extends FastCalculatorResults {
  final double? grossProfit;
  final double? totalCosts;
  final double? netProfit;
  final double? returnOnInvestment;
  final double? breakEvenUnit;

  final String? formattedGrossProfit;
  final String? formattedTotalCosts;
  final String? formattedNetProfit;
  final String? formattedReturnOnInvestment;
  final String? formattedBreakEvenUnit;

  const MatexProfitAndLossCalculatorBlocResults({
    this.grossProfit,
    this.totalCosts,
    this.netProfit,
    this.returnOnInvestment,
    this.breakEvenUnit,
    this.formattedGrossProfit,
    this.formattedTotalCosts,
    this.formattedNetProfit,
    this.formattedReturnOnInvestment,
    this.formattedBreakEvenUnit,
  });

  //FIXME: implement fromCalculatorResults

  // static MatexProfitAndLossCalculatorBlocResults fromCalculatorResults(
  //   FastCalculatorResults results,
  // ) {
  //   return MatexProfitAndLossCalculatorBlocResults(
  //     grossProfit: results.grossProfit,
  //     totalCosts: results.totalCosts,
  //     netProfit: results.netProfit,
  //     returnOnInvestment: results.returnOnInvestment,
  //     breakEvenUnit: results.breakEvenUnit,
  //     // formatted values
  //     formattedGrossProfit: results.formattedGrossProfit,
  //     formattedTotalCosts: results.formattedTotalCosts,
  //     formattedNetProfit: results.formattedNetProfit,
  //     formattedReturnOnInvestment: results.formattedReturnOnInvestment,
  //     formattedBreakEvenUnit: results.formattedBreakEvenUnit,
  //   );
  // }

  @override
  MatexProfitAndLossCalculatorBlocResults clone() => copyWith();

  @override
  MatexProfitAndLossCalculatorBlocResults copyWith({
    double? grossProfit,
    double? totalCosts,
    double? netProfit,
    double? returnOnInvestment,
    double? breakEvenUnit,
    String? formattedGrossProfit,
    String? formattedTotalCosts,
    String? formattedNetProfit,
    String? formattedReturnOnInvestment,
    String? formattedBreakEvenUnit,
  }) {
    return MatexProfitAndLossCalculatorBlocResults(
      grossProfit: grossProfit ?? this.grossProfit,
      totalCosts: totalCosts ?? this.totalCosts,
      netProfit: netProfit ?? this.netProfit,
      returnOnInvestment: returnOnInvestment ?? this.returnOnInvestment,
      breakEvenUnit: breakEvenUnit ?? this.breakEvenUnit,
      formattedGrossProfit: formattedGrossProfit ?? this.formattedGrossProfit,
      formattedTotalCosts: formattedTotalCosts ?? this.formattedTotalCosts,
      formattedNetProfit: formattedNetProfit ?? this.formattedNetProfit,
      formattedReturnOnInvestment:
          formattedReturnOnInvestment ?? this.formattedReturnOnInvestment,
      formattedBreakEvenUnit:
          formattedBreakEvenUnit ?? this.formattedBreakEvenUnit,
    );
  }

  @override
  MatexProfitAndLossCalculatorBlocResults merge(
    covariant MatexProfitAndLossCalculatorBlocResults model,
  ) {
    return copyWith(
      grossProfit: model.grossProfit,
      totalCosts: model.totalCosts,
      netProfit: model.netProfit,
      returnOnInvestment: model.returnOnInvestment,
      breakEvenUnit: model.breakEvenUnit,
      formattedGrossProfit: model.formattedGrossProfit,
      formattedTotalCosts: model.formattedTotalCosts,
      formattedNetProfit: model.formattedNetProfit,
      formattedReturnOnInvestment: model.formattedReturnOnInvestment,
      formattedBreakEvenUnit: model.formattedBreakEvenUnit,
    );
  }

  @override
  List<Object?> get props => [
        grossProfit,
        totalCosts,
        netProfit,
        returnOnInvestment,
        breakEvenUnit,
        formattedGrossProfit,
        formattedTotalCosts,
        formattedNetProfit,
        formattedReturnOnInvestment,
        formattedBreakEvenUnit,
      ];
}
