// Package imports:
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';
import 'package:tenhance/decimal.dart';

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
    setState(state.copyWith(priceBeforeVat: value));
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

  static const defaultResults = MatexVatCalculatorResults(total: 0);

  @override
  MatexVatCalculatorResults value() {
    if (!isValid) return defaultResults;

    final price = state.priceBeforeVat ?? 0.0;
    final dFederalVatRate = toDecimal(state.federalVatRate) ?? dZero;
    final dRegionalVatRate = toDecimal(state.regionalVatRate) ?? dZero;
    final dVatRate = toDecimal(state.vatRate) ?? dZero;
    final dCustomVatRate = toDecimal(state.customVatRate) ?? dZero;

    final dTotalVatRate =
        dFederalVatRate + dRegionalVatRate + dVatRate + dCustomVatRate;

    final discountedPrice = applyDiscount(
      price,
      discountAmount: state.discountAmount,
      discountRate: state.discountRate,
    );

    final totalTaxes =
        getVATAmount(discountedPrice, dTotalVatRate.toSafeDouble());
    final totalPrice = discountedPrice + totalTaxes;

    final (discountAmount, discountRate) = getDiscountAmountAndRate(
      price,
      discountedPrice,
    );

    final (tipAmount, tipRate) = getTipAmountAndRate(
      discountedPrice,
      tipAmount: state.tipAmount,
      tipRate: state.tipRate,
    );

    return MatexVatCalculatorResults(
      tipAmount: tipAmount,
      tipRate: tipRate,
      discountAmount: discountAmount,
      discountRate: discountRate,
      totalTaxes: totalTaxes,
      subTotal: discountAmount > 0 ? discountedPrice : 0,
      total: totalPrice,
      grandTotal: tipAmount > 0 ? totalPrice + tipAmount : 0,
      federalVatAmount: getVATAmount(
        discountedPrice,
        dFederalVatRate.toSafeDouble(),
      ),
      regionalVatAmount: getVATAmount(
        discountedPrice,
        dRegionalVatRate.toSafeDouble(),
      ),
      vatAmount: getVATAmount(
        discountedPrice,
        dVatRate.toSafeDouble(),
      ),
      customVatAmount: getVATAmount(
        discountedPrice,
        dCustomVatRate.toSafeDouble(),
      ),
    );
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
