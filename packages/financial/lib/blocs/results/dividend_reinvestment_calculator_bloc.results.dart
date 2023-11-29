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
  final double? annualNetDividendPaid;
  final String? formattedAnnualNetDividendPaid;
  final double? sharesOwned;
  final String? formattedSharesOwned;
  final double? sharePrice;
  final String? formattedSharePrice;
  final double? totalAdditionalContribution;
  final String? formattedTotalAdditionalContribution;
  final double? totalTaxAmount;
  final String? formattedTotalTaxAmount;

  const MatexDividendReinvestmentCalculatorBlocResults({
    this.endingBalance,
    this.formattedEndingBalance,
    this.totalReturn,
    this.formattedTotalReturn,
    this.netDividendPaid,
    this.formattedNetDividendPaid,
    this.annualNetDividendPaid,
    this.formattedAnnualNetDividendPaid,
    this.sharesOwned,
    this.formattedSharesOwned,
    this.sharePrice,
    this.formattedSharePrice,
    this.totalAdditionalContribution,
    this.formattedTotalAdditionalContribution,
    this.totalTaxAmount,
    this.formattedTotalTaxAmount,
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
    double? annualNetDividendPaid,
    String? formattedAnnualNetDividendPaid,
    double? sharesOwned,
    String? formattedSharesOwned,
    double? sharePrice,
    String? formattedSharePrice,
    double? totalAdditionalContribution,
    String? formattedTotalAdditionalContribution,
    double? totalTaxAmount,
    String? formattedTotalTaxAmount,
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
      annualNetDividendPaid:
          annualNetDividendPaid ?? this.annualNetDividendPaid,
      formattedAnnualNetDividendPaid:
          formattedAnnualNetDividendPaid ?? this.formattedAnnualNetDividendPaid,
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
      annualNetDividendPaid: model.annualNetDividendPaid,
      formattedAnnualNetDividendPaid: model.formattedAnnualNetDividendPaid,
      sharesOwned: model.sharesOwned,
      formattedSharesOwned: model.formattedSharesOwned,
      sharePrice: model.sharePrice,
      formattedSharePrice: model.formattedSharePrice,
      totalAdditionalContribution: model.totalAdditionalContribution,
      formattedTotalAdditionalContribution:
          model.formattedTotalAdditionalContribution,
      totalTaxAmount: model.totalTaxAmount,
      formattedTotalTaxAmount: model.formattedTotalTaxAmount,
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
        annualNetDividendPaid,
        formattedAnnualNetDividendPaid,
        sharesOwned,
        formattedSharesOwned,
        sharePrice,
        formattedSharePrice,
        totalAdditionalContribution,
        formattedTotalAdditionalContribution,
        totalTaxAmount,
        formattedTotalTaxAmount,
      ];
}
