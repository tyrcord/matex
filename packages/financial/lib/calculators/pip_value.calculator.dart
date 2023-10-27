// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

class MatexPipValueCalculator extends MatexCalculator<
    MatexPipValueCalculatorState, MatexPipValueCalculatorResults> {
  MatexPipValueCalculator({
    super.defaultState,
    super.state,
  }) : super(
        //FIXME: validators: pipValueValidators,
        );

  @override
  MatexPipValueCalculatorState initializeState() =>
      const MatexPipValueCalculatorState();

  @override
  MatexPipValueCalculatorState initializeDefaultState() => initializeState();

  // FIXME:
  static const defaultResults = MatexPipValueCalculatorResults();

  @override
  MatexPipValueCalculatorResults value() {
    if (!isValid) return defaultResults;

    return const MatexPipValueCalculatorResults();
  }
}
