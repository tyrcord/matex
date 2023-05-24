import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexVatCalculatorBlocResults extends FastCalculatorResults {
  final String? totalTaxes;
  final String? total;
  final String? tipAmount;
  final String? grandTotal;
  final String? tipRate;
  final String? subTotal;
  final String? discountAmount;
  final String? discountRate;

  const MatexVatCalculatorBlocResults({
    this.totalTaxes,
    this.total,
    this.tipAmount,
    this.grandTotal,
    this.tipRate,
    this.subTotal,
    this.discountAmount,
    this.discountRate,
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
      discountAmount: results.discountAmount?.toString(),
      discountRate: results.discountRate?.toString(),
    );
  }

  @override
  MatexVatCalculatorBlocResults clone() => copyWith();

  @override
  MatexVatCalculatorBlocResults copyWith({
    String? totalTaxes,
    String? total,
    String? tipAmount,
    String? grandTotal,
    String? tipRate,
    String? subTotal,
    String? discountAmount,
    String? discountRate,
  }) {
    return MatexVatCalculatorBlocResults(
      totalTaxes: totalTaxes ?? this.totalTaxes,
      total: total ?? this.total,
      tipAmount: tipAmount ?? this.tipAmount,
      grandTotal: grandTotal ?? this.grandTotal,
      tipRate: tipRate ?? this.tipRate,
      subTotal: subTotal ?? this.subTotal,
      discountAmount: discountAmount ?? this.discountAmount,
      discountRate: discountRate ?? this.discountRate,
    );
  }

  @override
  MatexVatCalculatorBlocResults merge(
    covariant MatexVatCalculatorBlocResults model,
  ) {
    return copyWith(
      totalTaxes: model.totalTaxes,
      total: model.total,
      tipAmount: model.tipAmount,
      grandTotal: model.grandTotal,
      tipRate: model.tipRate,
      subTotal: model.subTotal,
      discountAmount: model.discountAmount,
      discountRate: model.discountRate,
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
        discountAmount,
        discountRate,
      ];
}
