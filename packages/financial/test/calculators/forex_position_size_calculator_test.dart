import 'package:flutter_test/flutter_test.dart';
import 'package:matex_financial/financial.dart';

void main() {
  group('MatexForexPositionSizeCalculator', () {
    late MatexForexPositionSizeCalculator calculator;

    setUp(() => calculator = MatexForexPositionSizeCalculator());

    tearDown(() => calculator.reset());

    group('#isDirty', () {
      test('returns true if calculator state has been modified', () {
        calculator.accountSize = 5000;
        expect(calculator.isDirty, equals(true));
      });

      test('returns false after calculator state has been reset', () {
        calculator.accountSize = 5000;
        expect(calculator.isDirty, equals(true));

        calculator.reset();
        expect(calculator.isDirty, equals(false));
      });
    });

    group('#isValid', () {
      test('should initially be invalid by default', () {
        expect(calculator.isValid, equals(false));
      });

      test('remains invalid with only account size set', () {
        calculator.accountSize = 5000;
        expect(calculator.isValid, equals(false));
      });

      test('stays invalid when only risk amount is specified', () {
        calculator.riskAmount = 50;
        expect(calculator.isValid, equals(false));
      });

      test('remains invalid with only risk percent set', () {
        calculator.riskPercent = 50;
        expect(calculator.isValid, equals(false));
      });

      test('becomes valid with account size and risk amount set', () {
        calculator
          ..accountSize = 5000
          ..instrumentPairRate = 1
          ..riskAmount = 50;

        expect(calculator.isValid, equals(true));
      });

      test('is valid when account size and risk percent are set', () {
        calculator
          ..accountSize = 5000
          ..instrumentPairRate = 1
          ..riskPercent = 0.05;

        expect(calculator.isValid, equals(true));
      });

      test('stays invalid with incorrect risk percent', () {
        calculator
          ..accountSize = 5000
          ..instrumentPairRate = 1
          ..riskPercent = 1.15;

        expect(calculator.isValid, equals(false));

        calculator
          ..accountSize = 5000
          ..instrumentPairRate = 1
          ..riskPercent = 0;

        expect(calculator.isValid, equals(false));
      });

      test('remains invalid when risk amount exceeds account size', () {
        calculator
          ..accountSize = 5000
          ..instrumentPairRate = 1
          ..riskAmount = 10000;
        expect(calculator.isValid, equals(false));
      });

      test('is valid with risk amount, stop loss, and account size set', () {
        calculator
          ..accountSize = 5000
          ..riskAmount = 100
          ..stopLossPips = 20
          ..instrumentPairRate = 1;

        expect(calculator.isValid, equals(true));
      });
    });

    group('#setState()', () {
      test('updates calculator state with new values', () {
        calculator.setState(const MatexForexPositionSizeCalculatorState(
          accountSize: 1000,
          entryPrice: 1.05,
        ));

        expect(calculator.accountSize, equals(1000));
        expect(calculator.entryPrice, equals(1.05));
      });
    });

    group('#value()', () {
      test('should return the default value when only the account size is set',
          () {
        calculator.accountSize = 5000;

        expect(
          calculator.value(),
          equals(MatexForexPositionSizeCalculator.defaultResults),
        );
      });

      test(
          'should return the default value when only the amount at risk is set',
          () {
        calculator.riskAmount = 5000;

        expect(
          calculator.value(),
          equals(MatexForexPositionSizeCalculator.defaultResults),
        );
      });

      test(
          'should return a partial result when the account size and '
          'the risk ratio are set', () {
        calculator
          ..accountSize = 5000
          ..riskPercent = 0.05
          ..pipDecimalPlaces = 4
          ..instrumentPairRate = 1;

        final results = calculator.value();

        expect(results.amountAtRisk, equals(250));
        expect(results.riskPercent, equals(0.05));
      });

      test(
          'should return a partial result when the account size and '
          'the amount at risk are set', () {
        calculator
          ..accountSize = 5000
          ..riskAmount = 50
          ..pipDecimalPlaces = 4
          ..instrumentPairRate = 1;

        final results = calculator.value();

        expect(results.amountAtRisk, equals(50));
        expect(results.riskPercent, equals(0.01));
      });

      test(
          'should return a partial result when the account size, '
          'the entry price and the risk ratio are set', () {
        calculator
          ..accountSize = 5000
          ..riskPercent = 0.01
          ..pipDecimalPlaces = 4
          ..entryPrice = 1.02
          ..instrumentPairRate = 1;

        final results = calculator.value();

        expect(results.amountAtRisk, equals(50));
        expect(results.riskPercent, equals(0.01));
      });

      test(
          'should return a partial result when the account size, '
          'the stop loss price and the risk ratio are set', () {
        calculator
          ..accountSize = 5000
          ..riskPercent = 0.01
          ..pipDecimalPlaces = 4
          ..stopLossPrice = 1
          ..instrumentPairRate = 1;

        final results = calculator.value();

        expect(results.amountAtRisk, equals(50));
        expect(results.riskPercent, equals(0.01));
      });

      test(
          'should return a result when the account size, the stop loss price, '
          'the entry price and the risk ratio are set', () {
        calculator
          ..accountSize = 5000
          ..riskPercent = 0.01
          ..pipDecimalPlaces = 4
          ..entryPrice = 1.02
          ..stopLossPrice = 1
          ..instrumentPairRate = 1;

        final results = calculator.value();

        expect(results.amountAtRisk, equals(50));
        expect(results.riskPercent, equals(0.01));
        expect(results.stopLossPips, equals(200));
        expect(results.pipValue, equals(0.25));
        expect(results.positionSize, equals(2500));
      });
    });

    group('#pipDecimalPlaces()', () {
      test('should define the pip precision value', () {
        calculator.pipDecimalPlaces = 4;
        expect(calculator.pipDecimalPlaces, equals(4));
      });
    });

    group('#instrumentPairRate()', () {
      test('should define the exchange rate of the currency pair value', () {
        calculator.instrumentPairRate = 1.25;
        expect(calculator.instrumentPairRate, equals(1.25));
      });
    });

    group('#counterToAccountCurrencyRate()', () {
      test('should define the exchange rate from counter to account currency',
          () {
        calculator.counterToAccountCurrencyRate = 0.8;
        expect(calculator.counterToAccountCurrencyRate, equals(0.8));
      });
    });

    group('#isAccountCurrencyCounter()', () {
      test('should define if account currency is counter currency', () {
        calculator.isAccountCurrencyCounter = true;
        expect(calculator.isAccountCurrencyCounter, isTrue);
      });
    });

    group('#accountSize()', () {
      test('should set the account size value', () {
        calculator.accountSize = 5000.0;
        expect(calculator.accountSize, equals(5000.0));
      });
    });

    group('#riskAmount()', () {
      test('should set the risk amount value', () {
        calculator.riskAmount = 1000.0;
        expect(calculator.riskAmount, equals(1000.0));
      });

      test('should reset the risk ratio value', () {
        calculator.riskPercent = 0.15;
        expect(calculator.riskPercent, equals(0.15));

        calculator.riskAmount = 100;
        expect(calculator.riskAmount, equals(100));
        expect(calculator.riskPercent, equals(0));
      });
    });

    group('#entryPrice()', () {
      test('should set the entry price value', () {
        calculator.entryPrice = 1.30;
        expect(calculator.entryPrice, equals(1.30));
      });

      test('should reset the stop loss pips value', () {
        calculator.stopLossPips = 15;
        expect(calculator.stopLossPips, equals(15));

        calculator.entryPrice = 1.5;
        expect(calculator.entryPrice, equals(1.5));
        expect(calculator.stopLossPips, equals(0));
      });
    });

    group('#riskPercent()', () {
      test('should set the risk percentage value', () {
        calculator.riskPercent = 0.05;
        expect(calculator.riskPercent, equals(0.05));
      });

      test('should reset the amount at risk value', () {
        calculator.riskAmount = 100;
        expect(calculator.riskAmount, equals(100));

        calculator.riskPercent = 0.5;
        expect(calculator.riskPercent, equals(0.5));
        expect(calculator.riskAmount, equals(0));
      });
    });

    group('#stopLossPips()', () {
      test('should set the number of pips for stop loss', () {
        calculator.stopLossPips = 10;
        expect(calculator.stopLossPips, equals(10));
      });

      test('should reset the entry price value', () {
        calculator.entryPrice = 1.4;
        expect(calculator.entryPrice, equals(1.4));

        calculator.stopLossPips = 15;
        expect(calculator.stopLossPips, equals(15));
        expect(calculator.entryPrice, equals(0));
      });

      test('should reset the stop Loss price value', () {
        calculator.stopLossPrice = 1.5;
        expect(calculator.stopLossPrice, equals(1.5));

        calculator.stopLossPips = 15;
        expect(calculator.stopLossPips, equals(15));
        expect(calculator.stopLossPrice, equals(0));
      });
    });

    group('#stopLossPrice()', () {
      test('should set the stop loss price value', () {
        calculator.stopLossPrice = 1.15;
        expect(calculator.stopLossPrice, equals(1.15));
      });

      test('should reset the stop loss pips value', () {
        calculator.stopLossPips = 100;
        expect(calculator.stopLossPips, equals(100));

        calculator.stopLossPrice = 15;
        expect(calculator.stopLossPrice, equals(15));
        expect(calculator.stopLossPips, equals(0));
      });
    });
  });
}
