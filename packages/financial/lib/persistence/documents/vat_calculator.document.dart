// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexVatCalculatorBlocDocument extends FastCalculatorDocument {
  final String defaulDiscountFieldType = 'amount';
  final String defaulTipFieldType = 'percent';

  late final String discountFieldType;
  late final String? regionalVatRate;
  late final String? federalVatRate;
  late final String? discountAmount;
  late final String? priceBeforeVat;
  late final String? customVatRate;
  late final String? discountRate;
  late final String tipFieldType;
  late final String? tipAmount;
  late final String? tipRate;
  late final String? vatRate;

  static MatexVatCalculatorBlocDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexVatCalculatorBlocDocument(
      discountFieldType: json['discountFieldType'] as String?,
      regionalVatRate: json['regionalVatRate'] as String?,
      federalVatRate: json['federalVatRate'] as String?,
      discountAmount: json['discountAmount'] as String?,
      priceBeforeVat: json['priceBeforeVat'] as String?,
      customVatRate: json['customVatRate'] as String?,
      tipFieldType: json['tipFieldType'] as String?,
      discountRate: json['discountRate'] as String?,
      tipAmount: json['tipAmount'] as String?,
      tipRate: json['tipRate'] as String?,
      vatRate: json['vatRate'] as String?,
    );
  }

  MatexVatCalculatorBlocDocument({
    String? discountFieldType,
    String? regionalVatRate,
    String? federalVatRate,
    String? discountAmount,
    String? priceBeforeVat,
    String? customVatRate,
    String? discountRate,
    String? tipFieldType,
    String? tipAmount,
    String? tipRate,
    String? vatRate,
  }) {
    this.tipFieldType = assignValue(tipFieldType) ?? defaulTipFieldType;
    this.regionalVatRate = assignValue(regionalVatRate);
    this.federalVatRate = assignValue(federalVatRate);
    this.discountAmount = assignValue(discountAmount);
    this.priceBeforeVat = assignValue(priceBeforeVat);
    this.customVatRate = assignValue(customVatRate);
    this.discountRate = assignValue(discountRate);
    this.tipAmount = assignValue(tipAmount);
    this.tipRate = assignValue(tipRate);
    this.vatRate = assignValue(vatRate);
    this.discountFieldType =
        assignValue(discountFieldType) ?? defaulDiscountFieldType;
  }

  @override
  MatexVatCalculatorBlocDocument clone() => copyWith();

  @override
  MatexVatCalculatorBlocDocument copyWith({
    String? discountFieldType,
    String? regionalVatRate,
    String? federalVatRate,
    String? discountAmount,
    String? priceBeforeVat,
    String? customVatRate,
    String? discountRate,
    String? tipFieldType,
    String? tipAmount,
    String? tipRate,
    String? vatRate,
  }) {
    return MatexVatCalculatorBlocDocument(
      discountFieldType: discountFieldType ?? this.discountFieldType,
      regionalVatRate: regionalVatRate ?? this.regionalVatRate,
      federalVatRate: federalVatRate ?? this.federalVatRate,
      discountAmount: discountAmount ?? this.discountAmount,
      priceBeforeVat: priceBeforeVat ?? this.priceBeforeVat,
      customVatRate: customVatRate ?? this.customVatRate,
      discountRate: discountRate ?? this.discountRate,
      tipFieldType: tipFieldType ?? this.tipFieldType,
      tipAmount: tipAmount ?? this.tipAmount,
      tipRate: tipRate ?? this.tipRate,
      vatRate: vatRate ?? this.vatRate,
    );
  }

  @override
  MatexVatCalculatorBlocDocument copyWithDefaults({
    bool resetDiscountFieldType = false,
    bool resetRegionalVatRate = false,
    bool resetFederalVatRate = false,
    bool resetDiscountAmount = false,
    bool resetPriceBeforeVat = false,
    bool resetCustomVatRate = false,
    bool resetDiscountRate = false,
    bool resetTipFieldType = false,
    bool resetTipAmount = false,
    bool resetTipRate = false,
    bool resetVatRate = false,
  }) {
    return MatexVatCalculatorBlocDocument(
      discountFieldType: resetDiscountFieldType ? null : discountFieldType,
      regionalVatRate: resetRegionalVatRate ? null : regionalVatRate,
      federalVatRate: resetFederalVatRate ? null : federalVatRate,
      discountAmount: resetDiscountAmount ? null : discountAmount,
      priceBeforeVat: resetPriceBeforeVat ? null : priceBeforeVat,
      customVatRate: resetCustomVatRate ? null : customVatRate,
      discountRate: resetDiscountRate ? null : discountRate,
      tipFieldType: resetTipFieldType ? null : tipFieldType,
      tipAmount: resetTipAmount ? null : tipAmount,
      tipRate: resetTipRate ? null : tipRate,
      vatRate: resetVatRate ? null : vatRate,
    );
  }

  @override
  MatexVatCalculatorBlocDocument merge(
    covariant MatexVatCalculatorBlocDocument model,
  ) {
    return copyWith(
      discountFieldType: model.discountFieldType,
      regionalVatRate: model.regionalVatRate,
      federalVatRate: model.federalVatRate,
      discountAmount: model.discountAmount,
      priceBeforeVat: model.priceBeforeVat,
      customVatRate: model.customVatRate,
      discountRate: model.discountRate,
      tipFieldType: model.tipFieldType,
      tipAmount: model.tipAmount,
      tipRate: model.tipRate,
      vatRate: model.vatRate,
    );
  }

  @override
  MatexVatCalculatorBlocFields toFields() {
    return MatexVatCalculatorBlocFields(
      discountFieldType: discountFieldType,
      regionalVatRate: regionalVatRate,
      federalVatRate: federalVatRate,
      discountAmount: discountAmount,
      priceBeforeVat: priceBeforeVat,
      customVatRate: customVatRate,
      discountRate: discountRate,
      tipFieldType: tipFieldType,
      tipAmount: tipAmount,
      tipRate: tipRate,
      vatRate: vatRate,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'discountFieldType': discountFieldType,
      'regionalVatRate': regionalVatRate,
      'federalVatRate': federalVatRate,
      'discountAmount': discountAmount,
      'priceBeforeVat': priceBeforeVat,
      'customVatRate': customVatRate,
      'discountRate': discountRate,
      'tipFieldType': tipFieldType,
      'tipAmount': tipAmount,
      'tipRate': tipRate,
      'vatRate': vatRate,
      ...super.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        discountFieldType,
        regionalVatRate,
        federalVatRate,
        discountAmount,
        priceBeforeVat,
        customVatRate,
        discountRate,
        tipFieldType,
        tipAmount,
        tipRate,
        vatRate,
      ];
}
