import 'package:tmodel/tmodel.dart';

class MatexDividendYieldResultsModel extends TModel {
  // Define Properties
  final double? dividendYield;
  final double? totalDividends;
  final double? sharePrice;

  // Constructor
  const MatexDividendYieldResultsModel({
    this.dividendYield,
    this.totalDividends,
    this.sharePrice,
  });

  // Clone Method
  @override
  MatexDividendYieldResultsModel clone() => copyWith();

  // From JSON Factory
  factory MatexDividendYieldResultsModel.fromJson(Map<String, dynamic> json) {
    return MatexDividendYieldResultsModel(
      dividendYield: json['dividendYield'] as double?,
      sharePrice: json['sharePrice'] as double?,
      totalDividends: json['totalDividends'] as double?,
    );
  }

  // Copy With Method
  @override
  MatexDividendYieldResultsModel copyWith({
    double? dividendYield,
    double? totalDividends,
    double? sharePrice,
  }) {
    return MatexDividendYieldResultsModel(
      dividendYield: dividendYield ?? this.dividendYield,
      totalDividends: totalDividends ?? this.totalDividends,
      sharePrice: sharePrice ?? this.sharePrice,
    );
  }

  // Copy With Defaults Method
  @override
  MatexDividendYieldResultsModel copyWithDefaults({
    bool resetDividendYield = false,
    bool resetTotalDividends = false,
    bool resetSharePrice = false,
  }) {
    return MatexDividendYieldResultsModel(
      dividendYield: resetDividendYield ? null : dividendYield,
      totalDividends: resetTotalDividends ? null : totalDividends,
      sharePrice: resetSharePrice ? null : sharePrice,
    );
  }

  // Merge Method
  @override
  MatexDividendYieldResultsModel merge(
      covariant MatexDividendYieldResultsModel model) {
    return copyWith(
      dividendYield: model.dividendYield,
      totalDividends: model.totalDividends,
      sharePrice: model.sharePrice,
    );
  }

  // Props Getter
  @override
  List<Object?> get props => [dividendYield];

  // To JSON Method
  Map<String, dynamic> toJson() {
    return {
      'dividendYield': dividendYield,
      'sharePrice': sharePrice,
      'totalDividends': totalDividends,
    };
  }
}
