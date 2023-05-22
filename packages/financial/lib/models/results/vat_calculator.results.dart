import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexVatCalculatorBlocResults extends FastCalculatorResults {
  final String? totalTaxes;
  final String? total;
  final String? tipAmount;
  final String? grandTotal;
  final String? tipRate;
  final String? subTotal;

  const MatexVatCalculatorBlocResults({
    this.totalTaxes,
    this.total,
    this.tipAmount,
    this.grandTotal,
    this.tipRate,
    this.subTotal,
  });

  factory MatexVatCalculatorBlocResults.fromCalculatorResults(
    MatexVatCalculatorResults results,
  ) {
    return MatexVatCalculatorBlocResults(
      totalTaxes: results.totalTaxes?.toString(),
      total: results.total?.toString(),
      tipAmount: results.tipAmount?.toString(),
      grandTotal: results.grandTotal?.toString(),
      tipRate: results.tipRate?.toString(),
      subTotal: results.subTotal?.toString(),
    );
  }

  @override
  MatexVatCalculatorBlocResults clone() {
    return MatexVatCalculatorBlocResults(
      totalTaxes: totalTaxes,
      total: total,
      tipAmount: tipAmount,
      grandTotal: grandTotal,
      tipRate: tipRate,
      subTotal: subTotal,
    );
  }

  @override
  MatexVatCalculatorBlocResults copyWith({
    String? totalTaxes,
    String? total,
    String? tipAmount,
    String? grandTotal,
    String? tipRate,
    String? subTotal,
  }) {
    return MatexVatCalculatorBlocResults(
      totalTaxes: totalTaxes ?? this.totalTaxes,
      total: total ?? this.total,
      tipAmount: tipAmount ?? this.tipAmount,
      grandTotal: grandTotal ?? this.grandTotal,
      tipRate: tipRate ?? this.tipRate,
      subTotal: subTotal ?? this.subTotal,
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
      tipRate: model.tipRate,
      subTotal: model.subTotal,
    );
  }

  @override
  List<Object?> get props => [
        totalTaxes,
        total,
        tipAmount,
        grandTotal,
        tipRate,
        subTotal,
      ];
}
