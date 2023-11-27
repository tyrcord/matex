import 'package:tmodel/tmodel.dart';

class DividendReinvestmentCalculatorResults extends TModel {
  // Define Properties
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
  const DividendReinvestmentCalculatorResults({
    this.netDividendeIncome,
    this.grossDividendPaid,
    this.totalContribution,
    this.netDividendPaid,
    this.startingBalance,
    this.numberOfShares,
    this.endingBalance,
    this.totalReturn,
    this.sharePrice,
  });

  // Clone Method
  @override
  DividendReinvestmentCalculatorResults clone() => copyWith();

  // From JSON Factory
  factory DividendReinvestmentCalculatorResults.fromJson(
      Map<String, dynamic> json) {
    return DividendReinvestmentCalculatorResults(
      netDividendeIncome: json['netDividendeIncome'] as double?,
      grossDividendPaid: json['grossDividendPaid'] as double?,
      totalContribution: json['totalContribution'] as double?,
      netDividendPaid: json['netDividendPaid'] as double?,
      startingBalance: json['startingBalance'] as double?,
      numberOfShares: json['numberOfShares'] as double?,
      endingBalance: json['endingBalance'] as double?,
      totalReturn: json['totalReturn'] as double?,
      sharePrice: json['sharePrice'] as double?,
    );
  }

  // Copy With Method
  @override
  DividendReinvestmentCalculatorResults copyWith({
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
    return DividendReinvestmentCalculatorResults(
      netDividendeIncome: netDividendeIncome ?? this.netDividendeIncome,
      grossDividendPaid: grossDividendPaid ?? this.grossDividendPaid,
      totalContribution: totalContribution ?? this.totalContribution,
      netDividendPaid: netDividendPaid ?? this.netDividendPaid,
      startingBalance: startingBalance ?? this.startingBalance,
      numberOfShares: numberOfShares ?? this.numberOfShares,
      endingBalance: endingBalance ?? this.endingBalance,
      totalReturn: totalReturn ?? this.totalReturn,
      sharePrice: sharePrice ?? this.sharePrice,
    );
  }

  // Copy With Defaults Method
  @override
  DividendReinvestmentCalculatorResults copyWithDefaults({
    bool resetNetDividendeIncome = false,
    bool resetGrossDividendPaid = false,
    bool resetTotalContribution = false,
    bool resetNetDividendPaid = false,
    bool resetStartingBalance = false,
    bool resetNumberOfShares = false,
    bool resetEndingBalance = false,
    bool resetTotalReturn = false,
    bool resetSharePrice = false,
  }) {
    return DividendReinvestmentCalculatorResults(
      netDividendeIncome: resetNetDividendeIncome ? null : netDividendeIncome,
      grossDividendPaid: resetGrossDividendPaid ? null : grossDividendPaid,
      totalContribution: resetTotalContribution ? null : totalContribution,
      netDividendPaid: resetNetDividendPaid ? null : netDividendPaid,
      startingBalance: resetStartingBalance ? null : startingBalance,
      numberOfShares: resetNumberOfShares ? null : numberOfShares,
      endingBalance: resetEndingBalance ? null : endingBalance,
      totalReturn: resetTotalReturn ? null : totalReturn,
      sharePrice: resetSharePrice ? null : sharePrice,
    );
  }

  // Merge Method
  @override
  DividendReinvestmentCalculatorResults merge(
      covariant DividendReinvestmentCalculatorResults model) {
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
      ];

  // To JSON Method
  Map<String, dynamic> toJson() {
    return {
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
