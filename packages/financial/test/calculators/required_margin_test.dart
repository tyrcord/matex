// ignore_for_file: unnecessary_type_check

import 'package:flutter_test/flutter_test.dart';
import 'package:matex_financial/financial.dart';

void main() {
  group('MatexForexRequiredMarginCalculator', () {
    late MatexForexRequiredMarginCalculator calculator;

    setUp(() {
      calculator = MatexForexRequiredMarginCalculator();
    });

    group('#isDirty', () {
      test('should return false by default', () {
        expect(calculator.isDirty, isFalse);
      });

      test('should return true when a calculator state is dirty', () {
        calculator.positionSize = 5;
        expect(calculator.isDirty, isTrue);
      });

      test(
        'should return false when a calculator state property '
        'has been reset to its default\'s value',
        () {
          calculator.positionSize = 5;
          expect(calculator.isDirty, isTrue);

          calculator.positionSize = null;
          expect(calculator.isDirty, isFalse);
        },
      );

      test(
        'should return false when a calculator state has been reset',
        () {
          calculator.positionSize = 5;
          expect(calculator.isDirty, isTrue);

          calculator.reset();
          expect(calculator.isDirty, isFalse);
        },
      );
    });

    group('#counterToAccountCurrencyRate()', () {
      test('should update counterToAccountCurrencyRate in the state', () {
        calculator.counterToAccountCurrencyRate = 2;

        expect(
          calculator.getState().counterToAccountCurrencyRate,
          equals(2),
        );
      });
    });

    group('#leverage()', () {
      test('should update leverage in the state', () {
        calculator.leverage = 2;
        expect(calculator.getState().leverage, equals(2));
      });
    });

    group('#positionSize()', () {
      test('should update position size in the state', () {
        calculator.positionSize = 1000;

        expect(calculator.getState().positionSize, equals(1000));
      });
    });

    group('#value()', () {
      test(
          'should correctly calculate margin '
          'when isAccountCurrencyCounter is true', () {
        calculator
          ..isAccountCurrencyCounter = true
          ..instrumentPairRate = 1.2
          ..positionSize = 10000
          ..leverage = 10;

        expect(calculator.value().requiredMargin, equals(1200));
      });

      test('should correctly calculate margin with account currency as base',
          () {
        calculator
          ..isAccountCurrencyBase = true
          ..instrumentPairRate = 1.1
          ..positionSize = 10000
          ..leverage = 10
          ..counterToAccountCurrencyRate = 1.5;

        expect(
          calculator.value().requiredMargin,
          closeTo(1000.0, 0.001),
        );
      });

      test(
          'should correctly calculate margin '
          'when account currency is not base and not counter', () {
        calculator
          ..isAccountCurrencyBase = false
          ..isAccountCurrencyBase = false
          ..instrumentPairRate = 1.1
          ..positionSize = 10000
          ..leverage = 10
          ..counterToAccountCurrencyRate = 0.8;

        expect(
          calculator.value().requiredMargin,
          closeTo(880.0, 0.001),
        );
      });
    });

    group('#isValid()', () {
      test(
          'Should be valid when the position size and '
          'the trading exchange rate are set', () {
        expect(calculator.isValid, isFalse);
        calculator
          ..instrumentPairRate = 1
          ..positionSize = 100000;

        expect(calculator.isValid, isTrue);
      });

      test('Invalid state when required fields are not set', () {
        calculator
          ..positionSize = null
          ..leverage = null;

        expect(calculator.isValid, isFalse);
      });
    });

    group('#reset()', () {
      test('should reset the calculator', () {
        calculator
          ..positionSize = 1000
          ..counterToAccountCurrencyRate = 1.5
          ..leverage = 2
          ..reset();

        final result = calculator.value();

        expect(calculator.getState().positionSize, isNull);
        expect(calculator.getState().leverage, equals(1));
        expect(calculator.getState().counterToAccountCurrencyRate, equals(0));
        expect(result.requiredMargin, equals(0));
      });
    });
  });
}
