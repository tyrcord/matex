// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

class MatexVatCalculatorBlocFields extends FastCalculatorFields {
  late final String? regionalVatRate;
  late final String? federalVatRate;
  late final String? discountAmount;
  late final String? priceBeforeVat;
  late final String? customVatRate;
  late final String? tipRate;
  late final String? vatRate;
  late final String? discountRate;
  late final String? tipAmount;
  late final String tipFieldType;
  late final String discountFieldType;

  MatexVatCalculatorBlocFields({
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
  })  : tipFieldType = tipFieldType ?? 'percent',
        discountFieldType = discountFieldType ?? 'amount' {
    this.regionalVatRate = assignValue(regionalVatRate);
    this.federalVatRate = assignValue(federalVatRate);
    this.discountAmount = assignValue(discountAmount);
    this.priceBeforeVat = assignValue(priceBeforeVat);
    this.customVatRate = assignValue(customVatRate);
    this.tipRate = assignValue(tipRate);
    this.vatRate = assignValue(vatRate);
    this.discountRate = assignValue(discountRate);
    this.tipAmount = assignValue(tipAmount);
  }

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
