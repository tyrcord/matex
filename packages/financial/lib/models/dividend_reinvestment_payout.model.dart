import 'package:decimal/decimal.dart';
import 'package:tmodel/tmodel.dart';
import 'package:t_helpers/helpers.dart';

class MatexDividendReinvestementPayout extends TModel {
  final double? grossDividendPayout;
  final double? netDividendPayout;

  Decimal get dGrossDividendPayout => toDecimal(grossDividendPayout) ?? dZero;
  Decimal get dNetDividendPayout => toDecimal(netDividendPayout) ?? dZero;

  const MatexDividendReinvestementPayout({
    this.grossDividendPayout,
    this.netDividendPayout,
  });

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
}
