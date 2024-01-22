// Package imports:
import 'package:flutter_test/flutter_test.dart';

import 'package:matex_financial/financial.dart'; // Import your calculator here

void main() {
  group('MatexForexProfitLossCalculator', () {
    late MatexForexProfitLossCalculator calculator;

    setUp(() => calculator = MatexForexProfitLossCalculator());

    test(
        'should calculate net profit correctly'
        'when account currency is the counter one', () {
      calculator
        ..positionSize = 1000.0
        ..entryPrice = 1.1500
        ..exitPrice = 1.1550
        // EUR/USD
        ..instrumentPairRate = 1
        // USD
        ..isAccountCurrencyCounter = true;

      final result = calculator.value();

      expect(result.netProfit, closeTo(5, 1));
      expect(result.returnOnInvestment, closeTo(0.0043, 0.0001));
    });

    test(
        'should calculate net profit correctly'
        'when account currency is the counter one and a loss', () {
      calculator
        ..positionSize = 1000.0
        ..entryPrice = 1.1550
        ..exitPrice = 1.150
        // EUR/USD
        ..instrumentPairRate = 1
        // USD
        ..isAccountCurrencyCounter = true;

      final result = calculator.value();

      expect(result.netProfit, closeTo(-5.0, 1));
      expect(result.returnOnInvestment, closeTo(-0.0043, 0.0001));
    });

    test(
        'should calculate net profit correctly'
        'when account currency is not the base one', () {
      calculator
        ..positionSize = 1000.0
        ..entryPrice = 1.1500
        ..exitPrice = 1.1550
        // EUR/USD
        ..instrumentPairRate = 1.1
        // EUR
        ..isAccountCurrencyCounter = false;

      final result = calculator.value();

      expect(result.netProfit, closeTo(4.54, 0.01));
      expect(result.returnOnInvestment, closeTo(0.004, 0.001));
    });

    test(
        'should calculate net profit correctly'
        'when account currency is not the base one and a loss', () {
      calculator
        ..positionSize = 1000.0
        ..entryPrice = 1.1550
        ..exitPrice = 1.1500
        // EUR/USD
        ..instrumentPairRate = 1.1
        // EUR
        ..isAccountCurrencyCounter = false;

      final result = calculator.value();

      expect(result.netProfit, closeTo(-4.54, 0.01));
      expect(result.returnOnInvestment, closeTo(-0.004, 0.001));
    });

    test(
        'should calculate net profit correctly '
        'when account currency is not the counter one', () {
      calculator
        ..positionSize = 1000.0
        ..entryPrice = 1.1500
        ..exitPrice = 1.1550
        // EUR/USD
        ..instrumentPairRate = 1.1
        // USD/CAD
        ..counterToAccountCurrencyRate = 1.25
        // CAD
        ..isAccountCurrencyCounter = false;

      final result = calculator.value();

      expect(result.netProfit, closeTo(6.25, 0.01));
      expect(result.returnOnInvestment, closeTo(0.0043, 0.0001));
    });

    test(
        'should calculate net profit correctly '
        'when account currency is not the counter one and a loss', () {
      calculator
        ..positionSize = 1000.0
        ..entryPrice = 1.1550
        ..exitPrice = 1.150
        // EUR/USD
        ..instrumentPairRate = 1.1
        // USD/CAD
        ..counterToAccountCurrencyRate = 1.25
        // CAD
        ..isAccountCurrencyCounter = false;

      final result = calculator.value();

      expect(result.netProfit, closeTo(-6.25, 0.01));
      expect(result.returnOnInvestment, closeTo(-0.0043, 0.0001));
    });

    test(
        'should calculate net profit correctly '
        'when account currency is not the counter one and short', () {
      calculator
        ..positionSize = 1000.0
        ..entryPrice = 1.1550
        ..exitPrice = 1.150
        ..position = MatexPosition.short
        // EUR/USD
        ..instrumentPairRate = 1.1
        // USD/CAD
        ..counterToAccountCurrencyRate = 1.25
        // CAD
        ..isAccountCurrencyCounter = false;

      final result = calculator.value();

      expect(result.netProfit, closeTo(6.25, 0.01));
      expect(result.returnOnInvestment, closeTo(0.0043, 0.0001));
    });
  });
}
