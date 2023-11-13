// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_forms/fastyle_forms.dart';
import 'package:matex_core/core.dart';

final String _kDefaulTipFieldType = FastAmountSwitchFieldType.percent.name;
final String _kDefaulDiscountFieldType = FastAmountSwitchFieldType.amount.name;

class MatexVatCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
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

  String get formattedPriceBeforeVat {
    final priceBeforeVatValue = parseFieldValueToDouble(priceBeforeVat);

    return localizeCurrency(value: priceBeforeVatValue);
  }

  String get formattedRegionalVatRate {
    final regionalVatRateValue = parseFieldValueToDouble(regionalVatRate);

    return '${localizeNumber(value: regionalVatRateValue)}%';
  }

  String get formattedFederalVatRate {
    final federalVatRateValue = parseFieldValueToDouble(federalVatRate);

    return '${localizeNumber(value: federalVatRateValue)}%';
  }

  String get formattedDiscountAmount {
    final discountAmountValue = parseFieldValueToDouble(discountAmount);

    return localizeCurrency(value: discountAmountValue);
  }

  String get formattedCustomVatRate {
    final customVatRateValue = parseFieldValueToDouble(customVatRate);

    return '${localizeNumber(value: customVatRateValue)}%';
  }

  String get formattedTipRate {
    final tipRateValue = parseFieldValueToDouble(tipRate);

    return '${localizeNumber(value: tipRateValue)}%';
  }

  String get formattedVatRate {
    final vatRateValue = parseFieldValueToDouble(vatRate);

    return '${localizeNumber(value: vatRateValue)}%';
  }

  String get formattedDiscountRate {
    final discountRateValue = parseFieldValueToDouble(discountRate);

    return '${localizeNumber(value: discountRateValue)}%';
  }

  String get formattedTipAmount {
    final tipAmountValue = parseFieldValueToDouble(tipAmount);

    return localizeCurrency(value: tipAmountValue);
  }

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
    FastCalculatorBlocDelegate? delegate,
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
    this.tipFieldType = tipFieldType ?? _kDefaulTipFieldType;
    this.discountFieldType = discountFieldType ?? _kDefaulDiscountFieldType;
    this.delegate = delegate;
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
    FastCalculatorBlocDelegate? delegate,
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
      delegate: delegate ?? this.delegate,
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
      delegate: model.delegate,
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
        delegate,
      ];
}
