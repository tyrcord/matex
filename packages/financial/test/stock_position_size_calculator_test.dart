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
      calculator.slippagePercent = 1.0;
      calculator.riskPercent = 2.0;
      calculator.rewardRisk = 3.0;
      calculator.entryFees = 0.1;
      calculator.exitFees = 0.2;

      final state = calculator.getState();

      expect(state.accountSize, 10000.0);
      expect(state.entryPrice, 50.0);
      expect(state.stopLossPrice, 45.0);
      expect(state.stopLossAmount, 500.0);
      expect(state.slippagePercent, 1.0);
      expect(state.riskPercent, 2.0);
      expect(state.rewardRisk, 3.0);
      expect(state.entryFees, 0.1);
      expect(state.exitFees, 0.2);
    });

    test('Calculates correct results with mandatory properties', () {
      calculator.accountSize = 10000;
      calculator.entryPrice = 100;
      calculator.stopLossPrice = 95;
      calculator.riskPercent = 1;

      final result = calculator.value();

      expect(result.shares, 20);
      expect(result.positionAmount, closeTo(2000, 1e-3));
      expect(result.effectiveRisk, closeTo(100, 1e-3));
      expect(result.toleratedRisk, closeTo(100, 1e-3));
      expect(result.stopLossAmount, closeTo(0.2, 1e-3));
    });

    test('Calculates correct results when entryFees is set', () {
      calculator.accountSize = 10000;
      calculator.entryPrice = 100;
      calculator.stopLossPrice = 95;
      calculator.riskPercent = 1;
      calculator.entryFees = 1;

      final result = calculator.value();

      expect(result.shares, 16);
      expect(result.positionAmount, closeTo(1600, 1e-3));
      expect(result.effectiveRisk, closeTo(96, 1e-3));
      expect(result.toleratedRisk, closeTo(100, 1e-3));
      expect(result.stopLossAmount, closeTo(0.16, 1e-3));
    });

    test('Calculates correct results when exitFees is set', () {
      calculator.accountSize = 10000;
      calculator.entryPrice = 100;
      calculator.stopLossPrice = 95;
      calculator.riskPercent = 1;
      calculator.exitFees = 1;

      final result = calculator.value();

      expect(result.shares, 16);
      expect(result.positionAmount, closeTo(1600, 1e-3));
      expect(result.effectiveRisk, closeTo(95.2, 1e-3));
      expect(result.toleratedRisk, closeTo(100, 1e-3));
      expect(result.stopLossAmount, closeTo(0.16, 1e-3));
    });

    test('Calculates correct results when entryFees and exitFees are set', () {
      calculator.accountSize = 10000;
      calculator.entryPrice = 100;
      calculator.stopLossPrice = 95;
      calculator.riskPercent = 1;
      calculator.exitFees = 1;
      calculator.entryFees = 1;

      final result = calculator.value();

      expect(result.shares, 14);
      expect(result.positionAmount, closeTo(1400, 1e-3));
      expect(result.effectiveRisk, closeTo(97.30, 1e-3));
      expect(result.toleratedRisk, closeTo(100, 1e-3));
      expect(result.stopLossAmount, closeTo(0.14, 1e-3));
    });

    test('Calculates correct results when slippage is set', () {
      calculator.accountSize = 10000;
      calculator.entryPrice = 100;
      calculator.stopLossPrice = 95;
      calculator.riskPercent = 1;
      calculator.slippagePercent = 1;

      final result = calculator.value();

      expect(result.shares, 14);
      expect(result.positionAmount, closeTo(1414, 1e-3));
      expect(result.effectiveRisk, closeTo(97.30, 1e-3));
      expect(result.toleratedRisk, closeTo(100, 1e-3));
      expect(result.stopLossAmount, closeTo(0.1414, 1e-3));
    });

    test('Calculates correct results when reward/risk is set', () {
      calculator.accountSize = 10000;
      calculator.entryPrice = 100;
      calculator.stopLossPrice = 95;
      calculator.riskPercent = 1;
      calculator.slippagePercent = 1;
      calculator.rewardRisk = 2;

      final result = calculator.value();

      expect(result.shares, 14);
      expect(result.positionAmount, closeTo(1414, 1e-3));
      expect(result.effectiveRisk, closeTo(97.30, 1e-3));
      expect(result.toleratedRisk, closeTo(100, 1e-3));
      expect(result.stopLossAmount, closeTo(0.1414, 1e-3));
      expect(result.takeProfitAmount, closeTo(194.6, 1e-3));
      expect(result.takeProfitPrice, closeTo(114.90, 1e-3));
    });

    test('Calculating position size should return correct results', () {
      calculator.accountSize = 10000.0;
      calculator.entryPrice = 50.0;
      calculator.stopLossPrice = 45.0;
      calculator.slippagePercent = 1.0;
      calculator.riskPercent = 2.0;
      calculator.rewardRisk = 3.0;
      calculator.entryFees = 1.0;
      calculator.exitFees = 1.0;

      final results = calculator.value();

      expect(results.shares, 28.0);
      expect(results.positionAmount, 1414.0);
      expect(results.toleratedRisk, 200.0);
      expect(results.stopLossAmount, 0.1414);
      expect(results.effectiveRisk, closeTo(193.21, 0.01));
      expect(results.takeProfitAmount, closeTo(579.64, 0.01));
      expect(results.takeProfitPrice, closeTo(71.20, 0.01));
    });
  });
}
