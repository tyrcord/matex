import 'package:flutter_test/flutter_test.dart';
import 'package:matex_financial/financial.dart';

void main() {
  group('MatexDividendPayoutRatioCalculator', () {
    late MatexDividendPayoutRatioCalculator calculator;

    setUp(() {
      calculator = MatexDividendPayoutRatioCalculator();
    });

    group('#isDirty', () {
      test('should return false as default state', () {
        expect(
          calculator.isDirty,
          isFalse,
          reason: "Initial state should not be dirty",
        );

        expect(
          calculator.value(),
          equals(MatexDividendPayoutRatioCalculator.defaultResults),
          reason: "Initial value should match default results",
        );
      });

      test('should be true after state modification', () {
        calculator.netIncome = 1000000;
        expect(
          calculator.isDirty,
          isTrue,
          reason: "Modifying state should mark calculator as dirty",
        );
      });

      test('should return to false after reset', () {
        calculator
          ..netIncome = 1000000
          ..reset();

        expect(
          calculator.isDirty,
          isFalse,
          reason: "Resetting calculator should clean dirty state",
        );
      });
    });

    group('#value()', () {
      test('should return default values initially', () {
        expect(
          calculator.value(),
          equals(MatexDividendPayoutRatioCalculator.defaultResults),
          reason: "Initial calculator value should be default results",
        );
      });
    });

    group('#netIncome()', () {
      test('should calculate correct payout ratio with given net income', () {
        calculator
          ..netIncome = 1000000
          ..totalDividends = 500000;

        var results = calculator.value();

        expect(
          results.dividendPayoutRatio,
          equals(0.5),
          reason: "Payout ratio should be 0.5 for given inputs",
        );

        calculator.netIncome = 750000;
        results = calculator.value();

        expect(
          results.dividendPayoutRatio,
          closeTo(0.67, 0.01),
          reason: "Payout ratio should be approximately 0.67 "
              "for updated net income",
        );
      });
    });

    group('#totalDividend()', () {
      test('should calculate correct payout ratio with given total dividend',
          () {
        calculator
          ..netIncome = 1000000
          ..totalDividends = 500000;

        var results = calculator.value();

        expect(
          results.dividendPayoutRatio,
          equals(0.5),
          reason: "Payout ratio should be 0.5 for given dividend",
        );

        calculator.totalDividends = 600000;
        results = calculator.value();

        expect(
          results.dividendPayoutRatio,
          equals(0.6),
          reason: "Payout ratio should be 0.6 for updated dividend amount",
        );
      });
    });

    group('#reset()', () {
      test('should revert calculator to default state', () {
        calculator
          ..netIncome = 1000000
          ..reset();

        expect(
          calculator.value(),
          equals(MatexDividendPayoutRatioCalculator.defaultResults),
          reason: "Reset should revert calculator to initial default state",
        );
      });
    });
  });
}
