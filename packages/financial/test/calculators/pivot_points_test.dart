// ignore_for_file: constant_identifier_names

import 'package:flutter_test/flutter_test.dart';
import 'package:matex_financial/financial.dart';

const PIVOT_POINTS_DEFAULT_RESULTS = MatexPivotPointsCalculatorResults(
  pivotPoint: 0,
  resistances: [0, 0, 0],
  supports: [0, 0, 0],
);

const PIVOT_POINTS_WOODIE_RESULTS = MatexPivotPointsCalculatorResults(
  pivotPoint: 1.425,
  resistances: [1.55, 1.625],
  supports: [1.35, 1.225],
);

const PIVOT_POINTS_DEMARK_RESULTS = MatexPivotPointsCalculatorResults(
  pivotPoint: 1.375,
  resistances: [1.45],
  supports: [1.25],
);

const PIVOT_POINTS_DEMARK_RESULTS_CLOSE_GREATER_OPEN =
    MatexPivotPointsCalculatorResults(
  pivotPoint: 1.4375,
  resistances: [1.575],
  supports: [1.375],
);

const PIVOT_POINTS_DEMARK_RESULTS_OPEN_GREATER_CLOSE =
    MatexPivotPointsCalculatorResults(
  pivotPoint: 1.355,
  resistances: [1.41],
  supports: [1.21],
);

const PIVOT_POINTS_STANDARD = MatexPivotPointsCalculatorResults(
  pivotPoint: 1.35,
  resistances: [1.45, 1.6, 1.7],
  supports: [1.2, 1.1, 0.95],
);

const PIVOT_POINTS_FIBONACCI = MatexPivotPointsCalculatorResults(
  pivotPoint: 1.35,
  resistances: [1.4455, 1.5045, 1.6],
  supports: [1.2545, 1.1955, 1.1],
);

const PIVOT_POINTS_CAMARILLA = MatexPivotPointsCalculatorResults(
  pivotPoint: 4 / 3,
  resistances: [1.3275, 1.355, 1.3825, 1.465],
  supports: [1.2725, 1.245, 1.2175, 1.135],
);

