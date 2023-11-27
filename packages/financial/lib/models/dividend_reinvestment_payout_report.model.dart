import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';
import 'package:decimal/decimal.dart';

class MatexDividendReinvestementPayoutReport
    extends MatexDividendReinvestementPayout {
  final double? additionalSharesFromAnnualContribution;
  final double? additionalSharesFromDrip;
  final double? cumulativeGrossAmount;
  final double? cumulativeNetAmount;
  final double? averageSharePrice;
  final double? numberOfShares;
  final double? endingBalance;
  final double? sharePrice;

  Decimal get dAdditionalSharesFromAnnualContribution =>
      toDecimal(additionalSharesFromAnnualContribution) ?? dZero;

  Decimal get dAdditionalSharesFromDrip =>
      toDecimal(additionalSharesFromDrip) ?? dZero;

  Decimal get dCumulativeGrossAmount =>
      toDecimal(cumulativeGrossAmount) ?? dZero;

  Decimal get dCumulativeNetAmount => toDecimal(cumulativeNetAmount) ?? dZero;
  Decimal get dAverageSharePrice => toDecimal(averageSharePrice) ?? dZero;
  Decimal get dNumberOfShares => toDecimal(numberOfShares) ?? dZero;
  Decimal get dEndingBalance => toDecimal(endingBalance) ?? dZero;
  Decimal get dSharePrice => toDecimal(sharePrice) ?? dZero;

  const MatexDividendReinvestementPayoutReport({
    this.additionalSharesFromAnnualContribution,
    this.additionalSharesFromDrip,
    this.cumulativeGrossAmount,
    super.grossDividendPayout,
    this.cumulativeNetAmount,
    super.netDividendPayout,
    this.averageSharePrice,
    this.numberOfShares,
    this.endingBalance,
    this.sharePrice,
  });

  @override
  List<dynamic> get props => [
        additionalSharesFromAnnualContribution,
        additionalSharesFromDrip,
        cumulativeGrossAmount,
        cumulativeNetAmount,
        grossDividendPayout,
        averageSharePrice,
        netDividendPayout,
        numberOfShares,
        endingBalance,
        sharePrice,
      ];

  @override
  MatexDividendReinvestementPayoutReport clone() => copyWith();

  @override
  MatexDividendReinvestementPayoutReport copyWith({
    double? additionalSharesFromAnnualContribution,
    double? additionalSharesFromDrip,
    double? cumulativeGrossAmount,
    double? cumulativeNetAmount,
    double? averageSharePrice,
    double? numberOfShares,
    double? endingBalance,
    double? sharePrice,
    double? grossDividendPayout,
    double? netDividendPayout,
  }) {
    return MatexDividendReinvestementPayoutReport(
      additionalSharesFromAnnualContribution:
          additionalSharesFromAnnualContribution ??
              this.additionalSharesFromAnnualContribution,
      additionalSharesFromDrip:
          additionalSharesFromDrip ?? this.additionalSharesFromDrip,
      cumulativeGrossAmount:
          cumulativeGrossAmount ?? this.cumulativeGrossAmount,
      cumulativeNetAmount: cumulativeNetAmount ?? this.cumulativeNetAmount,
      averageSharePrice: averageSharePrice ?? this.averageSharePrice,
      numberOfShares: numberOfShares ?? this.numberOfShares,
      endingBalance: endingBalance ?? this.endingBalance,
      sharePrice: sharePrice ?? this.sharePrice,
      grossDividendPayout: grossDividendPayout ?? this.grossDividendPayout,
      netDividendPayout: netDividendPayout ?? this.netDividendPayout,
    );
  }

  @override
  MatexDividendReinvestementPayoutReport merge(
    covariant MatexDividendReinvestementPayoutReport model,
  ) {
    return copyWith(
      additionalSharesFromAnnualContribution:
          model.additionalSharesFromAnnualContribution,
      additionalSharesFromDrip: model.additionalSharesFromDrip,
      cumulativeGrossAmount: model.cumulativeGrossAmount,
      cumulativeNetAmount: model.cumulativeNetAmount,
      averageSharePrice: model.averageSharePrice,
      numberOfShares: model.numberOfShares,
      endingBalance: model.endingBalance,
      sharePrice: model.sharePrice,
      grossDividendPayout: model.grossDividendPayout,
      netDividendPayout: model.netDividendPayout,
    );
  }
}
