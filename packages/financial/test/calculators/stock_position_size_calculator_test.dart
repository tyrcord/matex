// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

void main() {
  group('MatexStockPositionSizeCalculator', () {
    late MatexStockPositionSizeCalculator calculator;

    setUp(() {
      calculator = MatexStockPositionSizeCalculator();
    });

    group('Initialization', () {
      test('Default state should be initialized correctly', () {
        final defaultState = calculator.getState();

        expect(defaultState.accountSize, isNull);
        expect(defaultState.entryPrice, isNull);
        expect(defaultState.stopLossPrice, isNull);
        expect(defaultState.stopLossAmount, isNull);
        expect(defaultState.slippagePercent, isNull);
        expect(defaultState.riskPercent, isNull);
        expect(defaultState.riskReward, isNull);
        expect(defaultState.entryFees, isNull);
        expect(defaultState.exitFees, isNull);
        expect(defaultState.isShortPosition, false);
      });

      test('Setting state properties should update the state', () {
        calculator
          ..accountSize = 10000.0
          ..entryPrice = 50.0
          ..stopLossPrice = 45.0
          ..stopLossAmount = 500.0
          ..slippagePercent = 0.01
          ..riskPercent = 0.02
          ..riskReward = 3.0
          ..entryFees = 0.001
          ..exitFees = 0.002;

        final state = calculator.getState();

        expect(state.accountSize, 10000.0);
        expect(state.entryPrice, 50.0);
        expect(state.stopLossPrice, 45.0);
        expect(state.stopLossAmount, 0.0);
        expect(state.slippagePercent, 0.01);
        expect(state.riskPercent, 0.02);
        expect(state.riskReward, 3.0);
        expect(state.entryFees, 0.001);
        expect(state.exitFees, 0.002);
      });
    });

    group('Calculation without fees', () {
      test('Calculates correct results with mandatory properties', () {
        calculator
          ..accountSize = 10000
          ..entryPrice = 100
          ..stopLossPrice = 95
          ..riskPercent = 0.01;

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

      test('Calculates correct results when stopLossPrice is 0', () {
        calculator
          ..accountSize = 10000
          ..entryPrice = 1
          ..stopLossPrice = 0
          ..riskPercent = 0.01;

        final result = calculator.value();

        expect(result.shares, 100);
        expect(result.positionAmount, closeTo(100, 1e-3));
        expect(result.effectiveRisk, closeTo(100, 1e-3));
        expect(result.toleratedRisk, closeTo(100, 1e-3));
        expect(result.involvedCapital, closeTo(0.01, 1e-3));
        expect(result.entryPriceWithSlippage, closeTo(1, 0.01));
        expect(result.stopLossPriceWithSlippage, closeTo(0, 0.01));
        expect(result.stopLossPercentWithSlippage, closeTo(1, 0.01));
        expect(result.stopLossPercent, closeTo(1, 0.01));
      });
    });

    group('Calculation with fees', () {
      test('Calculates correct results when entryFees is set', () {
        calculator
          ..accountSize = 10000
          ..entryPrice = 100
          ..stopLossPrice = 95
          ..riskPercent = 0.01
          ..entryFees = 0.01;

        final result = calculator.value();

        expect(result.shares, 16);
        expect(result.positionAmount, closeTo(1600, 1e-3));
        expect(result.effectiveRisk, closeTo(96, 1e-3));
        expect(result.toleratedRisk, closeTo(100, 1e-3));
        expect(result.involvedCapital, closeTo(0.16, 1e-3));
      });

      test('Calculates correct results when exitFees is set', () {
        calculator
          ..accountSize = 10000
          ..entryPrice = 100
          ..stopLossPrice = 95
          ..riskPercent = 0.01
          ..exitFees = 0.01;

        final result = calculator.value();

        expect(result.shares, 16);
        expect(result.positionAmount, closeTo(1600, 1e-3));
        expect(result.effectiveRisk, closeTo(95.2, 1e-3));
        expect(result.toleratedRisk, closeTo(100, 1e-3));
        expect(result.involvedCapital, closeTo(0.16, 1e-3));
      });

      test('Calculates correct results when entryFees and exitFees are set',
          () {
        calculator
          ..accountSize = 10000
          ..entryPrice = 100
          ..stopLossPrice = 95
          ..riskPercent = 0.01
          ..exitFees = 0.01
          ..entryFees = 0.01;

        final result = calculator.value();

        expect(result.shares, 14);
        expect(result.positionAmount, closeTo(1400, 1e-3));
        expect(result.effectiveRisk, closeTo(97.30, 1e-3));
        expect(result.toleratedRisk, closeTo(100, 1e-3));
        expect(result.involvedCapital, closeTo(0.14, 1e-3));
      });
    });

    group('Calculation with slippage', () {
      test('Calculates correct results when slippage is set', () {
        calculator
          ..accountSize = 10000
          ..entryPrice = 100
          ..stopLossPrice = 95
          ..riskPercent = 0.01
          ..slippagePercent = 0.01;

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
        calculator
          ..accountSize = 10000
          ..entryPrice = 100
          ..stopLossPrice = 95
          ..riskPercent = 0.01
          ..slippagePercent = 0.01
          ..entryFees = 0.01
          ..exitFees = 0.01;

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
    });

    group('Calculation with risk/reward', () {
      test('Calculates correct results when reward/risk is set', () {
        calculator
          ..accountSize = 10000
          ..entryPrice = 100
          ..stopLossPrice = 95
          ..riskPercent = 0.01
          ..slippagePercent = 0.01
          ..riskReward = 2;

        final result = calculator.value();

        expect(result.shares, 14);
        expect(result.positionAmount, closeTo(1414, 1e-3));
        expect(result.effectiveRisk, closeTo(97.30, 1e-3));
        expect(result.toleratedRisk, closeTo(100, 1e-3));
        expect(result.involvedCapital, closeTo(0.1414, 1e-3));
        expect(result.takeProfitAmount, closeTo(194.6, 1e-3));
        expect(result.takeProfitPrice, closeTo(114.90, 1e-3));
      });

      test('Calculates correct results with different risk/reward ratio', () {
        calculator
          ..accountSize = 10000
          ..entryPrice = 100
          ..stopLossPrice = 95
          ..riskPercent = 0.01
          ..slippagePercent = 0.01
          ..riskReward = 3;
        final result = calculator.value();
        expect(result.shares, 14);
        expect(result.positionAmount, closeTo(1414, 1e-3));
        expect(result.effectiveRisk, closeTo(97.30, 1e-3));
        expect(result.takeProfitAmount, closeTo(291.90, 1e-3));
        expect(result.takeProfitPrice, closeTo(121.85, 1e-3));
      });
    });

    test('Calculating position size should return correct results', () {
      calculator
        ..accountSize = 10000.0
        ..entryPrice = 50.0
        ..stopLossPrice = 45.0
        ..slippagePercent = 0.01
        ..riskPercent = 0.02
        ..riskReward = 3.0
        ..entryFees = 0.01
        ..exitFees = 0.01;

      final results = calculator.value();

      expect(results.shares, 28.0);
      expect(results.positionAmount, 1414.0);
      expect(results.toleratedRisk, 200.0);
      expect(results.involvedCapital, 0.1414);
      expect(results.effectiveRisk, closeTo(193.21, 0.01));
      expect(results.stopLossPercentWithSlippage, closeTo(0.1178, 0.0001));
      expect(results.takeProfitAmount, closeTo(579.64, 0.01));
      expect(results.takeProfitPrice, closeTo(71.20, 0.01));
      expect(results.takeProfitAmountAfterFee, closeTo(559.71, 0.01));
      expect(results.takeProfitPriceWithSlippage, closeTo(70.49, 0.01));
    });

    group('Calculation with take profit', () {
      test('Calculates correct results when take profit price is set', () {
        calculator
          ..accountSize = 10000
          ..entryPrice = 100
          ..stopLossPrice = 95
          ..riskPercent = 0.01
          ..slippagePercent = 0.01
          ..takeProfitPrice = 111.425;
        final result = calculator.value();
        expect(result.shares, 14);
        expect(result.positionAmount, closeTo(1414, 1e-3));
        expect(result.effectiveRisk, closeTo(97.30, 1e-3));
        expect(result.takeProfitAmount, closeTo(145.95, 1e-3));
        expect(result.riskReward, closeTo(1.50, 1e-2));
      });

      test('Calculates correct results with different take profit price', () {
        calculator
          ..accountSize = 10000
          ..entryPrice = 100
          ..stopLossPrice = 95
          ..riskPercent = 0.01
          ..slippagePercent = 0.01
          ..takeProfitPrice = 120;
        final result = calculator.value();
        expect(result.shares, 14);
        expect(result.positionAmount, closeTo(1414, 1e-3));
        expect(result.effectiveRisk, closeTo(97.30, 1e-3));
        expect(result.takeProfitAmount, closeTo(266.00, 1e-3));
        expect(result.riskReward, closeTo(2.73, 1e-2));
      });
    });

    group('Switching between risk/reward and take profit', () {
      test(
          'Calculates correctly when switching from risk/reward to take profit',
          () {
        calculator
          ..accountSize = 10000
          ..entryPrice = 100
          ..stopLossPrice = 95
          ..riskPercent = 0.01
          ..slippagePercent = 0.01
          ..riskReward = 2;
        var result = calculator.value();
        expect(result.takeProfitPrice, closeTo(114.90, 1e-3));
        expect(result.riskReward, 2);

        calculator.takeProfitPrice = 111.425;
        result = calculator.value();
        expect(result.takeProfitPrice, 111.425);
        expect(result.riskReward, closeTo(1.50, 1e-2));
      });

      test(
          'Calculates correctly when switching from take profit to risk/reward',
          () {
        calculator
          ..accountSize = 10000
          ..entryPrice = 100
          ..stopLossPrice = 95
          ..riskPercent = 0.01
          ..slippagePercent = 0.01
          ..takeProfitPrice = 120;
        var result = calculator.value();
        expect(result.takeProfitPrice, 120);
        expect(result.riskReward, closeTo(2.73, 1e-2));

        calculator.riskReward = 2;
        result = calculator.value();
        expect(result.takeProfitPrice, closeTo(114.90, 1e-3));
        expect(result.riskReward, 2);
      });
    });

    group('Edge cases', () {
      test('Handles case when neither risk/reward nor take profit is set', () {
        calculator
          ..accountSize = 10000
          ..entryPrice = 100
          ..stopLossPrice = 95
          ..riskPercent = 0.01
          ..slippagePercent = 0.01;
        final result = calculator.value();
        expect(result.takeProfitPrice, 0);
        expect(result.riskReward, 0);
      });

      test('should handle zero values correctly', () {
        calculator
          ..accountSize = 0
          ..entryPrice = 0
          ..stopLossPrice = 0;

        final result = calculator.value();

        expect(result.shares, 0);
        expect(result.positionAmount, 0);
      });

      test('should calculate riskPercent from stopLossAmount and accountSize',
          () {
        calculator
          ..accountSize = 10000
          ..entryPrice = 100
          ..stopLossPrice = 95
          ..stopLossAmount = 200;

        final result = calculator.value();

        expect(result.shares, 40);
        expect(result.positionAmount, closeTo(4000, 1e-3));
        expect(result.effectiveRisk, closeTo(200.00, 1e-3));
        expect(result.toleratedRisk, closeTo(200, 1e-3));
        expect(result.involvedCapital, closeTo(0.4, 1e-3));
      });

      test('should handles very small values correctly', () {
        calculator
          ..accountSize = 0.0001
          ..entryPrice = 0.00001
          ..stopLossPrice = 0.000005
          ..riskPercent = 0.00001
          ..riskReward = 3.0;

        final result = calculator.value();

        expect(result.shares, isNotNull);
        expect(result.involvedCapital, lessThan(1e-3));
        expect(result.entryPriceWithSlippage, closeTo(0.00001, 1e-6));
        expect(result.stopLossPriceWithSlippage, closeTo(0.000005, 1e-6));
        expect(result.stopLossPercent, closeTo(0.5, 1e-3));
      });

      test('should handles very large values correctly', () {
        calculator
          ..accountSize = 1e9 // 1 billion
          ..entryPrice = 1e6 // 1 million
          ..stopLossPrice = 9e5 // 900,000
          ..riskPercent = 0.01;

        final result = calculator.value();

        expect(result.shares, isNotNull);
        expect(result.involvedCapital, lessThan(1));
        expect(result.entryPriceWithSlippage, closeTo(1e6, 1e-3));
        expect(result.stopLossPriceWithSlippage, closeTo(9e5, 1e-3));
        expect(result.stopLossPercent, closeTo(0.1, 1e-3));
      });
    });

    group('Short position calculations', () {
      test('Calculating short position size should return correct results', () {
        calculator
          ..accountSize = 10000.0
          ..entryPrice = 150.0
          ..stopLossPrice = 155.0
          ..riskPercent = 0.02
          ..isShortPosition = true;

        final results = calculator.value();

        expect(results.shares, 40);
        expect(results.effectiveRisk, 200);
        expect(results.positionAmount, 6000);
      });

      test(
          'Calculating short position size with slippage'
          'should return correct results', () {
        calculator
          ..accountSize = 10000.0
          ..entryPrice = 150.0
          ..stopLossPrice = 155.0
          ..riskPercent = 0.02
          ..slippagePercent = 0.01 // 1% slippage
          ..isShortPosition = true;

        final results = calculator.value();

        expect(results.shares, 24);
        expect(results.positionAmount, 3564.00);
        expect(results.effectiveRisk, closeTo(193.2, 0.2));
        expect(results.entryPriceWithSlippage, 148.5);
        expect(results.stopLossPriceWithSlippage, 156.55);
        expect(results.stopLossPercent, closeTo(0.033, 1e-3));
        expect(results.stopLossPercentWithSlippage, closeTo(0.0542, 1e-3));
      });

      test(
          'Calculating short position size with fess'
          'should return correct results', () {
        calculator
          ..accountSize = 10000.0
          ..entryPrice = 150.0
          ..stopLossPrice = 155.0
          ..riskPercent = 0.02
          ..entryFees = 0.01 // 1% fees
          ..exitFees = 0.01 // 1% fees
          ..isShortPosition = true
          ..riskReward = 2;

        final results = calculator.value();

        expect(results.shares, 24);
        expect(results.effectiveRisk, closeTo(193.2, 0.1));
        expect(results.positionAmount, 3600);
        expect(results.entryFeeAmount, 36.0);
        expect(results.stopLossFeeAmount, closeTo(37.2, 0.1));
        expect(results.totalFeesForLossPosition, closeTo(73.2, 0.1));
        expect(results.takeProfitAmount, closeTo(386.4, 0.1));
        expect(results.takeProfitPrice, closeTo(133.9, 0.1));
        expect(results.takeProfitAmountAfterFee, closeTo(354.264, 0.001));
        expect(results.stopLossPercent, closeTo(0.033, 1e-3));
      });

      test(
          'Calculating short position size with risk-reward ratio '
          'should return correct results', () {
        calculator
          ..accountSize = 10000.0
          ..entryPrice = 150.0
          ..stopLossPrice = 155.0
          ..riskPercent = 0.02
          ..riskReward = 2.5
          ..isShortPosition = true;

        final results = calculator.value();

        expect(results.shares, 40);
        expect(results.effectiveRisk, 200);
        expect(results.takeProfitPrice, 137.5);
        expect(results.takeProfitAmount, 500);
        expect(results.stopLossPercent, closeTo(0.033, 1e-3));
      });
    });
  });
}
