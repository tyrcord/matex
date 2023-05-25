import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexVatCalculatorBlocResults extends FastCalculatorResults {
  final double? totalTaxes;
  final double? total;
  final double? tipAmount;
  final double? grandTotal;
  final double? tipRate;
  final double? subTotal;
  final double? discountAmount;
  final double? discountRate;
  final String? formattedTotalTaxes;
  final String? formattedTotal;
  final String? formattedTipAmount;
  final String? formattedGrandTotal;
  final String? formattedTipRate;
  final String? formattedSubTotal;
  final String? formattedDiscountAmount;
  final String? formattedDiscountRate;

  const MatexVatCalculatorBlocResults({
    this.totalTaxes,
    this.total,
    this.tipAmount,
    this.grandTotal,
    this.tipRate,
    this.subTotal,
    this.discountAmount,
    this.discountRate,
    this.formattedTotalTaxes,
    this.formattedTotal,
    this.formattedTipAmount,
    this.formattedGrandTotal,
    this.formattedTipRate,
    this.formattedSubTotal,
    this.formattedDiscountAmount,
    this.formattedDiscountRate,
  });

  factory MatexVatCalculatorBlocResults.fromCalculatorResults(
    MatexVatCalculatorResults results,
  ) {
    return MatexVatCalculatorBlocResults(
      totalTaxes: results.totalTaxes,
      total: results.total,
      tipAmount: results.tipAmount,
      grandTotal: results.grandTotal,
      tipRate: results.tipRate,
      subTotal: results.subTotal,
      discountAmount: results.discountAmount,
      discountRate: results.discountRate,
      formattedTotalTaxes: results.totalTaxes?.toString(),
      formattedTotal: results.total?.toString(),
      formattedTipAmount: results.tipAmount?.toString(),
      formattedGrandTotal: results.grandTotal?.toString(),
      formattedTipRate: results.tipRate?.toString(),
      formattedSubTotal: results.subTotal?.toString(),
      formattedDiscountAmount: results.discountAmount?.toString(),
      formattedDiscountRate: results.discountRate?.toString(),
    );
  }

  @override
  MatexVatCalculatorBlocResults clone() => copyWith();

  @override
  MatexVatCalculatorBlocResults copyWith({
    double? totalTaxes,
    double? total,
    double? tipAmount,
    double? grandTotal,
    double? tipRate,
    double? subTotal,
    double? discountAmount,
    double? discountRate,
    String? formattedTotalTaxes,
    String? formattedTotal,
    String? formattedTipAmount,
    String? formattedGrandTotal,
    String? formattedTipRate,
    String? formattedSubTotal,
    String? formattedDiscountAmount,
    String? formattedDiscountRate,
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
      formattedTotalTaxes: formattedTotalTaxes ?? this.formattedTotalTaxes,
      formattedTotal: formattedTotal ?? this.formattedTotal,
      formattedTipAmount: formattedTipAmount ?? this.formattedTipAmount,
      formattedGrandTotal: formattedGrandTotal ?? this.formattedGrandTotal,
      formattedTipRate: formattedTipRate ?? this.formattedTipRate,
      formattedSubTotal: formattedSubTotal ?? this.formattedSubTotal,
      formattedDiscountAmount:
          formattedDiscountAmount ?? this.formattedDiscountAmount,
      formattedDiscountRate:
          formattedDiscountRate ?? this.formattedDiscountRate,
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
      formattedTotalTaxes: model.formattedTotalTaxes,
      formattedTotal: model.formattedTotal,
      formattedTipAmount: model.formattedTipAmount,
      formattedGrandTotal: model.formattedGrandTotal,
      formattedTipRate: model.formattedTipRate,
      formattedSubTotal: model.formattedSubTotal,
      formattedDiscountAmount: model.formattedDiscountAmount,
      formattedDiscountRate: model.formattedDiscountRate,
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
        formattedTotalTaxes,
        formattedTotal,
        formattedTipAmount,
        formattedGrandTotal,
        formattedTipRate,
        formattedSubTotal,
        formattedDiscountAmount,
        formattedDiscountRate,
      ];
}
