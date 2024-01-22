// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

void main() {
  group('MatexForexPipDeltaCalculator', () {
    late MatexForexPipDeltaCalculator calculator;

    setUp(() => calculator = MatexForexPipDeltaCalculator());

    tearDown(() => calculator.reset());

    group('#isDirty', () {
      test('returns true if calculator state has been modified', () {
        calculator.priceA = 1.5;
        expect(calculator.isDirty, isTrue);
      });

      test(
        'returns false after calculator state has been reset',
        () {
          calculator.priceA = 1.5;
          expect(calculator.isDirty, isTrue);

          calculator.reset();
          expect(calculator.isDirty, isFalse);
        },
      );

      test('should return false when a calculator state has been reset', () {
        calculator.priceA = 1.5;
        expect(calculator.isDirty, isTrue);

        calculator.reset();
        expect(calculator.isDirty, isFalse);
      });
    });

    group('#isValid', () {
      test('should not be valid by default', () {
        expect(calculator.isValid, isFalse);
      });

      test('should not be valid when both prices are set to zero', () {
        calculator
          ..priceA = 0
          ..priceB = 0;

        expect(calculator.isValid, isFalse);
      });

      test('should be valid when only the price A is set', () {
        calculator.priceA = 1.5;
        expect(calculator.isValid, isTrue);
      });

      test('should be valid when only the price B is set', () {
        calculator.priceB = 1.5;
        expect(calculator.isValid, isTrue);
      });

      test('should be valid when the price A and B are set', () {
        calculator
          ..priceA = 1.5
          ..priceB = 1.6;

        expect(calculator.isValid, isTrue);
      });
    });

    group('#priceA()', () {
      test('should define the price A', () {
        calculator.priceA = 1.5;
        expect(calculator.getState().priceA, equals(1.5));
      });

      test('should impact the result', () {
        calculator
          ..priceB = 1.20502
          ..priceA = 1.20460
          ..pipDecimalPlaces = 4;

        expect(calculator.value().numberOfPips, closeTo(4.2, 0.1));

        calculator
          ..priceB = 1.205
          ..priceA = 1.204
          ..pipDecimalPlaces = 2;
        expect(calculator.value().numberOfPips, closeTo(0.1, 0.1));
      });
    });

    group('#priceB()', () {
      test('should define the price B', () {
        calculator.priceB = 1.5;
        expect(calculator.getState().priceB, equals(1.5));
      });

      test('should impact the result', () {
        calculator
          ..priceB = 1.20502
          ..priceA = 1.20460
          ..pipDecimalPlaces = 4;

        expect(calculator.value().numberOfPips, closeTo(4.2, 0.1));

        calculator
          ..priceB = 1.205
          ..priceA = 1.204
          ..pipDecimalPlaces = 2;

        expect(calculator.value().numberOfPips, closeTo(0.1, 0.1));
      });
    });

    group('#pipDecimalPlaces()', () {
      test('should define the pip precision value', () {
        calculator.pipDecimalPlaces = 2;
        expect(calculator.getState().pipDecimalPlaces, equals(2));
      });

      test('should impact the result', () {
        calculator
          ..priceA = 1.50
          ..priceB = 1.40
          ..pipDecimalPlaces = 2;

        expect(calculator.value().numberOfPips, closeTo(10, 1));

        calculator
          ..priceA = 1.50
          ..priceB = 1.40
          ..pipDecimalPlaces = 4;

        expect(calculator.value().numberOfPips, closeTo(1000, 1));
      });
    });

    group('#value()', () {
      test('should return the default values', () {
        final results = calculator.value();

        expect(results.numberOfPips, equals(0));
      });
    });

    group('#reset()', () {
      test('should reset the calculator', () {
        calculator
          ..priceA = 1.5
          ..priceB = 1.6
          ..reset();

        final results = calculator.value();
        expect(results.numberOfPips, equals(0));
      });
    });
  });
}
