// Package imports:
import 'package:tmodel/tmodel.dart';

class MatexDividendReinvestementPayout extends TModel {
  final double? grossDividendPayout;
  final double? netDividendPayout;

  const MatexDividendReinvestementPayout({
    this.grossDividendPayout,
    this.netDividendPayout,
  });

  // From JSON Factory
  factory MatexDividendReinvestementPayout.fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexDividendReinvestementPayout(
      grossDividendPayout: json['grossDividendPayout'] as double?,
      netDividendPayout: json['netDividendPayout'] as double?,
    );
  }

  @override
  MatexDividendReinvestementPayout clone() => copyWith();

  @override
  MatexDividendReinvestementPayout copyWith({
    double? grossDividendPayout,
    double? netDividendPayout,
  }) {
    return MatexDividendReinvestementPayout(
      grossDividendPayout: grossDividendPayout ?? this.grossDividendPayout,
      netDividendPayout: netDividendPayout ?? this.netDividendPayout,
    );
  }

  @override
  MatexDividendReinvestementPayout merge(
    covariant MatexDividendReinvestementPayout model,
  ) {
    return copyWith(
      grossDividendPayout: model.grossDividendPayout,
      netDividendPayout: model.netDividendPayout,
    );
  }

  @override
  List<dynamic> get props => [grossDividendPayout, netDividendPayout];

  Map<String, dynamic> toJson() {
    return {
      'grossDividendPayout': grossDividendPayout,
      'netDividendPayout': netDividendPayout,
    };
  }
}
