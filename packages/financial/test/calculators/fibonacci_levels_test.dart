// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

void main() {
  group('FibonacciLevelsCalculator', () {
    late MatexFibonacciLevelsCalculator calculator;

    setUp(() => calculator = MatexFibonacciLevelsCalculator());

    tearDown(() => calculator.reset());

    group('#isDirty', () {
      test('returns true if calculator state has been modified', () {
        calculator.highPrice = 1.5;
        expect(calculator.isDirty, isTrue);
      });

      test(
        'returns false after calculator state has been reset',
        () {
          calculator
            ..lowPrice = 1.15
            ..highPrice = 1.5;

          expect(calculator.isDirty, isTrue);

          calculator.reset();
          expect(calculator.isDirty, isFalse);
        },
      );

      test(
        'should return false when a calculator state has been reset',
        () {
          calculator.lowPrice = 1.15;
          expect(calculator.isDirty, isTrue);

          calculator.reset();
          expect(calculator.isDirty, isFalse);
        },
      );
    });

    group('#value()', () {
      test('should return the default value', () {
        final result = calculator.value();
        expect(
          result == MatexFibonacciLevelsCalculator.defaultResults,
          isTrue,
        );
      });

      test('should return the correct value when the trend is up', () {
        calculator
          ..trend = MatexTrend.up
          ..highPrice = 1.35
          ..lowPrice = 1.25;

        final result = calculator.value();
        final retracements = result.retracementLevels;
        final extensions = result.extensionLevels;

        // retracements

        expect(retracements[0].level, closeTo(0.236, 0.001));
        expect(retracements[0].value, closeTo(1.3264, 0.0001));

        expect(
          retracements[1],
          equals(MatexFibonacciLevel(level: 0.382, value: 1.31180)),
        );

        expect(
          retracements[2],
          equals(MatexFibonacciLevel(level: 0.5, value: 1.3)),
        );

        expect(
          retracements[3],
          equals(MatexFibonacciLevel(level: 0.618, value: 1.28820)),
        );

        expect(retracements[4].level, closeTo(0.786, 0.001));
        expect(retracements[4].value, closeTo(1.2714, 0.0001));

        // extensions

        expect(extensions[0].level, closeTo(2.618, 0.001));
        expect(extensions[0].value, closeTo(1.61180, 0.0001));

        expect(extensions[1].level, closeTo(2, 1));
        expect(extensions[1].value, closeTo(1.55, 0.01));

        expect(extensions[2].level, closeTo(1.618, 0.001));
        expect(extensions[2].value, closeTo(1.5118, 0.0001));

        expect(extensions[3].level, closeTo(1.5, 0.1));
        expect(extensions[3].value, closeTo(1.5, 0.1));

        expect(extensions[4].level, closeTo(1.382, 0.001));
        expect(extensions[4].value, closeTo(1.48820, 0.0001));

        expect(extensions[5].level, closeTo(1.236, 0.001));
        expect(extensions[5].value, closeTo(1.4736, 0.0001));

        expect(extensions[6].level, closeTo(1, 1));
        expect(extensions[6].value, closeTo(1.45, 0.01));

        expect(extensions[7].level, closeTo(0.618, 0.001));
        expect(extensions[7].value, closeTo(1.4118, 0.0001));

        expect(extensions[8].level, closeTo(0.5, 0.1));
        expect(extensions[8].value, closeTo(1.4, 0.1));

        expect(extensions[9].level, closeTo(0.382, 0.001));
        expect(extensions[9].value, closeTo(1.38820, 0.0001));

        expect(extensions[10].level, closeTo(0.236, 0.001));
        expect(extensions[10].value, closeTo(1.3736, 0.0001));
      });

      test('should return the correct value when the trend is down', () {
        calculator
          ..trend = MatexTrend.down
          ..highPrice = 1.35
          ..lowPrice = 1.25;

        final result = calculator.value();
        final retracements = result.retracementLevels;
        final extensions = result.extensionLevels;

        // retracements

        expect(retracements[0].level, closeTo(0.786, 0.001));

        expect(retracements[0].value, closeTo(1.3286, 0.0001));

        expect(
          retracements[1],
          equals(MatexFibonacciLevel(level: 0.618, value: 1.3118)),
        );

        expect(
          retracements[2],
          equals(MatexFibonacciLevel(level: 0.5, value: 1.3)),
        );

        expect(
          retracements[3],
          equals(MatexFibonacciLevel(level: 0.382, value: 1.2882)),
        );

        expect(retracements[4].level, closeTo(0.236, 0.001));

        expect(retracements[4].value, closeTo(1.2736, 0.0001));

        // extensions

        expect(extensions[0].level, closeTo(0.236, 0.001));

        expect(extensions[0].value, closeTo(1.22640, 0.0001));

        expect(
          extensions[1],
          equals(MatexFibonacciLevel(level: 0.382, value: 1.2118)),
        );

        expect(
          extensions[2],
          equals(MatexFibonacciLevel(level: 0.5, value: 1.2)),
        );

        expect(
          extensions[3],
          equals(MatexFibonacciLevel(level: 0.618, value: 1.18820)),
        );

        expect(
          extensions[4],
          equals(MatexFibonacciLevel(level: 1, value: 1.15)),
        );

        expect(extensions[5].level, closeTo(1.236, 0.001));

        expect(extensions[5].value, closeTo(1.1264, 0.0001));

        expect(
          extensions[6],
          equals(MatexFibonacciLevel(level: 1.382, value: 1.1118)),
        );

        expect(extensions[7].level, closeTo(1.5, 0.1));
        expect(extensions[7].value, closeTo(1.1, 0.1));

        expect(extensions[8].level, closeTo(1.618, 0.001));
        expect(extensions[8].value, closeTo(1.0882, 0.0001));

        expect(extensions[9].level, closeTo(2, 0.001));
        expect(extensions[9].value, closeTo(1.05, 0.0001));

        expect(extensions[10].level, closeTo(2.618, 0.001));
        expect(extensions[10].value, closeTo(0.9882, 0.0001));
      });
    });

    group('#lowPrice()', () {
      test('Should define the lowPrice value', () {
        calculator.lowPrice = 1;
        expect(calculator.getState().lowPrice, equals(1));
      });
    });

    group('#highPrice()', () {
      test('Should define the highPrice value', () {
        calculator.highPrice = 2;
        expect(calculator.getState().highPrice, equals(2));
      });
    });

    group('#trend()', () {
      test('Should have a default value', () {
        expect(calculator.getState().trend, equals(MatexTrend.up));
      });

      test('Should define the trend value', () {
        calculator.trend = MatexTrend.down;
        expect(calculator.getState().trend, equals(MatexTrend.down));
      });
    });

    group('#isValid()', () {
      test('Should not be valid when no high and low prices are set', () {
        expect(calculator.isValid, isFalse);

        calculator
          ..highPrice = 0
          ..lowPrice = 0;

        expect(calculator.isValid, isFalse);
      });

      test('Should not be valid when only the low price is set', () {
        calculator.lowPrice = 1.25;
        expect(calculator.isValid, isFalse);
      });

      test('Should not be valid when only the high price is set', () {
        calculator.highPrice = 1.25;
        expect(calculator.isValid, isFalse);
      });

      test('Should be valid when: low price <= high price', () {
        calculator
          ..highPrice = 1.35
          ..lowPrice = 2;

        expect(calculator.isValid, isFalse);

        final result = calculator.value();
        expect(result == MatexFibonacciLevelsCalculator.defaultResults, isTrue);

        calculator.lowPrice = 1.35;
        expect(calculator.isValid, isFalse);

        calculator.lowPrice = 1.25;
        expect(calculator.isValid, isTrue);
      });
    });

    group('#reset()', () {
      test('should reset the calculator', () {
        calculator
          ..highPrice = 1.35
          ..lowPrice = 1.25
          ..reset();

        final result = calculator.value();

        expect(
          result == MatexFibonacciLevelsCalculator.defaultResults,
          isTrue,
        );
      });
    });
  });
}
