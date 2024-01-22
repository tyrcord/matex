// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexProfitLossCalculator extends MatexCalculator<
    MatexForexProfitLossCalculatorState,
    MatexForexProfitLossCalculatorResults> {
  MatexForexProfitLossCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: forexProfitAndLossValidators);

  @override
  MatexForexProfitLossCalculatorState initializeState() =>
      const MatexForexProfitLossCalculatorState();

  @override
  MatexForexProfitLossCalculatorState initializeDefaultState() =>
      initializeState();

  bool? get isAccountCurrencyCounter => state.isAccountCurrencyCounter;
  double? get instrumentPairRate => state.instrumentPairRate;
  int? get pipDecimalPlaces => state.pipDecimalPlaces;
  double? get positionSize => state.positionSize;
  double? get entryPrice => state.entryPrice;
  double? get exitPrice => state.exitPrice;
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

  set exitPrice(double? value) {
    setState(state.copyWith(exitPrice: value));
  }

  set position(MatexPosition value) {
    setState(state.copyWith(position: value));
  }

  static const defaultResults = MatexForexProfitLossCalculatorResults(
    returnOnInvestment: 0,
    netProfit: 0,
  );

  double get multiplier {
    final rate = counterToAccountCurrencyRate ?? 0;

    if (rate == 0) return 1;

    return rate;
  }

  double get pipValue {
    return computePipValue(
      counterToAccountCurrencyRate: state.counterToAccountCurrencyRate,
      isAccountCurrencyCounter: state.isAccountCurrencyCounter,
      instrumentPairRate: state.instrumentPairRate,
      pipDecimalPlaces: state.pipDecimalPlaces,
      positionSize: state.positionSize,
    );
  }

  double get pipDelta {
    return computePipDelta(
      pipDecimalPlaces: state.pipDecimalPlaces,
      entryPrice: state.entryPrice,
      exitPrice: state.exitPrice,
    );
  }

  // Calculates the cost of goods sold
  double get costOfGoodsSold {
    final costOfGoodsSold = computeCostOfGoodsSold(
      expectedSaleUnits: state.positionSize,
      buyingPrice: state.entryPrice,
    );

    return costOfGoodsSold * multiplier;
  }

  // Calculates gross profit
  double get grossProfit {
    if (state.position == MatexPosition.short) return -pipDelta * pipValue;

    return pipDelta * pipValue;
  }

  // Calculates operating profit
  double get operatingProfit {
    return computeOperatingProfit(grossProfit: grossProfit);
  }

  // Calculates net profit
  double get netProfit {
    return computeNetProfit(operatingProfit: operatingProfit);
  }

  double get costOfInvestment {
    return computeCostOfInvestment(costOfGoodsSold: costOfGoodsSold);
  }

  // Calculates the return on investment
  double get returnOnInvestment {
    return computeReturnOnInvestment(
      costOfInvestment: costOfInvestment,
      netProfit: netProfit,
    );
  }

  @override
  MatexForexProfitLossCalculatorResults value() {
    if (!isValid) return defaultResults;

    return MatexForexProfitLossCalculatorResults(
      returnOnInvestment: returnOnInvestment,
      netProfit: grossProfit,
    );
  }
}
