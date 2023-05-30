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
      expect(results.involvedCapital, 0.1414);
      expect(results.effectiveRisk, closeTo(193.21, 0.01));
      expect(results.takeProfitAmount, closeTo(579.64, 0.01));
      expect(results.takeProfitPrice, closeTo(71.20, 0.01));
    });
  });
}
