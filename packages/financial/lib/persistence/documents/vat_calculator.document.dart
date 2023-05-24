import 'package:decimal/decimal.dart';
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexVatCalculatorBlocDocument extends FastCalculatorDocument {
  final String? regionalVatRate;
  final String? federalVatRate;
  final String? discountAmount;
  final String? priceBeforeVat;
  final String? customVatRate;
  final String? tipRate;
  final String? vatRate;
  final String? discountRate;
  final String? tipAmount;
  final String? tipFieldType;
  final String? discountFieldType;

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

  const MatexVatCalculatorBlocDocument({
    this.regionalVatRate,
    this.federalVatRate,
    this.discountAmount,
    this.priceBeforeVat,
    this.customVatRate,
    this.tipRate,
    this.vatRate,
    this.discountRate,
    this.tipAmount,
    this.tipFieldType,
    this.discountFieldType,
  });

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
    var vatPercentage = vatRate;

    if (vatPercentage is String) {
      final dVatRate = Decimal.tryParse(vatPercentage);

      if (dVatRate != null) {
        vatPercentage = (dVatRate / Decimal.fromInt(100)).toString();
      }
    }

    return MatexVatCalculatorBlocFields(
      regionalVatRate: regionalVatRate,
      federalVatRate: federalVatRate,
      discountAmount: discountAmount,
      priceBeforeVat: priceBeforeVat,
      customVatRate: customVatRate,
      vatRate: vatPercentage,
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
