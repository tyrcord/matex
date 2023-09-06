import 'package:matex_financial/financial.dart';
import 'package:matex_core/core.dart';

List<MatexCalculatorValidator<MatexVatCalculatorState>> vatValidators = [
  // Price before vat must be greater than 0
  (state) => state.priceBeforeVat != null && state.priceBeforeVat! > 0,

  // Vat rate must be greater than 0 and less than 100
  (state) {
    if (state.vatRate != null && state.vatRate! > 0 && state.vatRate! < 1) {
      return true;
    } else if (state.federalVatRate != null &&
        state.federalVatRate! > 0 &&
        state.federalVatRate! < 1) {
      return true;
    } else if (state.regionalVatRate != null &&
        state.regionalVatRate! > 0 &&
        state.regionalVatRate! < 1) {
      return true;
    }

    return false;
  },

  // Discount amount must be greater than 0 and less than price before vat
  (state) {
    if (state.discountAmount != null &&
        (state.discountAmount! >= state.priceBeforeVat! ||
            state.discountAmount! < 0)) {
      return false;
    }

    return true;
  },

  // Discount rate must be greater than 0 and less than 100
  (state) {
    if (state.discountRate != null &&
        (state.discountRate! >= 1 || state.discountRate! < 0)) {
      return false;
    }

    return true;
  },
];
