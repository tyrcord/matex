import 'package:decimal/decimal.dart';
import 'package:matex_financial/financial.dart';
import 'package:matex_core/core.dart';

class MatexVatCalculator extends MatexCalculator<MatexVatCalculatorState,
    MatexVatCalculatorResults> {
  MatexVatCalculator({
    super.defaultState,
    super.state,
  });

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

  @override
  MatexVatCalculatorResults value() {
    const d = Decimal.parse;
    final price = state.priceBeforeVat ?? 0.0;
    final dFederalVatRate = d((state.federalVatRate ?? 0.0).toString());
    final dRegionalVatRate = d((state.regionalVatRate ?? 0.0).toString());
    final dVatRate = d((state.vatRate ?? 0.0).toString());
    final dCustomVatRate = d((state.customVatRate ?? 0.0).toString());

    final dTotalVatRate =
        dFederalVatRate + dRegionalVatRate + dVatRate + dCustomVatRate;

    final discountedPrice = applyDiscount(
      price,
      discountAmount: state.discountAmount,
      discountRate: state.discountRate,
    );

    final totalTaxes = getVATAmount(discountedPrice, dTotalVatRate.toDouble());
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
        dFederalVatRate.toDouble(),
      ),
      regionalVatAmount: getVATAmount(
        discountedPrice,
        dRegionalVatRate.toDouble(),
      ),
      vatAmount: getVATAmount(
        discountedPrice,
        dVatRate.toDouble(),
      ),
      customVatAmount: getVATAmount(
        discountedPrice,
        dCustomVatRate.toDouble(),
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
