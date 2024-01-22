// Project imports:
import 'package:matex_financial/financial.dart';

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

  // From JSON Factory
  factory MatexDividendReinvestementPayoutReport.fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexDividendReinvestementPayoutReport(
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
    );
  }

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

  // To JSON Method
  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'additionalSharesFromAnnualContribution':
          additionalSharesFromAnnualContribution,
      'additionalSharesFromDrip': additionalSharesFromDrip,
      'cumulativeGrossAmount': cumulativeGrossAmount,
      'cumulativeNetAmount': cumulativeNetAmount,
      'averageSharePrice': averageSharePrice,
      'numberOfShares': numberOfShares,
      'endingBalance': endingBalance,
      'sharePrice': sharePrice,
      'grossDividendPayout': grossDividendPayout,
      'netDividendPayout': netDividendPayout,
    };
  }
}
