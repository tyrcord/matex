import 'package:tmodel/tmodel.dart';

class MatexDividendYieldResultsModel extends TModel {
  // Define Properties
  final double? dividendYield;

  // Constructor
  const MatexDividendYieldResultsModel({
    this.dividendYield,
  });

  // Clone Method
  @override
  MatexDividendYieldResultsModel clone() => copyWith();

  // From JSON Factory
  factory MatexDividendYieldResultsModel.fromJson(Map<String, dynamic> json) {
    return MatexDividendYieldResultsModel(
      dividendYield: json['dividendYield'] as double?,
    );
  }

  // Copy With Method
  @override
  MatexDividendYieldResultsModel copyWith({
    double? dividendYield,
  }) {
    return MatexDividendYieldResultsModel(
      dividendYield: dividendYield ?? this.dividendYield,
    );
  }

  // Copy With Defaults Method
  @override
  MatexDividendYieldResultsModel copyWithDefaults({
    bool resetDividendYield = false,
  }) {
    return MatexDividendYieldResultsModel(
      dividendYield: resetDividendYield ? null : dividendYield,
    );
  }

  // Merge Method
  @override
  MatexDividendYieldResultsModel merge(
      covariant MatexDividendYieldResultsModel model) {
    return copyWith(
      dividendYield: model.dividendYield,
    );
  }

  // Props Getter
  @override
  List<Object?> get props => [dividendYield];

  // To JSON Method
  Map<String, dynamic> toJson() {
    return {
      'dividendYield': dividendYield,
    };
  }
}
