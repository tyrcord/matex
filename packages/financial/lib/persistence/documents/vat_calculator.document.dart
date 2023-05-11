import 'package:decimal/decimal.dart';
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexVatCalculatorBlocDocument extends FastCalculatorDocument {
  final String? discountPercentage;
  final String? regionalVatRate;
  final String? federalVatRate;
  final String? discountAmount;
  final String? priceBeforeVat;
  final String? customVatRate;
  final String? tipRate;
  final String? vatRate;

  static MatexVatCalculatorBlocDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexVatCalculatorBlocDocument(
      discountPercentage: json['discountPercentage'] as String?,
      regionalVatRate: json['regionalVatRate'] as String?,
      federalVatRate: json['federalVatRate'] as String?,
      discountAmount: json['discountAmount'] as String?,
      priceBeforeVat: json['priceBeforeVat'] as String?,
      customVatRate: json['customVatRate'] as String?,
      tipRate: json['tipRate'] as String?,
      vatRate: json['vatRate'] as String?,
    );
  }

  const MatexVatCalculatorBlocDocument({
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
  MatexVatCalculatorBlocDocument clone() {
    return MatexVatCalculatorBlocDocument(
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
  MatexVatCalculatorBlocDocument copyWith({
    String? discountPercentage,
    String? regionalVatRate,
    String? federalVatRate,
    String? discountAmount,
    String? priceBeforeVat,
    String? customVatRate,
    String? tipRate,
    String? vatRate,
  }) {
    return MatexVatCalculatorBlocDocument(
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
  MatexVatCalculatorBlocDocument merge(
    covariant MatexVatCalculatorBlocDocument model,
  ) {
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
  MatexVatCalculatorBlocFields toFields() {
    var vatPercentage = vatRate;

    if (vatPercentage is String) {
      final dVatRate = Decimal.tryParse(vatPercentage);

      if (dVatRate != null) {
        vatPercentage = (dVatRate / Decimal.fromInt(100)).toString();
      }
    }

    return MatexVatCalculatorBlocFields(
      discountPercentage: discountPercentage,
      regionalVatRate: regionalVatRate,
      federalVatRate: federalVatRate,
      discountAmount: discountAmount,
      priceBeforeVat: priceBeforeVat,
      customVatRate: customVatRate,
      vatRate: vatPercentage,
      tipRate: tipRate,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'discountPercentage': discountPercentage,
      'regionalVatRate': regionalVatRate,
      'federalVatRate': federalVatRate,
      'discountAmount': discountAmount,
      'priceBeforeVat': priceBeforeVat,
      'customVatRate': customVatRate,
      'tipRate': tipRate,
      'vatRate': vatRate,
    };
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
