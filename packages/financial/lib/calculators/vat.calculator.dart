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
    setState(state.copyWith(discountAmount: value));
  }

  set discountPercentage(double? value) {
    setState(state.copyWith(discountPercentage: value));
  }

  set tipRate(double? value) {
    setState(state.copyWith(tipRate: value));
  }

  set customVatRate(double? value) {
    setState(state.copyWith(customVatRate: value));
  }

  //TODO: add tip amount

  @override
  MatexVatCalculatorResults value() {
    //TODO: add tip amount
    const d = Decimal.parse;
    final price = d((state.priceBeforeVat ?? 0.0).toString());
    final federalVatRate = d((state.federalVatRate ?? 0.0).toString());
    final regionalVatRate = d((state.regionalVatRate ?? 0.0).toString());
    final vatRate = d((state.vatRate ?? 0.0).toString());
    final customVatRate = d((state.customVatRate ?? 0.0).toString());
    final discountAmount = d((state.discountAmount ?? 0.0).toString());
    final discountPercentage = d((state.discountPercentage ?? 0.0).toString());
    final tipPercentage = d((state.tipRate ?? 0.0).toString());
    final discountedPrice = applyDiscount(price.toDouble(),
        discountAmount.toDouble(), discountPercentage.toDouble());
    final totalVatRate =
        federalVatRate + regionalVatRate + vatRate + customVatRate;
    final vatAmount = getVATAmount(discountedPrice, totalVatRate.toDouble());
    final totalPrice = discountedPrice + vatAmount;
    final tipAmount = getTipAmount(discountedPrice, tipPercentage.toDouble());
    final grandTotal = totalPrice + tipAmount;

    // TODO: remove zero values

    return MatexVatCalculatorResults(
      totalTaxes: vatAmount.toDouble(),
      total: totalPrice.toDouble(),
      tipAmount: tipAmount.toDouble(),
      grandTotal: grandTotal.toDouble(),
      subTotal: discountedPrice.toDouble(),
      federalVatAmount: getVATAmount(
        discountedPrice,
        federalVatRate.toDouble(),
      ),
      regionalVatAmount: getVATAmount(
        discountedPrice,
        regionalVatRate.toDouble(),
      ),
      vatAmount: getVATAmount(
        discountedPrice,
        vatRate.toDouble(),
      ),
      customVatAmount: getVATAmount(
        discountedPrice,
        customVatRate.toDouble(),
      ),
    );
  }
}
