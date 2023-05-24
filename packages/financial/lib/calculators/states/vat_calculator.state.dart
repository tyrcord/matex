import 'package:matex_core/core.dart';

//TODO: add tip amount

class MatexVatCalculatorState extends MatexCalculatorState {
  final double? discountRate;
  final double? regionalVatRate;
  final double? federalVatRate;
  final double? discountAmount;
  final double? priceBeforeVat;
  final double? customVatRate;
  final double? tipRate;
  final double? vatRate;

  const MatexVatCalculatorState({
    this.discountRate,
    this.regionalVatRate,
    this.federalVatRate,
    this.priceBeforeVat,
    this.discountAmount,
    this.customVatRate,
    this.tipRate,
    this.vatRate,
  });

  @override
  MatexVatCalculatorState clone() => copyWith();

  @override
  MatexVatCalculatorState copyWith({
    double? priceBeforeVat,
    double? federalVatRate,
    double? regionalVatRate,
    double? vatRate,
    double? customVatRate,
    double? discountAmount,
    double? discountRate,
    double? tipRate,
  }) {
    return MatexVatCalculatorState(
      priceBeforeVat: priceBeforeVat ?? this.priceBeforeVat,
      federalVatRate: federalVatRate ?? this.federalVatRate,
      regionalVatRate: regionalVatRate ?? this.regionalVatRate,
      vatRate: vatRate ?? this.vatRate,
      customVatRate: customVatRate ?? this.customVatRate,
      discountAmount: discountAmount ?? this.discountAmount,
      discountRate: discountRate ?? this.discountRate,
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
      discountRate: model.discountRate,
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
        discountRate,
        tipRate,
      ];
}
