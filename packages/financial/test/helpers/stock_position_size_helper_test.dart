// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

void main() {
  group('getShareAmount', () {
    test('should calculate position size correctly', () {
      const accountBalance = 10000.0;
      const risk = 0.02;
      const entryPrice = 50.0;
      const stopLossPrice = 45.0;

      final positionSize = getShareAmount(
        accountBalance: accountBalance,
        stopLossPrice: stopLossPrice,
        entryPrice: entryPrice,
        risk: risk,
      );

      expect(positionSize, equals(40.0));
    });

    test('should return 0 if account balance is 0', () {
      const accountBalance = 0.0;
      const risk = 0.02;
      const entryPrice = 50.0;
      const stopLossPrice = 45.0;

      final positionSize = getShareAmount(
        accountBalance: accountBalance,
        stopLossPrice: stopLossPrice,
        entryPrice: entryPrice,
        risk: risk,
      );

      expect(positionSize, equals(0));
    });

    test('should return 0 if risk is 0', () {
      const accountBalance = 10000.0;
      const risk = 0.0;
      const entryPrice = 50.0;
      const stopLossPrice = 45.0;

      final positionSize = getShareAmount(
        accountBalance: accountBalance,
        stopLossPrice: stopLossPrice,
        entryPrice: entryPrice,
        risk: risk,
      );

      expect(positionSize, equals(0));
    });

    test('should return 0 if entry price is 0', () {
      const accountBalance = 10000.0;
      const risk = 0.02;
      const entryPrice = 0.0;
      const stopLossPrice = 45.0;

      final positionSize = getShareAmount(
        accountBalance: accountBalance,
        stopLossPrice: stopLossPrice,
        entryPrice: entryPrice,
        risk: risk,
      );

      expect(positionSize, equals(0));
    });

    test('should return 0 if stop loss price is 0', () {
      const accountBalance = 10000.0;
      const risk = 0.02;
      const entryPrice = 50.0;
      const stopLossPrice = 0.0;

      final positionSize = getShareAmount(
        accountBalance: accountBalance,
        stopLossPrice: stopLossPrice,
        entryPrice: entryPrice,
        risk: risk,
      );

      expect(positionSize, equals(0));
    });

    test('should return 0 if price difference is 0', () {
      const accountBalance = 10000.0;
      const risk = 0.02;
      const entryPrice = 50.0;
      const stopLossPrice = 50.0;

      final positionSize = getShareAmount(
        accountBalance: accountBalance,
        stopLossPrice: stopLossPrice,
        entryPrice: entryPrice,
        risk: risk,
      );

      expect(positionSize, equals(0));
    });

    test(
        'should adjust position size for fractional stocks when '
        'fractionalStocks is false', () {
      const accountBalance = 10000.0;
      const risk = 0.02;
      const entryPrice = 52.0;
      const stopLossPrice = 45.0;
      const fractionalStocks = false;

      final positionSize = getShareAmount(
        accountBalance: accountBalance,
        stopLossPrice: stopLossPrice,
        entryPrice: entryPrice,
        risk: risk,
        fractionalStocks: fractionalStocks,
      );

      expect(positionSize, equals(28.0));
    });

    test(
        'should adjust position size for fractional stocks when'
        ' fractionalStocks is true', () {
      const accountBalance = 10000.0;
      const risk = 0.02;
      const entryPrice = 52.0;
      const stopLossPrice = 45.0;
      const fractionalStocks = true;

      final positionSize = getShareAmount(
        accountBalance: accountBalance,
        stopLossPrice: stopLossPrice,
        entryPrice: entryPrice,
        risk: risk,
        fractionalStocks: fractionalStocks,
      );

      expect(positionSize, closeTo(28.57, 0.01));
    });

    test('should adjust position size for fees', () {
      const accountBalance = 10000.0;
      const risk = 0.02;
      const entryPrice = 50.0;
      const stopLossPrice = 45.0;
      const fees = 0.01;

      final positionSize = getShareAmount(
        accountBalance: accountBalance,
        stopLossPrice: stopLossPrice,
        entryPrice: entryPrice,
        risk: risk,
        entryFees: fees,
        exitFees: fees,
      );

      expect(positionSize, equals(33));
    });

    test('should adjust stop loss price for slippage', () {
      const accountBalance = 10000.0;
      const risk = 0.02;
      const entryPrice = 50.0;
      const stopLossPrice = 45.0;
      const slippage = 0.005;

      final positionSize = getShareAmount(
        accountBalance: accountBalance,
        stopLossPrice: stopLossPrice,
        entryPrice: entryPrice,
        risk: risk,
        slippage: slippage,
      );

      expect(positionSize, equals(36));
    });

    test('should return 0 if account balance is negative', () {
      const accountBalance = -10000.0;
      const risk = 0.02;
      const entryPrice = 50.0;
      const stopLossPrice = 45.0;

      final positionSize = getShareAmount(
        accountBalance: accountBalance,
        stopLossPrice: stopLossPrice,
        entryPrice: entryPrice,
        risk: risk,
      );

      expect(positionSize, equals(0));
    });

    test('should handle large account balance and risk percentage', () {
      const accountBalance = 1e9; // 1 billion
      const risk = 0.1;
      const entryPrice = 100.0;
      const stopLossPrice = 90.0;

      final positionSize = getShareAmount(
        accountBalance: accountBalance,
        stopLossPrice: stopLossPrice,
        entryPrice: entryPrice,
        risk: risk,
      );

      expect(positionSize, equals(10000000));
    });

    test('should handle extremely small price difference', () {
      const accountBalance = 10000.0;
      const risk = 0.02;
      const entryPrice = 1000.0;
      const stopLossPrice = 999.999;

      final positionSize = getShareAmount(
        accountBalance: accountBalance,
        stopLossPrice: stopLossPrice,
        entryPrice: entryPrice,
        risk: risk,
      );

      expect(positionSize, equals(200000.0));
    });

    test('should handle negative risk percentage', () {
      const accountBalance = 10000.0;
      const risk = -0.02;
      const entryPrice = 50.0;
      const stopLossPrice = 45.0;

      final positionSize = getShareAmount(
        accountBalance: accountBalance,
        stopLossPrice: stopLossPrice,
        entryPrice: entryPrice,
        risk: risk,
      );

      expect(positionSize, equals(0));
    });
  });
}
