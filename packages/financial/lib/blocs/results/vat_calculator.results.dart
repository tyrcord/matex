// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexVatCalculatorBlocResults extends FastCalculatorResults {
  final double? totalTaxes;
  final double? total;
  final double? tipAmount;
  final double? grandTotal;
  final double? tipRate;
  final double? subTotal;
  final double? discountAmount;
  final double? discountRate;
  final double? customVatAmount;
  final double? federalVatAmount;
  final double? regionalVatAmount;
  final double? vatAmount;
  final String? formattedTotalTaxes;
  final String? formattedTotal;
  final String? formattedTipAmount;
  final String? formattedGrandTotal;
  final String? formattedTipRate;
  final String? formattedSubTotal;
  final String? formattedDiscountAmount;
  final String? formattedDiscountRate;
  final String? formattedCustomVatAmount;
  final String? formattedFederalVatAmount;
  final String? formattedRegionalVatAmount;
  final String? formattedVatAmount;

  const MatexVatCalculatorBlocResults({
    this.totalTaxes,
    this.total,
    this.tipAmount,
    this.grandTotal,
    this.tipRate,
    this.subTotal,
    this.discountAmount,
    this.discountRate,
    this.customVatAmount,
    this.federalVatAmount,
    this.regionalVatAmount,
    this.vatAmount,
    this.formattedTotalTaxes,
    this.formattedTotal,
    this.formattedTipAmount,
    this.formattedGrandTotal,
    this.formattedTipRate,
    this.formattedSubTotal,
    this.formattedDiscountAmount,
    this.formattedDiscountRate,
    this.formattedCustomVatAmount,
    this.formattedFederalVatAmount,
    this.formattedRegionalVatAmount,
    this.formattedVatAmount,
  });

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
    double? customVatAmount,
    double? federalVatAmount,
    double? regionalVatAmount,
    double? vatAmount,
    String? formattedTotalTaxes,
    String? formattedTotal,
    String? formattedTipAmount,
    String? formattedGrandTotal,
    String? formattedTipRate,
    String? formattedSubTotal,
    String? formattedDiscountAmount,
    String? formattedDiscountRate,
    String? formattedCustomVatAmount,
    String? formattedFederalVatAmount,
    String? formattedRegionalVatAmount,
    String? formattedVatAmount,
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
      customVatAmount: customVatAmount ?? this.customVatAmount,
      federalVatAmount: federalVatAmount ?? this.federalVatAmount,
      regionalVatAmount: regionalVatAmount ?? this.regionalVatAmount,
      vatAmount: vatAmount ?? this.vatAmount,
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
      formattedCustomVatAmount:
          formattedCustomVatAmount ?? this.formattedCustomVatAmount,
      formattedFederalVatAmount:
          formattedFederalVatAmount ?? this.formattedFederalVatAmount,
      formattedRegionalVatAmount:
          formattedRegionalVatAmount ?? this.formattedRegionalVatAmount,
      formattedVatAmount: formattedVatAmount ?? this.formattedVatAmount,
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
      customVatAmount: model.customVatAmount,
      federalVatAmount: model.federalVatAmount,
      regionalVatAmount: model.regionalVatAmount,
      vatAmount: model.vatAmount,
      formattedTotalTaxes: model.formattedTotalTaxes,
      formattedTotal: model.formattedTotal,
      formattedTipAmount: model.formattedTipAmount,
      formattedGrandTotal: model.formattedGrandTotal,
      formattedTipRate: model.formattedTipRate,
      formattedSubTotal: model.formattedSubTotal,
      formattedDiscountAmount: model.formattedDiscountAmount,
      formattedDiscountRate: model.formattedDiscountRate,
      formattedCustomVatAmount: model.formattedCustomVatAmount,
      formattedFederalVatAmount: model.formattedFederalVatAmount,
      formattedRegionalVatAmount: model.formattedRegionalVatAmount,
      formattedVatAmount: model.formattedVatAmount,
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
        customVatAmount,
        federalVatAmount,
        regionalVatAmount,
        vatAmount,
        formattedTotalTaxes,
        formattedTotal,
        formattedTipAmount,
        formattedGrandTotal,
        formattedTipRate,
        formattedSubTotal,
        formattedDiscountAmount,
        formattedDiscountRate,
        formattedCustomVatAmount,
        formattedFederalVatAmount,
        formattedRegionalVatAmount,
        formattedVatAmount,
      ];
}
