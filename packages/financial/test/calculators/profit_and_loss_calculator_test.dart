// Import the relevant packages

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

void main() {
  group('MatexProfitAndLossCalculator', () {
    late MatexProfitAndLossCalculator calculator;

    setUp(() {
      calculator = MatexProfitAndLossCalculator();
    });

    test('calculates revenue correctly', () {
      calculator
        ..expectedSaleUnits = 1000
        ..buyingPrice = 100.0
        ..sellingPrice = 150.0;

      final result = calculator.value();

      expect(result.revenue, 150000.0);
      expect(result.grossProfit, 50000.0);
      expect(result.operatingProfit, 50000.0);
      expect(result.netProfit, 50000.0);
      expect(result.returnOnInvestment, 0.5);
      expect(result.netProfitMargin, closeTo(0.3333, 0.0001));
      expect(result.grossProfitMargin, closeTo(0.3333, 0.0001));
    });

    test('computes gross profit accurately', () {
      calculator
        ..expectedSaleUnits = 1000
        ..buyingPrice = 100.0
        ..sellingPrice = 150.0
        ..buyingExpensePerUnitAmount = 10.0;

      final result = calculator.value();

      expect(result.revenue, 150000.0);
      expect(result.grossProfit, 40000.0);
      expect(result.netProfit, 40000.0);
      expect(result.returnOnInvestment, closeTo(0.36, 0.01));
    });

    test('determines operating profit considering operating expenses', () {
      calculator
        ..expectedSaleUnits = 1000
        ..buyingPrice = 100.0
        ..sellingPrice = 150.0
        ..operatingExpenses = 2000.0
        ..buyingExpensePerUnitAmount = 10.0;

      final result = calculator.value();

      expect(result.revenue, 150000.0);
      expect(result.grossProfit, 40000.0);
      expect(result.operatingProfit, 38000.0);
      expect(result.netProfit, 38000.0);
      expect(result.returnOnInvestment, closeTo(0.3393, 0.0001));
      expect(result.breakEvenUnits, 50);
    });

    test('calculates net profit, considering all expenses and revenues', () {
      calculator
        ..expectedSaleUnits = 1000
        ..buyingPrice = 100.0
        ..sellingPrice = 150.0
        ..operatingExpenses = 2000.0
        ..buyingExpensePerUnitAmount = 10.0
        ..sellingExpensePerUnitAmount = 5.0;

      final result = calculator.value();

      expect(result.revenue, 150000.0);
      expect(result.grossProfit, 40000.0);
      expect(result.operatingProfit, 33000.0);
      expect(result.netProfit, 33000.0);
      expect(result.returnOnInvestment, closeTo(0.2821, 0.0001));
      expect(result.breakEvenUnits, 58);
    });

    test('computes tax amount based on the applicable tax rate', () {
      calculator
        ..expectedSaleUnits = 1000
        ..buyingPrice = 100.0
        ..sellingPrice = 150.0
        ..taxRate = 0.2;

      final result = calculator.value();

      expect(result.revenue, 150000.0);
      expect(result.grossProfit, 50000.0);
      expect(result.operatingProfit, 50000.0);
      expect(result.netProfit, 40000.0);
      expect(result.taxAmount, 10000.0);
      expect(result.returnOnInvestment, closeTo(0.4, 0.0001));
    });

    test('determines return on investment from net profit and total expenses',
        () {
      calculator
        ..expectedSaleUnits = 1000
        ..buyingPrice = 100.0
        ..sellingPrice = 150.0;

      final result = calculator.value();

      expect(result.returnOnInvestment, 0.50);
    });

    test('calculates break-even units considering all expenses', () {
      calculator
        ..expectedSaleUnits = 1000
        ..buyingPrice = 100.0
        ..sellingPrice = 150.0
        ..operatingExpenses = 2000.0
        ..buyingExpensePerUnitAmount = 10.0
        ..sellingExpensePerUnitAmount = 5.0
        ..taxRate = 0.2;

      final result = calculator.value();

      expect(result.revenue, 150000.0);
      expect(result.costOfGoodsSold, 110000.0);
      expect(result.grossProfit, 40000.0);
      expect(result.sellingExpenses, 7000.0);
      expect(result.operatingProfit, 33000.0);
      expect(result.taxAmount, 6600.0);
      expect(result.netProfit, 26400.0);
      expect(result.returnOnInvestment, closeTo(0.2256, 0.0001));
      expect(result.breakEvenUnits, 58);
      expect(result.costOfInvestment, 117000);
      expect(result.netProfitMargin, closeTo(0.1760, 0.0001));
      expect(result.grossProfitMargin, closeTo(0.2667, 0.0001));
    });
  });
}
