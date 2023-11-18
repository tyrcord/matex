// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

final List<MatexCalculatorValidator<MatexForexPipValueCalculatorState>>
    pipValueValidators = [
  (state) => state.positionSize != null,
  (state) => state.positionSize! > 0 && state.instrumentPairRate > 0,
];
