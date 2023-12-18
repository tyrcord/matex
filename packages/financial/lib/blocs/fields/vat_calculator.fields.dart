// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';

class MatexVatCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  static const String defaulDiscountFieldType = 'amount';
  static const String defaulTipFieldType = 'percent';

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
    FastCalculatorBlocDelegate? delegate,
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
    this.delegate = delegate;
    this.discountFieldType =
        assignValue(discountFieldType) ?? defaulDiscountFieldType;
  }

  @override
  MatexVatCalculatorBlocFields clone() => copyWith();

  @override
  MatexVatCalculatorBlocFields copyWith({
    FastCalculatorBlocDelegate? delegate,
    String? discountFieldType,
    String? regionalVatRate,
    String? federalVatRate,
    String? discountAmount,
    String? priceBeforeVat,
    String? customVatRate,
    String? tipFieldType,
    String? discountRate,
    String? tipAmount,
    String? tipRate,
    String? vatRate,
  }) {
    return MatexVatCalculatorBlocFields(
      discountFieldType: discountFieldType ?? this.discountFieldType,
      regionalVatRate: regionalVatRate ?? this.regionalVatRate,
      federalVatRate: federalVatRate ?? this.federalVatRate,
      discountAmount: discountAmount ?? this.discountAmount,
      priceBeforeVat: priceBeforeVat ?? this.priceBeforeVat,
      customVatRate: customVatRate ?? this.customVatRate,
      discountRate: discountRate ?? this.discountRate,
      tipFieldType: tipFieldType ?? this.tipFieldType,
      tipAmount: tipAmount ?? this.tipAmount,
      delegate: delegate ?? this.delegate,
      tipRate: tipRate ?? this.tipRate,
      vatRate: vatRate ?? this.vatRate,
    );
  }

  @override
  MatexVatCalculatorBlocFields copyWithDefaults({
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
    return MatexVatCalculatorBlocFields(
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
      delegate: delegate,
    );
  }

  @override
  MatexVatCalculatorBlocFields merge(
    covariant MatexVatCalculatorBlocFields model,
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
      delegate: model.delegate,
      tipRate: model.tipRate,
      vatRate: model.vatRate,
    );
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
