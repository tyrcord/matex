import 'package:matex_core/core.dart';

class MatexVatCalculatorState extends MatexCalculatorState {
  final double? regionalVatRate;
  final double? discountAmount;
  final double? priceBeforeVat;
  final double? federalVatRate;
  final double? discountPercentage;
  final double? tipRate;
  final double? vatRate;
  final double? customVatRate;

  const MatexVatCalculatorState({
    this.priceBeforeVat,
    this.federalVatRate,
    this.regionalVatRate,
    this.vatRate,
    this.customVatRate,
    this.discountAmount,
    this.discountPercentage,
    this.tipRate,
  });

  @override
  MatexVatCalculatorState clone() {
    return MatexVatCalculatorState(
      priceBeforeVat: priceBeforeVat,
      federalVatRate: federalVatRate,
      regionalVatRate: regionalVatRate,
      vatRate: vatRate,
      customVatRate: customVatRate,
      discountAmount: discountAmount,
      discountPercentage: discountPercentage,
      tipRate: tipRate,
    );
  }

  @override
  MatexVatCalculatorState copyWith({
    double? priceBeforeVat,
    double? federalVatRate,
    double? regionalVatRate,
    double? vatRate,
    double? customVatRate,
    double? discountAmount,
    double? discountPercentage,
    double? tipRate,
  }) {
    return MatexVatCalculatorState(
      priceBeforeVat: priceBeforeVat ?? this.priceBeforeVat,
      federalVatRate: federalVatRate ?? this.federalVatRate,
      regionalVatRate: regionalVatRate ?? this.regionalVatRate,
      vatRate: vatRate ?? this.vatRate,
      customVatRate: customVatRate ?? this.customVatRate,
      discountAmount: discountAmount ?? this.discountAmount,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      tipRate: tipRate ?? this.tipRate,
    );
  }

  @override
  MatexVatCalculatorState merge(covariant MatexVatCalculatorState model) {
    return copyWith(
      priceBeforeVat: model.priceBeforeVat,
      federalVatRate: model.federalVatRate,
      regionalVatRate: model.regionalVatRate,
      vatRate: model.vatRate,
      customVatRate: model.customVatRate,
      discountAmount: model.discountAmount,
      discountPercentage: model.discountPercentage,
      tipRate: model.tipRate,
    );
  }

  @override
  List<Object?> get props => [
        priceBeforeVat,
        federalVatRate,
        regionalVatRate,
        vatRate,
        customVatRate,
        discountAmount,
        discountPercentage,
        tipRate,
      ];
}