void main() {
  group('MatexPivotPointsCalculator', () {
    late MatexPivotPointsCalculator calculator;

    setUp(() {
      calculator = MatexPivotPointsCalculator();
    });

    group('#value()', () {
      test('should returns default results by default', () {
        final results = calculator.value();

        expect(results, equals(MatexPivotPointsCalculator.defaultResults));
      });
    });

    group('#isDirty', () {
      test('should return false by default', () {
        expect(calculator.isDirty, isFalse);
      });

      test('returns true when calculator state changes', () {
        calculator.highPrice = 1.5;
        expect(calculator.isDirty, isTrue);
      });

      test(
        'returns false when calculator state is reset to default',
        () {
          calculator = MatexPivotPointsCalculator(
            defaultState: const MatexPivotPointsCalculatorState(
              lowPrice: 1,
            ),
          )..lowPrice = 1.5;

          expect(calculator.isDirty, isTrue);

          calculator.lowPrice = 1;
          expect(calculator.isDirty, isFalse);
        },
      );

      test(
        'should return false when a calculator state has been reset',
        () {
          calculator.highPrice = 1;
          expect(calculator.isDirty, isTrue);

          calculator.reset();
          expect(calculator.isDirty, isFalse);
        },
      );
    });

    group('#isValid', () {
      test('Should not be valid when no low, high and close prices are set',
          () {
        expect(calculator.isValid, isFalse);

        calculator.lowPrice = 1;
        expect(calculator.isValid, isFalse);

        calculator.highPrice = 2;
        expect(calculator.isValid, isFalse);

        calculator.closePrice = 2;
        expect(calculator.isValid, isTrue);

        calculator
          ..highPrice = 0
          ..lowPrice = 0
          ..closePrice = 0;

        expect(calculator.isValid, isFalse);
      });

      test('Should not be valid when only the low price is set', () {
        calculator.lowPrice = 1;
        expect(calculator.isValid, isFalse);
      });

      test('Should not be valid when only the high price is set', () {
        calculator.highPrice = 1;
        expect(calculator.isValid, isFalse);
      });

      test('Should not be valid when only the close price is set', () {
        calculator.closePrice = 1;
        expect(calculator.isValid, isFalse);
      });

      test(
          'Should be valid when: close price >= low price && '
          'close price <= high price', () {
        calculator
          ..highPrice = 2
          ..lowPrice = 1;

        expect(calculator.isValid, isFalse);

        calculator.closePrice = 3;
        expect(calculator.isValid, isFalse);

        calculator.closePrice = 0.5;
        expect(calculator.isValid, isFalse);

        calculator.closePrice = 1.5;
        expect(calculator.isValid, isTrue);

        calculator.closePrice = 1;
        expect(calculator.isValid, isTrue);

        calculator.closePrice = 2;
        expect(calculator.isValid, isTrue);
      });

      test(
          'Should not be valid when no low, high, open and '
          'close prices are set when the method is DeMark', () {
        calculator.method = MatexPivotPointsMethods.deMark;
        expect(calculator.isValid, isFalse);

        calculator.lowPrice = 1;
        expect(calculator.isValid, isFalse);

        calculator.highPrice = 2;
        expect(calculator.isValid, isFalse);

        calculator.closePrice = 2;
        expect(calculator.isValid, isFalse);

        calculator.openPrice = 2;
        expect(calculator.isValid, isTrue);

        calculator
          ..openPrice = 0
          ..highPrice = 0
          ..lowPrice = 0
          ..closePrice = 0;

        expect(calculator.isValid, isFalse);
      });

      test(
          'Should be valid when: close price >= low price && '
          'open price <= high price', () {
        calculator
          ..highPrice = 2
          ..lowPrice = 1
          ..closePrice = 2
          ..method = MatexPivotPointsMethods.deMark;

        expect(calculator.isValid, isFalse);

        calculator.openPrice = 3;
        expect(calculator.isValid, isFalse);

        calculator.openPrice = 0.5;
        expect(calculator.isValid, isFalse);

        calculator.openPrice = 1.5;
        expect(calculator.isValid, isTrue);

        calculator.openPrice = 1;
        expect(calculator.isValid, isTrue);

        calculator.openPrice = 2;
        expect(calculator.isValid, isTrue);
      });
    });

    group('#setState()', () {
      test('should update the calculator state', () {
        calculator.setState(const MatexPivotPointsCalculatorState(
          closePrice: 1,
        ));

        expect(calculator.getState().closePrice, equals(1));
      });
    });

    group('#closePrice()', () {
      test('should define the close price value', () {
        calculator.closePrice = 1;
        expect(calculator.getState().closePrice, equals(1));
      });
    });

    group('#highPrice()', () {
      test('should define the high price value', () {
        calculator.highPrice = 1;
        expect(calculator.getState().highPrice, equals(1));
      });
    });

    group('#lowPrice()', () {
      test('should define the low price value', () {
        calculator.lowPrice = 1;
        expect(calculator.getState().lowPrice, equals(1));
      });
    });

    group('#method()', () {
      test('should define the method value', () {
        calculator.method = MatexPivotPointsMethods.deMark;

        expect(
          calculator.getState().method,
          equals(MatexPivotPointsMethods.deMark),
        );
      });
    });

    group('#openPrice()', () {
      test('should define the open price value', () {
        calculator.openPrice = 1;
        expect(calculator.getState().openPrice, equals(1));
      });
    });

    group('#reset()', () {
      test('should reset the calculator', () {
        calculator
          ..openPrice = 1
          ..lowPrice = 1
          ..highPrice = 2
          ..reset();

        final results = calculator.value();

        expect(results, equals(MatexPivotPointsCalculator.defaultResults));
      });
    });
  });
}
