// Package imports

// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

// Project imports

final List<MatexCalculatorValidator<MatexPivotPointsCalculatorState>>
    pivotPointsValidators = [
  (state) {
    final lowPrice = state.lowPrice;
    final highPrice = state.highPrice;
    final closePrice = state.closePrice;

    return lowPrice != null && highPrice != null && closePrice != null;
  },
  (state) {
    final lowPrice = state.lowPrice!;
    final highPrice = state.highPrice!;
    final closePrice = state.closePrice!;
    var isValid = lowPrice > 0 && highPrice > 0 && closePrice > 0;

    if (isValid) {
      isValid = highPrice >= lowPrice &&
          closePrice >= lowPrice &&
          closePrice <= highPrice;
    }

    return isValid;
  },
  (state) {
    final lowPrice = state.lowPrice!;
    final highPrice = state.highPrice!;
    final openPrice = state.openPrice;
    final method = state.method;
    var isValid = true;

    if (method == MatexPivotPointsMethods.deMark) {
      isValid = openPrice != null && openPrice > 0;

      if (isValid) {
        isValid = openPrice >= lowPrice && openPrice <= highPrice;
      }
    }

    return isValid;
  },
];
