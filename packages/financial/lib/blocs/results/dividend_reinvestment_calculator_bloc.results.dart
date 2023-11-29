// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexDividendReinvestmentCalculatorBlocResults
    extends FastCalculatorResults {
  final double? endingBalance;
  final String? formattedEndingBalance;

  const MatexDividendReinvestmentCalculatorBlocResults({
    this.endingBalance,
    this.formattedEndingBalance,
  });

  @override
  MatexDividendReinvestmentCalculatorBlocResults clone() => copyWith();

  @override
  MatexDividendReinvestmentCalculatorBlocResults copyWith({
    double? endingBalance,
    String? formattedEndingBalance,
    String? dividendPayoutLevel,
  }) {
    return MatexDividendReinvestmentCalculatorBlocResults(
      endingBalance: endingBalance ?? this.endingBalance,
      formattedEndingBalance:
          formattedEndingBalance ?? this.formattedEndingBalance,
    );
  }

  @override
  MatexDividendReinvestmentCalculatorBlocResults merge(
    covariant MatexDividendReinvestmentCalculatorBlocResults model,
  ) {
    return copyWith(
      endingBalance: model.endingBalance,
      formattedEndingBalance: model.formattedEndingBalance,
    );
  }

  @override
  List<Object?> get props => [
        endingBalance,
        formattedEndingBalance,
      ];
}
