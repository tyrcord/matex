import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexVatCalculatorBlocFields extends FastCalculatorFields {
  final String? discountPercentage;
  final String? regionalVatRate;
  final String? federalVatRate;
  final String? discountAmount;
  final String? priceBeforeVat;
  final String? customVatRate;
  final String? tipRate;
  final String? vatRate;

  const MatexVatCalculatorBlocFields({
    this.discountPercentage,
    this.regionalVatRate,
    this.federalVatRate,
    this.discountAmount,
    this.priceBeforeVat,
    this.customVatRate,
    this.tipRate,
    this.vatRate,
  });

  @override
  MatexVatCalculatorBlocFields clone() {
    return MatexVatCalculatorBlocFields(
      discountPercentage: discountPercentage,
      regionalVatRate: regionalVatRate,
      federalVatRate: federalVatRate,
      discountAmount: discountAmount,
      priceBeforeVat: priceBeforeVat,
      customVatRate: customVatRate,
      tipRate: tipRate,
      vatRate: vatRate,
    );
  }

  @override
  MatexVatCalculatorBlocFields copyWith({
    String? discountPercentage,
    String? regionalVatRate,
    String? federalVatRate,
    String? discountAmount,
    String? priceBeforeVat,
    String? customVatRate,
    String? tipRate,
    String? vatRate,
  }) {
    return MatexVatCalculatorBlocFields(
      discountPercentage: discountPercentage ?? this.discountPercentage,
      federalVatRate: federalVatRate ?? this.federalVatRate,
      regionalVatRate: regionalVatRate ?? this.regionalVatRate,
      discountAmount: discountAmount ?? this.discountAmount,
      priceBeforeVat: priceBeforeVat ?? this.priceBeforeVat,
      customVatRate: customVatRate ?? this.customVatRate,
      tipRate: tipRate ?? this.tipRate,
      vatRate: vatRate ?? this.vatRate,
    );
  }

  @override
  MatexVatCalculatorBlocFields merge(
      covariant MatexVatCalculatorBlocFields model) {
    return copyWith(
      discountPercentage: model.discountPercentage,
      regionalVatRate: model.regionalVatRate,
      federalVatRate: model.federalVatRate,
      discountAmount: model.discountAmount,
      priceBeforeVat: model.priceBeforeVat,
      customVatRate: model.customVatRate,
      tipRate: model.tipRate,
      vatRate: model.vatRate,
    );
  }

  @override
  List<Object?> get props => [
        discountPercentage,
        regionalVatRate,
        federalVatRate,
        discountAmount,
        priceBeforeVat,
        customVatRate,
        tipRate,
        vatRate,
      ];
}
