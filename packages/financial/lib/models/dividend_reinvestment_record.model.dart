import 'package:tmodel/tmodel.dart';

class MatexDividendReinvestementRecord extends TModel {
  final double? dividendAmount;
  final double? numberOfshares;

  const MatexDividendReinvestementRecord({
    this.dividendAmount = 0,
    this.numberOfshares = 0,
  });

  @override
  MatexDividendReinvestementRecord clone() => copyWith();

  @override
  MatexDividendReinvestementRecord copyWith({
    double? dividendAmount,
    double? numberOfshares,
  }) {
    return MatexDividendReinvestementRecord(
      dividendAmount: dividendAmount ?? this.dividendAmount,
      numberOfshares: numberOfshares ?? this.numberOfshares,
    );
  }

  @override
  MatexDividendReinvestementRecord merge(
    covariant MatexDividendReinvestementRecord model,
  ) {
    return copyWith(
      dividendAmount: model.dividendAmount,
      numberOfshares: model.numberOfshares,
    );
  }

  @override
  List<double?> get props => [dividendAmount, numberOfshares];
}
