import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexProfitAndLossCalculatorBlocResults extends FastCalculatorResults {
  final double? grossProfit;
  final double? operatingExpenses;
  final double? netProfit;
  final double? returnOnInvestment;
  final double? breakEvenUnit;

  final String? formattedGrossProfit;
  final String? formattedOperatingExpenses;
  final String? formattedNetProfit;
  final String? formattedReturnOnInvestment;
  final String? formattedBreakEvenUnit;

  const MatexProfitAndLossCalculatorBlocResults({
    this.grossProfit,
    this.operatingExpenses,
    this.netProfit,
    this.returnOnInvestment,
    this.breakEvenUnit,
    this.formattedGrossProfit,
    this.formattedOperatingExpenses,
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
  //     operatingExpenses: results.operatingExpenses,
  //     netProfit: results.netProfit,
  //     returnOnInvestment: results.returnOnInvestment,
  //     breakEvenUnit: results.breakEvenUnit,
  //     // formatted values
  //     formattedGrossProfit: results.formattedGrossProfit,
  //     formattedOperatingExpenses: results.formattedOperatingExpenses,
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
    double? operatingExpenses,
    double? netProfit,
    double? returnOnInvestment,
    double? breakEvenUnit,
    String? formattedGrossProfit,
    String? formattedOperatingExpenses,
    String? formattedNetProfit,
    String? formattedReturnOnInvestment,
    String? formattedBreakEvenUnit,
  }) {
    return MatexProfitAndLossCalculatorBlocResults(
      grossProfit: grossProfit ?? this.grossProfit,
      operatingExpenses: operatingExpenses ?? this.operatingExpenses,
      netProfit: netProfit ?? this.netProfit,
      returnOnInvestment: returnOnInvestment ?? this.returnOnInvestment,
      breakEvenUnit: breakEvenUnit ?? this.breakEvenUnit,
      formattedGrossProfit: formattedGrossProfit ?? this.formattedGrossProfit,
      formattedOperatingExpenses:
          formattedOperatingExpenses ?? this.formattedOperatingExpenses,
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
      operatingExpenses: model.operatingExpenses,
      netProfit: model.netProfit,
      returnOnInvestment: model.returnOnInvestment,
      breakEvenUnit: model.breakEvenUnit,
      formattedGrossProfit: model.formattedGrossProfit,
      formattedOperatingExpenses: model.formattedOperatingExpenses,
      formattedNetProfit: model.formattedNetProfit,
      formattedReturnOnInvestment: model.formattedReturnOnInvestment,
      formattedBreakEvenUnit: model.formattedBreakEvenUnit,
    );
  }

  @override
  List<Object?> get props => [
        grossProfit,
        operatingExpenses,
        netProfit,
        returnOnInvestment,
        breakEvenUnit,
        formattedGrossProfit,
        formattedOperatingExpenses,
        formattedNetProfit,
        formattedReturnOnInvestment,
        formattedBreakEvenUnit,
      ];
}
