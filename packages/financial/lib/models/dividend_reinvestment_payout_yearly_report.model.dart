import 'package:matex_financial/financial.dart';
import 'package:decimal/decimal.dart';
import 'package:t_helpers/helpers.dart';

class MatexDividendReinvestementYearlyPayoutReport
    extends MatexDividendReinvestementPayoutReport {
  final List<MatexDividendReinvestementPayoutReport> payouts;
  final double? dividendAmountPerShare;
  final double? cumulativeContribution;

  Decimal get dDividendAmountPerShare =>
      toDecimal(dividendAmountPerShare) ?? dZero;

  Decimal get dCumulativeContribution =>
      toDecimal(cumulativeContribution) ?? dZero;

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

  // From JSON Factory
  factory MatexDividendReinvestementYearlyPayoutReport.fromJson(
    Map<String, dynamic> json,
  ) {
    final payouts = (json['payouts'] as List<Map<String, dynamic>>?);

    return MatexDividendReinvestementYearlyPayoutReport(
      grossDividendPayout: json['grossDividendPayout'] as double?,
      netDividendPayout: json['netDividendPayout'] as double?,
      additionalSharesFromAnnualContribution:
          json['additionalSharesFromAnnualContribution'] as double?,
      additionalSharesFromDrip: json['additionalSharesFromDrip'] as double?,
      cumulativeGrossAmount: json['cumulativeGrossAmount'] as double?,
      cumulativeNetAmount: json['cumulativeNetAmount'] as double?,
      averageSharePrice: json['averageSharePrice'] as double?,
      numberOfShares: json['numberOfShares'] as double?,
      endingBalance: json['endingBalance'] as double?,
      sharePrice: json['sharePrice'] as double?,
      dividendAmountPerShare: json['dividendAmountPerShare'] as double?,
      cumulativeContribution: json['cumulativeContribution'] as double?,
      payouts: payouts?.map((Map<String, dynamic> e) {
            return MatexDividendReinvestementPayoutReport.fromJson(e);
          }).toList() ??
          const <MatexDividendReinvestementPayoutReport>[],
    );
  }

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

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'additionalSharesFromAnnualContribution':
          additionalSharesFromAnnualContribution,
      'additionalSharesFromDrip': additionalSharesFromDrip,
      'dividendAmountPerShare': dividendAmountPerShare,
      'cumulativeContribution': cumulativeContribution,
      'cumulativeGrossAmount': cumulativeGrossAmount,
      'cumulativeNetAmount': cumulativeNetAmount,
      'grossDividendPayout': grossDividendPayout,
      'netDividendPayout': netDividendPayout,
      'averageSharePrice': averageSharePrice,
      'numberOfShares': numberOfShares,
      'endingBalance': endingBalance,
      'sharePrice': sharePrice,
      'payouts': payouts,
    };
  }
}
