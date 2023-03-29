import 'package:decimal/decimal.dart';
import 'package:matex_financial/financial.dart';
import 'package:matex_core/core.dart';

class MatexVatCalculator extends MatexCalculator<MatexVatCalculatorState,
    MatexVatCalculatorResults> {
  MatexVatCalculator({required super.defaultState, required super.state});

  set priceBeforeVat(double? value) {
    updateState(state.copyWith(priceBeforeVat: value));
  }

  set federalVatRate(double? value) {
    updateState(state.copyWith(federalVatRate: value));
  }

  set regionalVatRate(double? value) {
    updateState(state.copyWith(regionalVatRate: value));
  }

  set vatRate(double? value) {
    updateState(state.copyWith(vatRate: value));
  }

  set discountAmount(double? value) {
    updateState(state.copyWith(discountAmount: value));
  }

  set discountPercentage(double? value) {
    updateState(state.copyWith(discountPercentage: value));
  }

  set tipRate(double? value) {
    updateState(state.copyWith(tipRate: value));
  }

  @override
  MatexVatCalculatorResults value() {
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
