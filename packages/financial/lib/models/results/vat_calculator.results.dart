import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexVatCalculatorBlocResults extends FastCalculatorResults {
  final String? totalTaxes;
  final String? total;
  final String? tipAmount;
  final String? grandTotal;

  const MatexVatCalculatorBlocResults({
    this.totalTaxes,
    this.total,
    this.tipAmount,
    this.grandTotal,
  });

  factory MatexVatCalculatorBlocResults.fromCalculatorResults(
    MatexVatCalculatorResults results,
  ) {
    return MatexVatCalculatorBlocResults(
      totalTaxes: results.totalTaxes?.toString(),
      total: results.total?.toString(),
      tipAmount: results.tipAmount?.toString(),
      grandTotal: results.grandTotal?.toString(),
    );
  }

  @override
  MatexVatCalculatorBlocResults clone() {
    return MatexVatCalculatorBlocResults(
      totalTaxes: totalTaxes,
      total: total,
      tipAmount: tipAmount,
      grandTotal: grandTotal,
    );
  }

  @override
  MatexVatCalculatorBlocResults copyWith({
    String? totalTaxes,
    String? total,
    String? tipAmount,
    String? grandTotal,
  }) {
    return MatexVatCalculatorBlocResults(
      totalTaxes: totalTaxes ?? this.totalTaxes,
      total: total ?? this.total,
      tipAmount: tipAmount ?? this.tipAmount,
      grandTotal: grandTotal ?? this.grandTotal,
    );
  }

  @override
  MatexVatCalculatorBlocResults merge(
      covariant MatexVatCalculatorBlocResults model) {
    return copyWith(
      totalTaxes: model.totalTaxes,
      total: model.total,
      tipAmount: model.tipAmount,
      grandTotal: model.grandTotal,
    );
  }

  @override
  List<Object?> get props => [
        totalTaxes,
        total,
        tipAmount,
        grandTotal,
      ];
}
