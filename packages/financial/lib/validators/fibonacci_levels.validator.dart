// Package imports

// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

// Project imports

List<MatexCalculatorValidator<MatexFibonacciLevelsCalculatorState>>
    fibonacciLevelsValidators = [
  (state) => state.lowPrice != null && state.highPrice != null,
  (state) {
    final lowPrice = state.lowPrice!;
    final highPrice = state.highPrice;
    var isValid = lowPrice > 0 && highPrice! > 0;

    if (isValid) isValid = highPrice > lowPrice;

    return isValid;
  },
];
