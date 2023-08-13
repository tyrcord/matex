import 'package:flutter_test/flutter_test.dart';
import 'package:matex_financial/financial.dart';

void main() {
  group('MatexStockPositionSizeCalculator', () {
    late MatexStockPositionSizeCalculator calculator;

    setUp(() {
      calculator = MatexStockPositionSizeCalculator();
    });

    test('Default state should be initialized correctly', () {
      final defaultState = calculator.getState();

      expect(defaultState.accountSize, isNull);
      expect(defaultState.entryPrice, isNull);
      expect(defaultState.stopLossPrice, isNull);
      expect(defaultState.stopLossAmount, isNull);
      expect(defaultState.slippagePercent, isNull);
      expect(defaultState.riskPercent, isNull);
      expect(defaultState.rewardRisk, isNull);
      expect(defaultState.entryFees, isNull);
      expect(defaultState.exitFees, isNull);
    });

    test('Setting state properties should update the state', () {
      calculator.accountSize = 10000.0;
      calculator.entryPrice = 50.0;
      calculator.stopLossPrice = 45.0;
      calculator.stopLossAmount = 500.0;
      calculator.slippagePercent = 0.01;
      calculator.riskPercent = 0.02;
      calculator.rewardRisk = 3.0;
      calculator.entryFees = 0.001;
      calculator.exitFees = 0.002;

      final state = calculator.getState();

      expect(state.accountSize, 10000.0);
      expect(state.entryPrice, 50.0);
      expect(state.stopLossPrice, 45.0);
      expect(state.stopLossAmount, 0.0);
      expect(state.slippagePercent, 0.01);
      expect(state.riskPercent, 0.02);
      expect(state.rewardRisk, 3.0);
      expect(state.entryFees, 0.001);
      expect(state.exitFees, 0.002);
    });

    test('Calculates correct results with mandatory properties', () {
      calculator.accountSize = 10000;
      calculator.entryPrice = 100;
      calculator.stopLossPrice = 95;
      calculator.riskPercent = 0.01;

      final result = calculator.value();

      expect(result.shares, 20);
      expect(result.positionAmount, closeTo(2000, 1e-3));
      expect(result.effectiveRisk, closeTo(100, 1e-3));
      expect(result.toleratedRisk, closeTo(100, 1e-3));
      expect(result.involvedCapital, closeTo(0.2, 1e-3));
      expect(result.entryPriceWithSlippage, closeTo(100, 0.01));
      expect(result.stopLossPriceWithSlippage, closeTo(95, 0.01));
      expect(result.stopLossPercentWithSlippage, closeTo(0.05, 0.001));
      expect(result.stopLossPercent, closeTo(0.05, 0.01));
    });

    test('Calculates correct results when entryFees is set', () {
      calculator.accountSize = 10000;
      calculator.entryPrice = 100;
      calculator.stopLossPrice = 95;
      calculator.riskPercent = 0.01;
      calculator.entryFees = 0.01;

      final result = calculator.value();

      expect(result.shares, 16);
      expect(result.positionAmount, closeTo(1600, 1e-3));
      expect(result.effectiveRisk, closeTo(96, 1e-3));
      expect(result.toleratedRisk, closeTo(100, 1e-3));
      expect(result.involvedCapital, closeTo(0.16, 1e-3));
    });

    test('Calculates correct results when exitFees is set', () {
      calculator.accountSize = 10000;
      calculator.entryPrice = 100;
      calculator.stopLossPrice = 95;
      calculator.riskPercent = 0.01;
      calculator.exitFees = 0.01;

      final result = calculator.value();

      expect(result.shares, 16);
      expect(result.positionAmount, closeTo(1600, 1e-3));
      expect(result.effectiveRisk, closeTo(95.2, 1e-3));
      expect(result.toleratedRisk, closeTo(100, 1e-3));
      expect(result.involvedCapital, closeTo(0.16, 1e-3));
    });

    test('Calculates correct results when entryFees and exitFees are set', () {
      calculator.accountSize = 10000;
      calculator.entryPrice = 100;
      calculator.stopLossPrice = 95;
      calculator.riskPercent = 0.01;
      calculator.exitFees = 0.01;
      calculator.entryFees = 0.01;

      final result = calculator.value();

      expect(result.shares, 14);
      expect(result.positionAmount, closeTo(1400, 1e-3));
      expect(result.effectiveRisk, closeTo(97.30, 1e-3));
      expect(result.toleratedRisk, closeTo(100, 1e-3));
      expect(result.involvedCapital, closeTo(0.14, 1e-3));
    });

    test('Calculates correct results when slippage is set', () {
      calculator.accountSize = 10000;
      calculator.entryPrice = 100;
      calculator.stopLossPrice = 95;
      calculator.riskPercent = 0.01;
      calculator.slippagePercent = 0.01;

      final result = calculator.value();

      expect(result.shares, 14);
      expect(result.positionAmount, closeTo(1414, 1e-3));
      expect(result.effectiveRisk, closeTo(97.30, 1e-3));
      expect(result.toleratedRisk, closeTo(100, 1e-3));
      expect(result.involvedCapital, closeTo(0.1414, 1e-3));
      expect(result.entryPriceWithSlippage, closeTo(101, 1e-3));
      expect(result.stopLossPriceWithSlippage, closeTo(94.05, 1e-3));
      expect(result.stopLossPercentWithSlippage, closeTo(0.0688, 1e-3));
      expect(result.stopLossPercent, closeTo(0.05, 1e-3));
    });

    test('Calculates correct results when slippage and fess are set', () {
      calculator.accountSize = 10000;
      calculator.entryPrice = 100;
      calculator.stopLossPrice = 95;
      calculator.riskPercent = 0.01;
      calculator.slippagePercent = 0.01;
      calculator.entryFees = 0.01;
      calculator.exitFees = 0.01;

      final result = calculator.value();

      expect(result.shares, 11);
      expect(result.positionAmount, closeTo(1111, 1e-3));
      expect(result.effectiveRisk, closeTo(97.91, 0.01));
      expect(result.toleratedRisk, closeTo(100, 0.01));
      expect(result.involvedCapital, closeTo(0.1111, 0.01));
      expect(result.entryPriceWithSlippage, closeTo(101, 0.01));
      expect(result.stopLossPriceWithSlippage, closeTo(94.05, 0.01));
      expect(result.stopLossPercentWithSlippage, closeTo(0.0688, 0.001));
      expect(result.stopLossPercent, closeTo(0.05, 0.01));
    });

    test('Calculates correct results when reward/risk is set', () {
      calculator.accountSize = 10000;
      calculator.entryPrice = 100;
      calculator.stopLossPrice = 95;
      calculator.riskPercent = 0.01;
      calculator.slippagePercent = 0.01;
      calculator.rewardRisk = 2;

      final result = calculator.value();

      expect(result.shares, 14);
      expect(result.positionAmount, closeTo(1414, 1e-3));
      expect(result.effectiveRisk, closeTo(97.30, 1e-3));
      expect(result.toleratedRisk, closeTo(100, 1e-3));
      expect(result.involvedCapital, closeTo(0.1414, 1e-3));
      expect(result.takeProfitAmount, closeTo(194.6, 1e-3));
      expect(result.takeProfitPrice, closeTo(114.90, 1e-3));
    });

    test('should calculate riskPercent from stopLossAmount and accountSize',
        () {
      final calculator = MatexStockPositionSizeCalculator();

      calculator.accountSize = 10000;
      calculator.entryPrice = 100;
      calculator.stopLossPrice = 95;
      calculator.stopLossAmount = 200;

      final result = calculator.value();

      expect(result.shares, 40);
      expect(result.positionAmount, closeTo(4000, 1e-3));
      expect(result.effectiveRisk, closeTo(200.00, 1e-3));
      expect(result.toleratedRisk, closeTo(200, 1e-3));
      expect(result.involvedCapital, closeTo(0.4, 1e-3));
    });

    test('Calculating position size should return correct results', () {
      calculator.accountSize = 10000.0;
      calculator.entryPrice = 50.0;
      calculator.stopLossPrice = 45.0;
      calculator.slippagePercent = 0.01;
      calculator.riskPercent = 0.02;
      calculator.rewardRisk = 3.0;
      calculator.entryFees = 0.01;
      calculator.exitFees = 0.01;

      final results = calculator.value();

      expect(results.shares, 28.0);
      expect(results.positionAmount, 1414.0);
      expect(results.toleratedRisk, 200.0);
      expect(results.involvedCapital, 0.1414);
      expect(results.effectiveRisk, closeTo(193.21, 0.01));
      expect(results.stopLossPercentWithSlippage, closeTo(0.1178, 0.0001));
      expect(results.takeProfitAmount, closeTo(579.64, 0.01));
      expect(results.takeProfitPrice, closeTo(71.20, 0.01));
      expect(results.takeProfitAmountWithSlippage, closeTo(559.71, 0.01));
      expect(results.takeProfitPriceWithSlippage, closeTo(70.49, 0.01));
    });
  });
}
