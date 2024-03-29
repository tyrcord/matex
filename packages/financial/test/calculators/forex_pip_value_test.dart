// ignore_for_file: unnecessary_type_check

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

void main() {
  group('PipValueCalculator', () {
    late MatexForexPipValueCalculator calculator;

    setUp(() {
      calculator = MatexForexPipValueCalculator();
    });

    group('#isDirty', () {
      test('returns true when calculator state changes', () {
        calculator.positionSize = 5000;
        expect(calculator.isDirty, equals(true));
      });

      test('returns false when calculator state is reset to default', () {
        calculator = MatexForexPipValueCalculator(
          defaultState:
              const MatexForexPipValueCalculatorState(positionSize: 100),
        )..positionSize = 5000;

        expect(calculator.isDirty, equals(true));

        calculator.positionSize = 100;
        expect(calculator.isDirty, equals(false));
      });
    });

    group('#isValid', () {
      test('is invalid by default', () {
        expect(calculator.isValid, equals(false));
      });

      test('remains invalid with only position size set', () {
        calculator.positionSize = 5000;

        expect(calculator.isValid, equals(false));
      });

      test('remains invalid with only instrumentPairRate set', () {
        calculator.instrumentPairRate = 1.5;

        expect(calculator.isValid, equals(false));
      });

      test('is valid with both position size and instrumentPairRate set', () {
        calculator
          ..positionSize = 5000
          ..instrumentPairRate = 1.5;

        expect(calculator.isValid, equals(true));
      });

      test('remains invalid with negative position size', () {
        calculator
          ..positionSize = -5000
          ..instrumentPairRate = 1.5;

        expect(calculator.isValid, equals(false));
      });

      test('remains invalid with negative instrumentPairRate', () {
        calculator
          ..positionSize = 5000
          ..instrumentPairRate = -1.5;

        expect(calculator.isValid, equals(false));
      });
    });

    group('#value()', () {
      test('returns default result without configurations', () {
        final results = calculator.value();

        const defaultResults = MatexForexPipValueCalculatorResults(
          pipValue: 0,
        );

        expect(results.pipValue, equals(defaultResults.pipValue));
      });
    });

    group('#computePipValue()', () {
      test('returns pipValue for isAccountCurrencyCounter', () {
        calculator
          ..positionSize = 10000
          ..pipDecimalPlaces = 4
          ..instrumentPairRate = 1
          ..isAccountCurrencyCounter = true;

        final results = calculator.value();

        expect(results.pipValue, closeTo(1.0, 0.001));
      });

      test('returns pipValue without counterToAccountCurrencyRate', () {
        calculator
          ..positionSize = 10000
          ..pipDecimalPlaces = 4
          ..instrumentPairRate = 1.2;

        final results = calculator.value();

        expect(results.pipValue, closeTo(0.8333, 0.001));
      });

      test('returns pipValue with counterToAccountCurrencyRate', () {
        calculator
          ..positionSize = 10000
          ..pipDecimalPlaces = 4
          ..instrumentPairRate = 1.2
          ..counterToAccountCurrencyRate = 1.5;

        final results = calculator.value();

        expect(results.pipValue, closeTo(1.5, 0.001));
      });
    });

    group('#pipDecimalPlaces', () {
      test('should update pipDecimalPlaces in the state', () {
        calculator.pipDecimalPlaces = 4;

        expect(calculator.getState().pipDecimalPlaces, equals(4));
      });
    });

    group('#positionSize()', () {
      test('should define the position size', () {
        calculator.positionSize = 1;

        expect(
          calculator.getState().positionSize,
          equals(1),
        );

        calculator.positionSize = 1000;

        expect(
          calculator.getState().positionSize,
          equals(1000),
        );
      });
    });

    group('#isAccountCurrencyCounter', () {
      test('should update isAccountCurrencyCounter in the state', () {
        calculator.isAccountCurrencyCounter = true;

        expect(calculator.getState().isAccountCurrencyCounter, equals(true));
      });
    });

    group('#counterToAccountCurrencyRate', () {
      test('should update counterToAccountCurrencyRate in the state', () {
        calculator.counterToAccountCurrencyRate = 1.5;

        expect(calculator.getState().counterToAccountCurrencyRate, equals(1.5));
      });
    });

    group('#instrumentPairRate', () {
      test('should update instrumentPairRate in the state', () {
        calculator.instrumentPairRate = 1.8;

        expect(calculator.getState().instrumentPairRate, equals(1.8));
      });
    });
  });
}
