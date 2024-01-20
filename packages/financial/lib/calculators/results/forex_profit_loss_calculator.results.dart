// Package imports:
import 'package:tmodel/tmodel.dart';

class MatexForexProfitLossCalculatorResults extends TModel {
  final double? returnOnInvestment;
  final double? netProfit;

  const MatexForexProfitLossCalculatorResults({
    this.returnOnInvestment,
    this.netProfit,
  });

  @override
  MatexForexProfitLossCalculatorResults clone() => copyWith();

  @override
  MatexForexProfitLossCalculatorResults copyWith({
    double? netProfit,
    double? returnOnInvestment,
  }) {
    return MatexForexProfitLossCalculatorResults(
      netProfit: netProfit ?? this.netProfit,
      returnOnInvestment: returnOnInvestment ?? this.returnOnInvestment,
    );
  }

  @override
  MatexForexProfitLossCalculatorResults merge(
    covariant MatexForexProfitLossCalculatorResults model,
  ) {
    return copyWith(
      netProfit: model.netProfit,
      returnOnInvestment: model.returnOnInvestment,
    );
  }

  @override
  List<Object?> get props => [
        netProfit,
        returnOnInvestment,
      ];
}
