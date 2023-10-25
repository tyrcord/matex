// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_forms/fastyle_forms.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

final String _kDefaulTipFieldType = FastAmountSwitchFieldType.percent.name;
final String _kDefaulDiscountFieldType = FastAmountSwitchFieldType.amount.name;

class MatexVatCalculatorBlocDocument extends FastCalculatorDocument {
  late final String? regionalVatRate;
  late final String? federalVatRate;
  late final String? discountAmount;
  late final String? priceBeforeVat;
  late final String? customVatRate;
  late final String? tipRate;
  late final String? vatRate;
  late final String? discountRate;
  late final String? tipAmount;
  late final String? tipFieldType;
  late final String? discountFieldType;

  static MatexVatCalculatorBlocDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexVatCalculatorBlocDocument(
      regionalVatRate: json['regionalVatRate'] as String?,
      federalVatRate: json['federalVatRate'] as String?,
      discountAmount: json['discountAmount'] as String?,
      priceBeforeVat: json['priceBeforeVat'] as String?,
      customVatRate: json['customVatRate'] as String?,
      tipRate: json['tipRate'] as String?,
      vatRate: json['vatRate'] as String?,
      discountRate: json['discountRate'] as String?,
      tipAmount: json['tipAmount'] as String?,
      tipFieldType: json['tipFieldType'] as String?,
      discountFieldType: json['discountFieldType'] as String?,
    );
  }

  MatexVatCalculatorBlocDocument({
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
    this.regionalVatRate = assignValue(regionalVatRate);
    this.federalVatRate = assignValue(federalVatRate);
    this.discountAmount = assignValue(discountAmount);
    this.priceBeforeVat = assignValue(priceBeforeVat);
    this.customVatRate = assignValue(customVatRate);
    this.tipRate = assignValue(tipRate);
    this.vatRate = assignValue(vatRate);
    this.discountRate = assignValue(discountRate);
    this.tipAmount = assignValue(tipAmount);
    this.tipFieldType = assignValue(tipFieldType) ?? _kDefaulTipFieldType;
    this.discountFieldType =
        assignValue(discountFieldType) ?? _kDefaulDiscountFieldType;
  }

  @override
  MatexVatCalculatorBlocDocument clone() => copyWith();

  @override
  MatexVatCalculatorBlocDocument copyWith({
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
    return MatexVatCalculatorBlocDocument(
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
  MatexVatCalculatorBlocDocument merge(
    covariant MatexVatCalculatorBlocDocument model,
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
  MatexVatCalculatorBlocFields toFields() {
    return MatexVatCalculatorBlocFields(
      regionalVatRate: regionalVatRate,
      federalVatRate: federalVatRate,
      discountAmount: discountAmount,
      priceBeforeVat: priceBeforeVat,
      customVatRate: customVatRate,
      vatRate: vatRate,
      tipRate: tipRate,
      discountRate: discountRate,
      tipAmount: tipAmount,
      tipFieldType: tipFieldType,
      discountFieldType: discountFieldType,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'regionalVatRate': regionalVatRate,
      'federalVatRate': federalVatRate,
      'discountAmount': discountAmount,
      'priceBeforeVat': priceBeforeVat,
      'customVatRate': customVatRate,
      'tipRate': tipRate,
      'vatRate': vatRate,
      'discountRate': discountRate,
      'tipAmount': tipAmount,
      'tipFieldType': tipFieldType,
      'discountFieldType': discountFieldType,
      ...super.toJson(),
    };
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
