import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

final List<MatexCalculatorValidator<MatexPipValueCalculatorState>>
    pipValueValidators = [
  (state) => state.positionSize != null,
  (state) => state.positionSize! > 0 && state.instrumentPairRate > 0,
];
