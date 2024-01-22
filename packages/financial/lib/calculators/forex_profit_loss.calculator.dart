// Package imports:
import 'package:decimal/decimal.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';
import 'package:tenhance/decimal.dart';

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

  Decimal get multiplier {
    final dCounterToAccountCurrencyRate = toDecimalOrDefault(
      counterToAccountCurrencyRate,
    );

    if (dCounterToAccountCurrencyRate == dZero) {
      return dOne;
    }

    return dCounterToAccountCurrencyRate;
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
  Decimal get costOfGoodsSold {
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
  Decimal get operatingProfit {
    return computeOperatingProfit(grossProfit: grossProfit);
  }

  // Calculates net profit
  Decimal get netProfit {
    return computeNetProfit(
      operatingProfit: operatingProfit.toSafeDouble(),
    );
  }

  Decimal get costOfInvestment {
    return computeCostOfInvestment(
      costOfGoodsSold: costOfGoodsSold.toSafeDouble(),
    );
  }

  // Calculates the return on investment
  Decimal get returnOnInvestment {
    return computeReturnOnInvestment(
      costOfInvestment: costOfInvestment.toSafeDouble(),
      netProfit: netProfit.toSafeDouble(),
    );
  }

  @override
  MatexForexProfitLossCalculatorResults value() {
    if (!isValid) return defaultResults;

    return MatexForexProfitLossCalculatorResults(
      returnOnInvestment: returnOnInvestment.toSafeDouble(),
      netProfit: grossProfit,
    );
  }
}
