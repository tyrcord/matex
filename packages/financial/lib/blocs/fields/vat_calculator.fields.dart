// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/logic/enums/enums.dart';

class MatexVatCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  static const String defaulDiscountFieldType = 'amount';
  static const String defaulTipFieldType = 'percent';

  static final defaultVatCalculationStrategy =
      MatexVatCalculationStrategy.excluded.name;

  late final String? vatCalculationStrategy;
  late final String discountFieldType;
  late final String? regionalVatRate;
  late final String? federalVatRate;
  late final String? discountAmount;
  late final String? priceBeforeVat;
  late final String? priceAfterVat;
  late final String? customVatRate;
  late final String? discountRate;
  late final String tipFieldType;
  late final String? tipAmount;
  late final String? tipRate;
  late final String? vatRate;

  String get formattedPriceBeforeVat {
    final priceBeforeVatValue = parseStringToDouble(priceBeforeVat);

    return localizeCurrency(value: priceBeforeVatValue);
  }

  String get formattedRegionalVatRate {
    final regionalVatRateValue = parseStringToDouble(regionalVatRate);

    return '${localizeNumber(value: regionalVatRateValue)}%';
  }

  String get formattedFederalVatRate {
    final federalVatRateValue = parseStringToDouble(federalVatRate);

    return '${localizeNumber(value: federalVatRateValue)}%';
  }

  String get formattedDiscountAmount {
    final discountAmountValue = parseStringToDouble(discountAmount);

    return localizeCurrency(value: discountAmountValue);
  }

  String get formattedCustomVatRate {
    final customVatRateValue = parseStringToDouble(customVatRate);

    return '${localizeNumber(value: customVatRateValue)}%';
  }

  String get formattedTipRate {
    final tipRateValue = parseStringToDouble(tipRate);

    return '${localizeNumber(value: tipRateValue)}%';
  }

  String get formattedVatRate {
    final vatRateValue = parseStringToDouble(vatRate);

    return '${localizeNumber(value: vatRateValue)}%';
  }

  String get formattedDiscountRate {
    final discountRateValue = parseStringToDouble(discountRate);

    return '${localizeNumber(value: discountRateValue)}%';
  }

  String get formattedTipAmount {
    final tipAmountValue = parseStringToDouble(tipAmount);

    return localizeCurrency(value: tipAmountValue);
  }

  String get formattedPriceAfterVat {
    final priceAfterVatValue = parseStringToDouble(priceAfterVat);

    return localizeCurrency(value: priceAfterVatValue);
  }

  MatexVatCalculatorBlocFields({
    FastCalculatorBlocDelegate? delegate,
    String? vatCalculationStrategy,
    String? discountFieldType,
    String? regionalVatRate,
    String? federalVatRate,
    String? discountAmount,
    String? priceBeforeVat,
    String? priceAfterVat,
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
    this.priceAfterVat = assignValue(priceAfterVat);
    this.customVatRate = assignValue(customVatRate);
    this.discountRate = assignValue(discountRate);
    this.tipAmount = assignValue(tipAmount);
    this.tipRate = assignValue(tipRate);
    this.vatRate = assignValue(vatRate);
    this.delegate = delegate;
    this.discountFieldType =
        assignValue(discountFieldType) ?? defaulDiscountFieldType;
    this.vatCalculationStrategy =
        assignValue(vatCalculationStrategy) ?? defaultVatCalculationStrategy;
  }

  @override
  MatexVatCalculatorBlocFields clone() => copyWith();

  @override
  MatexVatCalculatorBlocFields copyWith({
    FastCalculatorBlocDelegate? delegate,
    String? vatCalculationStrategy,
    String? discountFieldType,
    String? regionalVatRate,
    String? federalVatRate,
    String? discountAmount,
    String? priceBeforeVat,
    String? priceAfterVat,
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
      priceAfterVat: priceAfterVat ?? this.priceAfterVat,
      customVatRate: customVatRate ?? this.customVatRate,
      discountRate: discountRate ?? this.discountRate,
      tipFieldType: tipFieldType ?? this.tipFieldType,
      tipAmount: tipAmount ?? this.tipAmount,
      delegate: delegate ?? this.delegate,
      tipRate: tipRate ?? this.tipRate,
      vatRate: vatRate ?? this.vatRate,
      vatCalculationStrategy:
          vatCalculationStrategy ?? this.vatCalculationStrategy,
    );
  }

  @override
  MatexVatCalculatorBlocFields copyWithDefaults({
    bool resetVatCalculationStrategy = false,
    bool resetDiscountFieldType = false,
    bool resetRegionalVatRate = false,
    bool resetFederalVatRate = false,
    bool resetDiscountAmount = false,
    bool resetPriceBeforeVat = false,
    bool resetPriceAfterVat = false,
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
      priceAfterVat: resetPriceAfterVat ? null : priceAfterVat,
      customVatRate: resetCustomVatRate ? null : customVatRate,
      discountRate: resetDiscountRate ? null : discountRate,
      tipFieldType: resetTipFieldType ? null : tipFieldType,
      tipAmount: resetTipAmount ? null : tipAmount,
      tipRate: resetTipRate ? null : tipRate,
      vatRate: resetVatRate ? null : vatRate,
      delegate: delegate,
      vatCalculationStrategy:
          resetVatCalculationStrategy ? null : vatCalculationStrategy,
    );
  }

  @override
  MatexVatCalculatorBlocFields merge(
    covariant MatexVatCalculatorBlocFields model,
  ) {
    return copyWith(
      vatCalculationStrategy: model.vatCalculationStrategy,
      discountFieldType: model.discountFieldType,
      regionalVatRate: model.regionalVatRate,
      federalVatRate: model.federalVatRate,
      discountAmount: model.discountAmount,
      priceBeforeVat: model.priceBeforeVat,
      priceAfterVat: model.priceAfterVat,
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
        vatCalculationStrategy,
        discountFieldType,
        regionalVatRate,
        federalVatRate,
        discountAmount,
        priceBeforeVat,
        priceAfterVat,
        customVatRate,
        discountRate,
        tipFieldType,
        tipAmount,
        tipRate,
        vatRate,
      ];

  @override
  Map<String, dynamic> toJson() {
    return {
      'vatCalculationStrategy': vatCalculationStrategy,
      'discountFieldType': discountFieldType,
      'regionalVatRate': regionalVatRate,
      'federalVatRate': federalVatRate,
      'discountAmount': discountAmount,
      'priceBeforeVat': priceBeforeVat,
      'priceAfterVat': priceAfterVat,
      'customVatRate': customVatRate,
      'discountRate': discountRate,
      'tipFieldType': tipFieldType,
      'tipAmount': tipAmount,
      'tipRate': tipRate,
      'vatRate': vatRate,
    };
  }
}
