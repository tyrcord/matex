import 'package:matex_financial/models/dividend_reinvestment_payout_yearly_report.model.dart';
import 'package:tmodel/tmodel.dart';

class MatexDividendReinvestmentCalculatorResults extends TModel {
  // Define Properties
  final List<MatexDividendReinvestementYearlyPayoutReport>? reports;
  final double? netDividendeIncome;
  final double? grossDividendPaid;
  final double? totalContribution;
  final double? netDividendPaid;
  final double? startingBalance;
  final double? numberOfShares;
  final double? endingBalance;
  final double? totalReturn;
  final double? sharePrice;

  // Constructor
  const MatexDividendReinvestmentCalculatorResults({
    this.netDividendeIncome,
    this.grossDividendPaid,
    this.totalContribution,
    this.netDividendPaid,
    this.startingBalance,
    this.numberOfShares,
    this.endingBalance,
    this.totalReturn,
    this.sharePrice,
    this.reports,
  });

  // Clone Method
  @override
  MatexDividendReinvestmentCalculatorResults clone() => copyWith();

  // From JSON Factory
  factory MatexDividendReinvestmentCalculatorResults.fromJson(
    Map<String, dynamic> json,
  ) {
    final reports = (json['reports'] as List<Map<String, dynamic>>?);

    return MatexDividendReinvestmentCalculatorResults(
      netDividendeIncome: json['netDividendeIncome'] as double?,
      grossDividendPaid: json['grossDividendPaid'] as double?,
      totalContribution: json['totalContribution'] as double?,
      netDividendPaid: json['netDividendPaid'] as double?,
      startingBalance: json['startingBalance'] as double?,
      numberOfShares: json['numberOfShares'] as double?,
      endingBalance: json['endingBalance'] as double?,
      totalReturn: json['totalReturn'] as double?,
      sharePrice: json['sharePrice'] as double?,
      reports: reports?.map((Map<String, dynamic> report) {
        return MatexDividendReinvestementYearlyPayoutReport.fromJson(report);
      }).toList(),
    );
  }

  // Copy With Method
  @override
  MatexDividendReinvestmentCalculatorResults copyWith({
    List<MatexDividendReinvestementYearlyPayoutReport>? reports,
    double? netDividendeIncome,
    double? grossDividendPaid,
    double? totalContribution,
    double? netDividendPaid,
    double? startingBalance,
    double? numberOfShares,
    double? endingBalance,
    double? totalReturn,
    double? sharePrice,
  }) {
    return MatexDividendReinvestmentCalculatorResults(
      netDividendeIncome: netDividendeIncome ?? this.netDividendeIncome,
      grossDividendPaid: grossDividendPaid ?? this.grossDividendPaid,
      totalContribution: totalContribution ?? this.totalContribution,
      netDividendPaid: netDividendPaid ?? this.netDividendPaid,
      startingBalance: startingBalance ?? this.startingBalance,
      numberOfShares: numberOfShares ?? this.numberOfShares,
      endingBalance: endingBalance ?? this.endingBalance,
      totalReturn: totalReturn ?? this.totalReturn,
      sharePrice: sharePrice ?? this.sharePrice,
      reports: reports ?? this.reports,
    );
  }

  // Copy With Defaults Method
  @override
  MatexDividendReinvestmentCalculatorResults copyWithDefaults({
    bool resetNetDividendeIncome = false,
    bool resetGrossDividendPaid = false,
    bool resetTotalContribution = false,
    bool resetNetDividendPaid = false,
    bool resetStartingBalance = false,
    bool resetNumberOfShares = false,
    bool resetEndingBalance = false,
    bool resetTotalReturn = false,
    bool resetSharePrice = false,
    bool resetReports = false,
  }) {
    return MatexDividendReinvestmentCalculatorResults(
      netDividendeIncome: resetNetDividendeIncome ? null : netDividendeIncome,
      grossDividendPaid: resetGrossDividendPaid ? null : grossDividendPaid,
      totalContribution: resetTotalContribution ? null : totalContribution,
      netDividendPaid: resetNetDividendPaid ? null : netDividendPaid,
      startingBalance: resetStartingBalance ? null : startingBalance,
      numberOfShares: resetNumberOfShares ? null : numberOfShares,
      endingBalance: resetEndingBalance ? null : endingBalance,
      totalReturn: resetTotalReturn ? null : totalReturn,
      sharePrice: resetSharePrice ? null : sharePrice,
      reports: resetReports ? null : reports,
    );
  }

  // Merge Method
  @override
  MatexDividendReinvestmentCalculatorResults merge(
      covariant MatexDividendReinvestmentCalculatorResults model) {
    return copyWith(
      netDividendeIncome: model.netDividendeIncome,
      grossDividendPaid: model.grossDividendPaid,
      totalContribution: model.totalContribution,
      netDividendPaid: model.netDividendPaid,
      startingBalance: model.startingBalance,
      numberOfShares: model.numberOfShares,
      endingBalance: model.endingBalance,
      totalReturn: model.totalReturn,
      sharePrice: model.sharePrice,
      reports: model.reports,
    );
  }

  // Props Getter
  @override
  List<Object?> get props => [
        netDividendeIncome,
        grossDividendPaid,
        totalContribution,
        netDividendPaid,
        startingBalance,
        numberOfShares,
        endingBalance,
        totalReturn,
        sharePrice,
        reports,
      ];

  // To JSON Method
  Map<String, dynamic> toJson() {
    return {
      'reports': reports?.map((report) => report.toJson()).toList(),
      'netDividendeIncome': netDividendeIncome,
      'grossDividendPaid': grossDividendPaid,
      'totalContribution': totalContribution,
      'netDividendPaid': netDividendPaid,
      'startingBalance': startingBalance,
      'numberOfShares': numberOfShares,
      'endingBalance': endingBalance,
      'totalReturn': totalReturn,
      'sharePrice': sharePrice,
    };
  }
}
