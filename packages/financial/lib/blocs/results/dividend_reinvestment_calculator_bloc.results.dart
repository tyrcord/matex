// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexDividendReinvestmentCalculatorBlocResults
    extends FastCalculatorResults {
  final double? endingBalance;
  final String? formattedEndingBalance;
  final double? totalReturn;
  final String? formattedTotalReturn;
  final double? netDividendPaid;
  final String? formattedNetDividendPaid;
  final double? netDividendIncome;
  final String? formattedNetDividendIncome;
  final double? sharesOwned;
  final String? formattedSharesOwned;
  final double? sharePrice;
  final String? formattedSharePrice;
  final double? totalAdditionalContribution;
  final String? formattedTotalAdditionalContribution;
  final double? totalTaxAmount;
  final String? formattedTotalTaxAmount;
  final double? grossDividendPaid;
  final String? formattedGrossDividendPaid;
  final double? startingBalance;
  final String? formattedStartingBalance;

  const MatexDividendReinvestmentCalculatorBlocResults({
    this.endingBalance,
    this.formattedEndingBalance,
    this.totalReturn,
    this.formattedTotalReturn,
    this.netDividendPaid,
    this.formattedNetDividendPaid,
    this.netDividendIncome,
    this.formattedNetDividendIncome,
    this.sharesOwned,
    this.formattedSharesOwned,
    this.sharePrice,
    this.formattedSharePrice,
    this.totalAdditionalContribution,
    this.formattedTotalAdditionalContribution,
    this.totalTaxAmount,
    this.formattedTotalTaxAmount,
    this.grossDividendPaid,
    this.formattedGrossDividendPaid,
    this.startingBalance,
    this.formattedStartingBalance,
  });

  @override
  MatexDividendReinvestmentCalculatorBlocResults clone() => copyWith();

  @override
  MatexDividendReinvestmentCalculatorBlocResults copyWith({
    double? endingBalance,
    String? formattedEndingBalance,
    double? totalReturn,
    String? formattedTotalReturn,
    double? netDividendPaid,
    String? formattedNetDividendPaid,
    double? netDividendIncome,
    String? formattedNetDividendIncome,
    double? sharesOwned,
    String? formattedSharesOwned,
    double? sharePrice,
    String? formattedSharePrice,
    double? totalAdditionalContribution,
    String? formattedTotalAdditionalContribution,
    double? totalTaxAmount,
    String? formattedTotalTaxAmount,
    double? grossDividendPaid,
    String? formattedGrossDividendPaid,
    double? startingBalance,
    String? formattedStartingBalance,
  }) {
    return MatexDividendReinvestmentCalculatorBlocResults(
      endingBalance: endingBalance ?? this.endingBalance,
      formattedEndingBalance:
          formattedEndingBalance ?? this.formattedEndingBalance,
      totalReturn: totalReturn ?? this.totalReturn,
      formattedTotalReturn: formattedTotalReturn ?? this.formattedTotalReturn,
      netDividendPaid: netDividendPaid ?? this.netDividendPaid,
      formattedNetDividendPaid:
          formattedNetDividendPaid ?? this.formattedNetDividendPaid,
      netDividendIncome: netDividendIncome ?? this.netDividendIncome,
      formattedNetDividendIncome:
          formattedNetDividendIncome ?? this.formattedNetDividendIncome,
      sharesOwned: sharesOwned ?? this.sharesOwned,
      formattedSharesOwned: formattedSharesOwned ?? this.formattedSharesOwned,
      sharePrice: sharePrice ?? this.sharePrice,
      formattedSharePrice: formattedSharePrice ?? this.formattedSharePrice,
      totalAdditionalContribution:
          totalAdditionalContribution ?? this.totalAdditionalContribution,
      formattedTotalAdditionalContribution:
          formattedTotalAdditionalContribution ??
              this.formattedTotalAdditionalContribution,
      totalTaxAmount: totalTaxAmount ?? this.totalTaxAmount,
      formattedTotalTaxAmount:
          formattedTotalTaxAmount ?? this.formattedTotalTaxAmount,
      grossDividendPaid: grossDividendPaid ?? this.grossDividendPaid,
      formattedGrossDividendPaid:
          formattedGrossDividendPaid ?? this.formattedGrossDividendPaid,
    );
  }

  @override
  MatexDividendReinvestmentCalculatorBlocResults merge(
    covariant MatexDividendReinvestmentCalculatorBlocResults model,
  ) {
    return copyWith(
      endingBalance: model.endingBalance,
      formattedEndingBalance: model.formattedEndingBalance,
      totalReturn: model.totalReturn,
      formattedTotalReturn: model.formattedTotalReturn,
      netDividendPaid: model.netDividendPaid,
      formattedNetDividendPaid: model.formattedNetDividendPaid,
      netDividendIncome: model.netDividendIncome,
      formattedNetDividendIncome: model.formattedNetDividendIncome,
      sharesOwned: model.sharesOwned,
      formattedSharesOwned: model.formattedSharesOwned,
      sharePrice: model.sharePrice,
      formattedSharePrice: model.formattedSharePrice,
      totalAdditionalContribution: model.totalAdditionalContribution,
      formattedTotalAdditionalContribution:
          model.formattedTotalAdditionalContribution,
      totalTaxAmount: model.totalTaxAmount,
      formattedTotalTaxAmount: model.formattedTotalTaxAmount,
      grossDividendPaid: model.grossDividendPaid,
      formattedGrossDividendPaid: model.formattedGrossDividendPaid,
      startingBalance: model.startingBalance,
      formattedStartingBalance: model.formattedStartingBalance,
    );
  }

  @override
  List<Object?> get props => [
        endingBalance,
        formattedEndingBalance,
        totalReturn,
        formattedTotalReturn,
        netDividendPaid,
        formattedNetDividendPaid,
        netDividendIncome,
        formattedNetDividendIncome,
        sharesOwned,
        formattedSharesOwned,
        sharePrice,
        formattedSharePrice,
        totalAdditionalContribution,
        formattedTotalAdditionalContribution,
        totalTaxAmount,
        formattedTotalTaxAmount,
        grossDividendPaid,
        formattedGrossDividendPaid,
        startingBalance,
        formattedStartingBalance,
      ];
}
