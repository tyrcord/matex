import 'package:matex_financial/financial.dart';

class MatexDividendReinvestementYearlyPayoutReport
    extends MatexDividendReinvestementPayoutReport {
  final List<MatexDividendReinvestementPayoutReport> payouts;
  final double? dividendAmountPerShare;
  final double? cumulativeContribution;

  const MatexDividendReinvestementYearlyPayoutReport({
    this.payouts = const <MatexDividendReinvestementPayoutReport>[],
    this.dividendAmountPerShare,
    this.cumulativeContribution,
    super.additionalSharesFromAnnualContribution,
    super.additionalSharesFromDrip,
    super.cumulativeGrossAmount,
    super.grossDividendPayout,
    super.cumulativeNetAmount,
    super.netDividendPayout,
    super.averageSharePrice,
    super.numberOfShares,
    super.endingBalance,
    super.sharePrice,
  });

  @override
  List<dynamic> get props => [
        additionalSharesFromAnnualContribution,
        additionalSharesFromDrip,
        dividendAmountPerShare,
        cumulativeContribution,
        cumulativeGrossAmount,
        cumulativeNetAmount,
        grossDividendPayout,
        averageSharePrice,
        netDividendPayout,
        numberOfShares,
        endingBalance,
        sharePrice,
        payouts,
      ];
}
