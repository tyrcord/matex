// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexStopLossTakeProfitCalculator extends MatexCalculator<
    MatexForexStopLossTakeProfitCalculatorState,
    MatexForexStopLossTakeProfitCalculatorResults> {
  MatexForexStopLossTakeProfitCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: forexStopLossTakeProfitValidators);

  @override
  MatexForexStopLossTakeProfitCalculatorState initializeState() =>
      const MatexForexStopLossTakeProfitCalculatorState();

  @override
  MatexForexStopLossTakeProfitCalculatorState initializeDefaultState() =>
      initializeState();

  bool? get isAccountCurrencyCounter => state.isAccountCurrencyCounter;
  double? get instrumentPairRate => state.instrumentPairRate;
  int? get pipDecimalPlaces => state.pipDecimalPlaces;
  double? get positionSize => state.positionSize;
  double? get stopLossAmount => state.stopLossAmount;
  double? get stopLossPips => state.stopLossPips;
  double? get stopLossPrice => state.stopLossPrice;
  double? get takeProfitAmount => state.takeProfitAmount;
  double? get takeProfitPips => state.takeProfitPips;
  double? get takeProfitPrice => state.takeProfitPrice;
  double? get entryPrice => state.entryPrice;
  MatexPosition get position => state.position;

  double? get counterToAccountCurrencyRate {
    return state.counterToAccountCurrencyRate;
  }

  set positionSize(double? value) {
    setState(state.copyWith(positionSize: value));
  }

  set pipDecimalPlaces(int? value) {
    setState(state.copyWith(pipDecimalPlaces: value));
  }

  set isAccountCurrencyCounter(bool? value) {
    setState(state.copyWith(isAccountCurrencyCounter: value));
  }

  set counterToAccountCurrencyRate(double? value) {
    setState(state.copyWith(counterToAccountCurrencyRate: value));
  }

  set instrumentPairRate(double? value) {
    setState(state.copyWith(instrumentPairRate: value));
  }

  set entryPrice(double? value) {
    setState(state.copyWith(entryPrice: value));
  }

  set stopLossPrice(double? value) {
    setState(state.copyWith(stopLossPrice: value));
  }

  set stopLossPips(double? value) {
    setState(state.copyWith(stopLossPips: value));
  }

  set stopLossAmount(double? value) {
    setState(state.copyWith(stopLossAmount: value));
  }

  set takeProfitPrice(double? value) {
    setState(state.copyWith(takeProfitPrice: value));
  }

  set takeProfitPips(double? value) {
    setState(state.copyWith(takeProfitPips: value));
  }

  set takeProfitAmount(double? value) {
    setState(state.copyWith(takeProfitAmount: value));
  }

  set position(MatexPosition value) {
    setState(state.copyWith(position: value));
  }

  static const defaultResults = MatexForexStopLossTakeProfitCalculatorResults(
    pipValue: 0,
  );

  @override
  MatexForexStopLossTakeProfitCalculatorResults value() {
    if (!isValid) return defaultResults;

    final dPipValue = computePipValue(
      counterToAccountCurrencyRate: state.counterToAccountCurrencyRate,
      isAccountCurrencyCounter: state.isAccountCurrencyCounter,
      instrumentPairRate: state.instrumentPairRate,
      pipDecimalPlaces: state.pipDecimalPlaces,
      positionSize: state.positionSize,
    );

    final tmpState = state.clone();

    final stopLossCalculator = MatexForexStopLossCalculator(state: tmpState);
    final takeProfitCalculator =
        MatexForexTakeProfitCalculator(state: tmpState);

    final takeProfitResult = takeProfitCalculator.value(pipValue: dPipValue);
    final stopLossResult = stopLossCalculator.value(pipValue: dPipValue);

    return MatexForexStopLossTakeProfitCalculatorResults(
      pipValue: dPipValue.toDouble(),
      stopLossPrice: stopLossResult.price,
      stopLossPips: stopLossResult.pips,
      stopLossAmount: stopLossResult.amount,
      takeProfitPrice: takeProfitResult.price,
      takeProfitPips: takeProfitResult.pips,
      takeProfitAmount: takeProfitResult.amount,
      riskRewardRatio: computeRiskRewardRatio(
        riskAmount: stopLossResult.amount,
        rewardAmount: takeProfitResult.amount,
      ),
    );
  }
}
