// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexForexProfitLossCalculatorBlocResults extends FastCalculatorResults {
  final double? netProfit;
  final double? returnOnInvestment;

  final String? formattedNetProfit;
  final String? formattedReturnOnInvestment;

  const MatexForexProfitLossCalculatorBlocResults({
    this.formattedNetProfit,
    this.formattedReturnOnInvestment,
    this.netProfit,
    this.returnOnInvestment,
  });

  @override
  MatexForexProfitLossCalculatorBlocResults clone() => copyWith();

  @override
  MatexForexProfitLossCalculatorBlocResults copyWith({
    String? formattedNetProfit,
    String? formattedReturnOnInvestment,
    double? netProfit,
    double? returnOnInvestment,
  }) {
    return MatexForexProfitLossCalculatorBlocResults(
      formattedNetProfit: formattedNetProfit ?? this.formattedNetProfit,
      formattedReturnOnInvestment:
          formattedReturnOnInvestment ?? this.formattedReturnOnInvestment,
      netProfit: netProfit ?? this.netProfit,
      returnOnInvestment: returnOnInvestment ?? this.returnOnInvestment,
    );
  }

  @override
  MatexForexProfitLossCalculatorBlocResults merge(
    covariant MatexForexProfitLossCalculatorBlocResults model,
  ) {
    return copyWith(
      formattedNetProfit: model.formattedNetProfit,
      formattedReturnOnInvestment: model.formattedReturnOnInvestment,
      netProfit: model.netProfit,
      returnOnInvestment: model.returnOnInvestment,
    );
  }

  @override
  List<Object?> get props => [
        formattedNetProfit,
        formattedReturnOnInvestment,
        netProfit,
        returnOnInvestment,
      ];
}
