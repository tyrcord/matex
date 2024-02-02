// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexVatCalculator extends MatexCalculator<MatexVatCalculatorState,
    MatexVatCalculatorResults> {
  MatexVatCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: vatValidators);

  @override
  MatexVatCalculatorState initializeState() => const MatexVatCalculatorState();

  @override
  MatexVatCalculatorState initializeDefaultState() => initializeState();

  set priceBeforeVat(double? value) {
    setState(
      state
          .copyWithDefaults(resetPriceAfterVat: true)
          .copyWith(priceBeforeVat: value),
    );
  }

  set priceAfterVat(double? value) {
    setState(state
        .copyWithDefaults(resetPriceBeforeVat: true)
        .copyWith(priceAfterVat: value));
  }

  set federalVatRate(double? value) {
    setState(state.copyWith(federalVatRate: value));
  }

  set regionalVatRate(double? value) {
    setState(state.copyWith(regionalVatRate: value));
  }

  set vatRate(double? value) {
    setState(state.copyWith(vatRate: value));
  }

  set discountAmount(double? value) {
    setState(state.copyWith(discountAmount: value, discountRate: 0));
  }

  set discountRate(double? value) {
    setState(state.copyWith(discountRate: value, discountAmount: 0));
  }

  set tipRate(double? value) {
    setState(state.copyWith(tipRate: value, tipAmount: 0));
  }

  set tipAmount(double? value) {
    setState(state.copyWith(tipAmount: value, tipRate: 0));
  }

  set customVatRate(double? value) {
    setState(state.copyWith(customVatRate: value));
  }

  static const defaultResults = MatexVatCalculatorResults(
    priceBeforeVat: 0,
    total: 0,
  );

  @override
  MatexVatCalculatorResults value() {
    if (!isValid) return defaultResults;

    final regionalVatRate = state.regionalVatRate ?? 0;
    final federalVatRate = state.federalVatRate ?? 0;
    final customVatRate = state.customVatRate ?? 0;
    final vatRate = state.vatRate ?? 0;

    final totalVatRate =
        federalVatRate + regionalVatRate + vatRate + customVatRate;

    double priceBeforeVat = state.priceBeforeVat ?? 0.0;
    double discountedPrice = 0.0;
    double totalTaxes = 0.0;
    double totalPrice = 0.0;

    // Calculate price before VAT if price after VAT is provided
    if (state.priceAfterVat != null && state.priceAfterVat! > 0) {
      totalPrice = state.priceAfterVat!;
      totalTaxes = totalPrice * totalVatRate / (1 + totalVatRate);
      discountedPrice = totalPrice - totalTaxes;
      priceBeforeVat = applyReverseDiscount(
        discountedPrice,
        discountAmount: state.discountAmount,
        discountRate: state.discountRate,
      );
    } else {
      // Calculate price with VAT
      discountedPrice = applyDiscount(
        priceBeforeVat,
        discountAmount: state.discountAmount,
        discountRate: state.discountRate,
      );
      totalTaxes = getVATAmount(discountedPrice, totalVatRate);
      totalPrice = discountedPrice + totalTaxes;
    }

    final (discountAmount, discountRate) = getDiscountAmountAndRate(
      priceBeforeVat,
      discountedPrice,
    );

    final (tipAmount, tipRate) = getTipAmountAndRate(
      discountedPrice,
      tipAmount: state.tipAmount,
      tipRate: state.tipRate,
    );

    return MatexVatCalculatorResults(
      regionalVatAmount: getVATAmount(discountedPrice, regionalVatRate),
      federalVatAmount: getVATAmount(discountedPrice, federalVatRate),
      customVatAmount: getVATAmount(discountedPrice, customVatRate),
      grandTotal: tipAmount > 0 ? totalPrice + tipAmount : 0,
      subTotal: discountAmount > 0 ? discountedPrice : 0,
      vatAmount: getVATAmount(discountedPrice, vatRate),
      discountAmount: discountAmount,
      priceBeforeVat: priceBeforeVat,
      discountRate: discountRate,
      totalTaxes: totalTaxes,
      tipAmount: tipAmount,
      total: totalPrice,
      tipRate: tipRate,
    );
  }

  double applyReverseDiscount(
    double price, {
    double? discountAmount,
    double? discountRate,
  }) {
    if (discountAmount != null && discountAmount > 0) {
      return price + discountAmount;
    } else if (discountRate != null && discountRate > 0) {
      return price / (1 - discountRate);
    }

    return price;
  }

  (double tipAmount, double tipRate) getTipAmountAndRate(
    double price, {
    double? tipAmount,
    double? tipRate,
  }) {
    tipAmount ??= 0.0;
    tipRate ??= 0.0;

    if (tipAmount > 0) {
      return (tipAmount, getTipRate(price, tipAmount));
    }

    return (getTipAmount(price, tipRate), tipRate);
  }

  (double discountAmount, double discountRate) getDiscountAmountAndRate(
    double price,
    double dicountedPrice,
  ) {
    final discountAmount = price - dicountedPrice;
    final discountRate = price > 0 ? (discountAmount / price) : 0.0;

    return (discountAmount, discountRate);
  }
}
