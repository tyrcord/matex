// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexVatCalculatorBlocFields extends FastCalculatorFields {
  final String? regionalVatRate;
  final String? federalVatRate;
  final String? discountAmount;
  final String? priceBeforeVat;
  final String? customVatRate;
  final String? tipRate;
  final String? vatRate;
  final String? discountRate;
  final String? tipAmount;
  final String tipFieldType;
  final String discountFieldType;

  const MatexVatCalculatorBlocFields({
    this.regionalVatRate,
    this.federalVatRate,
    this.discountAmount,
    this.priceBeforeVat,
    this.customVatRate,
    this.tipRate,
    this.vatRate,
    this.discountRate,
    this.tipAmount,
    String? tipFieldType,
    String? discountFieldType,
  })  : tipFieldType = tipFieldType ?? 'percent',
        discountFieldType = discountFieldType ?? 'amount';

  @override
  MatexVatCalculatorBlocFields clone() => copyWith();

  @override
  MatexVatCalculatorBlocFields copyWith({
    String? regionalVatRate,
    String? federalVatRate,
    String? discountAmount,
    String? priceBeforeVat,
    String? customVatRate,
    String? tipRate,
    String? vatRate,
    String? discountRate,
    String? tipAmount,
    String? tipFieldType,
    String? discountFieldType,
  }) {
    return MatexVatCalculatorBlocFields(
      federalVatRate: federalVatRate ?? this.federalVatRate,
      regionalVatRate: regionalVatRate ?? this.regionalVatRate,
      discountAmount: discountAmount ?? this.discountAmount,
      priceBeforeVat: priceBeforeVat ?? this.priceBeforeVat,
      customVatRate: customVatRate ?? this.customVatRate,
      tipRate: tipRate ?? this.tipRate,
      vatRate: vatRate ?? this.vatRate,
      discountRate: discountRate ?? this.discountRate,
      tipAmount: tipAmount ?? this.tipAmount,
      tipFieldType: tipFieldType ?? this.tipFieldType,
      discountFieldType: discountFieldType ?? this.discountFieldType,
    );
  }

  @override
  MatexVatCalculatorBlocFields merge(
    covariant MatexVatCalculatorBlocFields model,
  ) {
    return copyWith(
      regionalVatRate: model.regionalVatRate,
      federalVatRate: model.federalVatRate,
      discountAmount: model.discountAmount,
      priceBeforeVat: model.priceBeforeVat,
      customVatRate: model.customVatRate,
      tipRate: model.tipRate,
      vatRate: model.vatRate,
      discountRate: model.discountRate,
      tipAmount: model.tipAmount,
      tipFieldType: model.tipFieldType,
      discountFieldType: model.discountFieldType,
    );
  }

  @override
  List<Object?> get props => [
        regionalVatRate,
        federalVatRate,
        discountAmount,
        priceBeforeVat,
        customVatRate,
        tipRate,
        vatRate,
        discountRate,
        tipAmount,
        tipFieldType,
        discountFieldType,
      ];
}
