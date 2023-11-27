import 'package:tmodel/tmodel.dart';

class DividendYieldResultsModel extends TModel {
  // Define Properties
  final double? dividendYield;

  // Constructor
  const DividendYieldResultsModel({
    this.dividendYield,
  });

  // Clone Method
  @override
  DividendYieldResultsModel clone() => copyWith();

  // From JSON Factory
  factory DividendYieldResultsModel.fromJson(Map<String, dynamic> json) {
    return DividendYieldResultsModel(
      dividendYield: json['dividendYield'] as double?,
    );
  }

  // Copy With Method
  @override
  DividendYieldResultsModel copyWith({
    double? dividendYield,
  }) {
    return DividendYieldResultsModel(
      dividendYield: dividendYield ?? this.dividendYield,
    );
  }

  // Copy With Defaults Method
  @override
  DividendYieldResultsModel copyWithDefaults({
    bool resetDividendYield = false,
  }) {
    return DividendYieldResultsModel(
      dividendYield: resetDividendYield ? null : dividendYield,
    );
  }

  // Merge Method
  @override
  DividendYieldResultsModel merge(covariant DividendYieldResultsModel model) {
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
