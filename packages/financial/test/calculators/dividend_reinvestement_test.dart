import 'package:flutter_test/flutter_test.dart';
import 'package:matex_financial/financial.dart';

void main() {
  group('MatexDividendReinvestmentCalculator', () {
    late MatexDividendReinvestmentCalculator calculator;

    setUp(() {
      calculator = MatexDividendReinvestmentCalculator();
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
          equals(MatexDividendReinvestmentCalculator.defaultResults),
          reason: "Initial value should match default results",
        );
      });

      test('should be true after state modification', () {
        calculator.sharePrice = 100;
        expect(
          calculator.isDirty,
          isTrue,
          reason: "Modifying state should mark calculator as dirty",
        );
      });

      test(
        'should return false when a calculator state property '
        'has been reset to its default\'s value',
        () {
          calculator.dividendPaymentFrequency = MatexFinancialFrequency.monthly;

          expect(
            calculator.isDirty,
            isTrue,
            reason: "Modifying state should mark calculator as dirty",
          );

          calculator.dividendPaymentFrequency =
              MatexFinancialFrequency.annually;

          expect(calculator.isDirty, isFalse);
        },
      );

      test('should return to false after reset', () {
        calculator
          ..sharePrice = 1000000
          ..reset();

        expect(
          calculator.isDirty,
          isFalse,
          reason: "Resetting calculator should clean dirty state",
        );
      });
    });

    group('#value()', () {
      test('should return the default results', () {
        expect(
          calculator.value(),
          equals(MatexDividendReinvestmentCalculator.defaultResults),
          reason: "Initial value should match default results",
        );
      });
    });

    group('#annualContribution()', () {
      test('Should return proper results when set to annually', () {
        calculator
          ..dividendPaymentFrequency = MatexFinancialFrequency.annually
          ..drip = true
          ..sharePrice = 100
          ..numberOfShares = 10
          ..dividendYield = 10
          ..yearsToGrow = 2
          ..annualContribution = 100;

        var results = calculator.value();

        expect(results.netDividendPaid, closeTo(220, 0.01));
        expect(results.numberOfShares, closeTo(14.2, 0.01));
        expect(results.endingBalance, closeTo(1420, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(174.40, 0.01));
        expect(results.numberOfShares, closeTo(13.74, 0.01));
        expect(results.endingBalance, closeTo(1374.4, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 0
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(210, 0.01));
        expect(results.numberOfShares, closeTo(12, 0.01));
        expect(results.endingBalance, closeTo(1410, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 20
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(168.00, 0.01));
        expect(results.numberOfShares, closeTo(12, 0.01));
        expect(results.endingBalance, closeTo(1368.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));
      });

      test('Should return proper results when set to semi-annually', () {
        calculator
          ..dividendPaymentFrequency = MatexFinancialFrequency.semiAnnually
          ..drip = true
          ..sharePrice = 100
          ..numberOfShares = 10
          ..dividendYield = 10
          ..yearsToGrow = 2
          ..annualContribution = 100;

        var results = calculator.value();

        expect(results.netDividendPaid, closeTo(225.76, 0.01));
        expect(results.numberOfShares, closeTo(14.26, 0.01));
        expect(results.endingBalance, closeTo(1425.76, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(178.02, 0.01));
        expect(results.numberOfShares, closeTo(13.78, 0.01));
        expect(results.endingBalance, closeTo(1378.02, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 0
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(210, 0.01));
        expect(results.numberOfShares, closeTo(12, 0.01));
        expect(results.endingBalance, closeTo(1410, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 20
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(168.00, 0.01));
        expect(results.numberOfShares, closeTo(12, 0.01));
        expect(results.endingBalance, closeTo(1368.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));
      });

      test('Should return proper results when set to quarterly', () {
        calculator
          ..dividendPaymentFrequency = MatexFinancialFrequency.quarterly
          ..drip = true
          ..sharePrice = 100
          ..numberOfShares = 10
          ..dividendYield = 10
          ..yearsToGrow = 2
          ..annualContribution = 100;

        var results = calculator.value();

        expect(results.netDividendPaid, closeTo(228.78, 0.01));
        expect(results.numberOfShares, closeTo(14.29, 0.01));
        expect(results.endingBalance, closeTo(1428.78, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(179.90, 0.01));
        expect(results.numberOfShares, closeTo(13.80, 0.01));
        expect(results.endingBalance, closeTo(1379.90, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 0
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(210, 0.01));
        expect(results.numberOfShares, closeTo(12, 0.01));
        expect(results.endingBalance, closeTo(1410, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 20
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(168.00, 0.01));
        expect(results.numberOfShares, closeTo(12, 0.01));
        expect(results.endingBalance, closeTo(1368.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));
      });

      test('Should return proper results when set to monthly', () {
        calculator
          ..dividendPaymentFrequency = MatexFinancialFrequency.monthly
          ..drip = true
          ..sharePrice = 100
          ..numberOfShares = 10
          ..dividendYield = 10
          ..yearsToGrow = 2
          ..annualContribution = 100;

        var results = calculator.value();

        expect(results.netDividendPaid, closeTo(230.86, 0.01));
        expect(results.numberOfShares, closeTo(14.31, 0.01));
        expect(results.endingBalance, closeTo(1430.86, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(181.19, 0.01));
        expect(results.numberOfShares, closeTo(13.81, 0.01));
        expect(results.endingBalance, closeTo(1381.19, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 0
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(210, 0.01));
        expect(results.numberOfShares, closeTo(12, 0.01));
        expect(results.endingBalance, closeTo(1410, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 20
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(168.00, 0.01));
        expect(results.numberOfShares, closeTo(12, 0.01));
        expect(results.endingBalance, closeTo(1368.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));
      });
    });

    group('#dividendPaymentFrequency()', () {
      test('Should return proper results when set to annually', () {
        calculator
          ..dividendPaymentFrequency = MatexFinancialFrequency.annually
          ..drip = true
          ..sharePrice = 100
          ..numberOfShares = 10
          ..dividendYield = 10
          ..yearsToGrow = 2;

        var results = calculator.value();

        expect(results.netDividendPaid, closeTo(210.00, 0.01));
        expect(results.numberOfShares, closeTo(12.10, 0.01));
        expect(results.endingBalance, closeTo(1210.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(166.40, 0.01));
        expect(results.numberOfShares, closeTo(11.66, 0.01));
        expect(results.endingBalance, closeTo(1166.40, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 0
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(200.00, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1200.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 20
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(160.00, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1160.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));
      });

      test('Should return proper results when set to semi-annually', () {
        calculator
          ..dividendPaymentFrequency = MatexFinancialFrequency.semiAnnually
          ..drip = true
          ..sharePrice = 100
          ..numberOfShares = 10
          ..dividendYield = 10
          ..yearsToGrow = 2;

        var results = calculator.value();

        expect(results.netDividendPaid, closeTo(215.51, 0.01));
        expect(results.numberOfShares, closeTo(12.16, 0.01));
        expect(results.endingBalance, closeTo(1215.51, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(169.86, 0.01));
        expect(results.numberOfShares, closeTo(11.70, 0.01));
        expect(results.endingBalance, closeTo(1169.86, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 0
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(200.00, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1200.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 20
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(160.00, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1160.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));
      });

      test('Should return proper results when set to quarterly', () {
        calculator
          ..dividendPaymentFrequency = MatexFinancialFrequency.quarterly
          ..drip = true
          ..sharePrice = 100
          ..numberOfShares = 10
          ..dividendYield = 10
          ..yearsToGrow = 2;

        var results = calculator.value();

        expect(results.netDividendPaid, closeTo(218.40, 0.01));
        expect(results.numberOfShares, closeTo(12.18, 0.01));
        expect(results.endingBalance, closeTo(1218.40, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(171.66, 0.01));
        expect(results.numberOfShares, closeTo(11.72, 0.01));
        expect(results.endingBalance, closeTo(1171.66, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 0
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(200.00, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1200.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 20
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(160.00, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1160.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));
      });

      test('Should return proper results when set to monthly', () {
        calculator
          ..dividendPaymentFrequency = MatexFinancialFrequency.monthly
          ..drip = true
          ..sharePrice = 100
          ..numberOfShares = 10
          ..dividendYield = 10
          ..yearsToGrow = 2;

        var results = calculator.value();

        expect(results.netDividendPaid, closeTo(220.39, 0.01));
        expect(results.numberOfShares, closeTo(12.20, 0.01));
        expect(results.endingBalance, closeTo(1220.39, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(172.89, 0.01));
        expect(results.numberOfShares, closeTo(11.73, 0.01));
        expect(results.endingBalance, closeTo(1172.89, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 0
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(200.00, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1200.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 20
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(160.00, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1160.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));
      });
    });

    group('#annualSharePriceIncrease()', () {
      test('Should return proper results when set to annually', () {
        calculator
          ..dividendPaymentFrequency = MatexFinancialFrequency.annually
          ..drip = true
          ..sharePrice = 100
          ..numberOfShares = 10
          ..dividendYield = 10
          ..yearsToGrow = 2
          ..annualSharePriceIncrease = 10;

        var results = calculator.value();

        expect(results.netDividendPaid, closeTo(209.09, 0.01));
        expect(results.numberOfShares, closeTo(11.81, 0.01));
        expect(results.endingBalance, closeTo(1429.09, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(165.82, 0.01));
        expect(results.numberOfShares, closeTo(11.44, 0.01));
        expect(results.endingBalance, closeTo(1383.82, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 0
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(200.0, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1410.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(160.0, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1370.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        // TODO: add bellow tests to different frequencies
        // once the calculator is done

        calculator
          ..annualContribution = 100
          ..drip = true
          ..taxRate = 0;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(218.18, 0.01));
        expect(results.numberOfShares, closeTo(13.62, 0.01));
        expect(results.endingBalance, closeTo(1648.18, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(209.09, 0.01));
        expect(results.numberOfShares, closeTo(11.74, 0.01));
        expect(results.endingBalance, closeTo(1629.09, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(167.27, 0.01));
        expect(results.numberOfShares, closeTo(11.74, 0.01));
        expect(results.endingBalance, closeTo(1587.27, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 20
          ..drip = true;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(173.09, 0.01));
        expect(results.numberOfShares, closeTo(13.23, 0.01));
        expect(results.endingBalance, closeTo(1601.09, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));
      });

      test('Should return proper results when set to semi-annually', () {
        calculator
          ..dividendPaymentFrequency = MatexFinancialFrequency.semiAnnually
          ..drip = true
          ..sharePrice = 100
          ..numberOfShares = 10
          ..dividendYield = 10
          ..yearsToGrow = 2
          ..annualSharePriceIncrease = 10;

        var results = calculator.value();

        expect(results.netDividendPaid, closeTo(214.28, 0.01));
        expect(results.numberOfShares, closeTo(11.90, 0.01));
        expect(results.endingBalance, closeTo(1439.74, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(169.08, 0.01));
        expect(results.numberOfShares, closeTo(11.50, 0.01));
        expect(results.endingBalance, closeTo(1391.38, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 0
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(200.0, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1410.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(160.0, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1370.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));
      });

      test('Should return proper results when set to quarterly', () {
        calculator
          ..dividendPaymentFrequency = MatexFinancialFrequency.quarterly
          ..drip = true
          ..sharePrice = 100
          ..numberOfShares = 10
          ..dividendYield = 10
          ..yearsToGrow = 2
          ..annualSharePriceIncrease = 10;

        var results = calculator.value();

        expect(results.netDividendPaid, closeTo(217.06, 0.01));
        expect(results.numberOfShares, closeTo(11.95, 0.01));
        expect(results.endingBalance, closeTo(1445.46, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(170.82, 0.01));
        expect(results.numberOfShares, closeTo(11.53, 0.01));
        expect(results.endingBalance, closeTo(1395.40, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 0
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(200.0, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1410.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(160.0, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1370.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));
      });

      test('Should return proper results when set to monthly', () {
        calculator
          ..dividendPaymentFrequency = MatexFinancialFrequency.monthly
          ..drip = true
          ..sharePrice = 100
          ..numberOfShares = 10
          ..dividendYield = 10
          ..yearsToGrow = 2
          ..annualSharePriceIncrease = 10;

        var results = calculator.value();

        expect(results.netDividendPaid, closeTo(218.99, 0.01));
        expect(results.numberOfShares, closeTo(11.98, 0.01));
        expect(results.endingBalance, closeTo(1449.43, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(172.02, 0.01));
        expect(results.numberOfShares, closeTo(11.56, 0.01));
        expect(results.endingBalance, closeTo(1398.18, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..taxRate = 0
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(200.0, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1410.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(160.0, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1370.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));
      });
    });

    group('#annualDividendIncrease()', () {
      test('Should return proper results when set to annually', () {
        calculator
          ..dividendPaymentFrequency = MatexFinancialFrequency.annually
          ..drip = true
          ..sharePrice = 100
          ..numberOfShares = 10
          ..dividendYield = 10
          ..yearsToGrow = 2
          ..annualDividendIncrease = 10;

        var results = calculator.value();

        expect(results.netDividendPaid, closeTo(221.00, 0.01));
        expect(results.numberOfShares, closeTo(12.21, 0.01));
        expect(results.endingBalance, closeTo(1221.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.annualContribution = 100;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(232.00, 0.01));
        expect(results.numberOfShares, closeTo(14.32, 0.01));
        expect(results.endingBalance, closeTo(1432.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..annualContribution = 0
          ..taxRate = 20;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(175.04, 0.01));
        expect(results.numberOfShares, closeTo(11.75, 0.01));
        expect(results.endingBalance, closeTo(1175.04, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..annualSharePriceIncrease = 10
          ..taxRate = 0;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(220, 0.01));
        expect(results.numberOfShares, closeTo(11.90, 0.01));
        expect(results.endingBalance, closeTo(1440, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..annualSharePriceIncrease = 0
          ..taxRate = 20
          ..annualContribution = 100;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(183.84, 0.01));
        expect(results.numberOfShares, closeTo(13.84, 0.01));
        expect(results.endingBalance, closeTo(1383.84, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..annualContribution = 0
          ..taxRate = 0
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(210.0, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1210.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(168.00, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1168.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));
      });

      test('Should return proper results when set to semi-annually', () {
        calculator
          ..dividendPaymentFrequency = MatexFinancialFrequency.semiAnnually
          ..drip = true
          ..sharePrice = 100
          ..numberOfShares = 10
          ..dividendYield = 10
          ..yearsToGrow = 2
          ..annualDividendIncrease = 10;

        var results = calculator.value();

        expect(results.netDividendPaid, closeTo(227.11, 0.01));
        expect(results.numberOfShares, closeTo(12.27, 0.01));
        expect(results.endingBalance, closeTo(1227.11, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.annualContribution = 100;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(238.41, 0.01));
        expect(results.numberOfShares, closeTo(14.38, 0.01));
        expect(results.endingBalance, closeTo(1438.41, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..annualContribution = 0
          ..taxRate = 20;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(178.87, 0.01));
        expect(results.numberOfShares, closeTo(11.79, 0.01));
        expect(results.endingBalance, closeTo(1178.87, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..annualSharePriceIncrease = 10
          ..taxRate = 0;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(225.73, 0.01));
        expect(results.numberOfShares, closeTo(12.00, 0.01));
        expect(results.endingBalance, closeTo(1451.45, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..annualSharePriceIncrease = 0
          ..taxRate = 20
          ..annualContribution = 100;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(187.87, 0.01));
        expect(results.numberOfShares, closeTo(13.88, 0.01));
        expect(results.endingBalance, closeTo(1387.87, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..annualContribution = 0
          ..taxRate = 0
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(210.0, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1210.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(168.00, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1168.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));
      });

      test('Should return proper results when set to quarterly', () {
        calculator
          ..dividendPaymentFrequency = MatexFinancialFrequency.quarterly
          ..drip = true
          ..sharePrice = 100
          ..numberOfShares = 10
          ..dividendYield = 10
          ..yearsToGrow = 2
          ..annualDividendIncrease = 10;

        var results = calculator.value();

        expect(results.netDividendPaid, closeTo(230.33, 0.01));
        expect(results.numberOfShares, closeTo(12.30, 0.01));
        expect(results.endingBalance, closeTo(1230.33, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.annualContribution = 100;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(241.80, 0.01));
        expect(results.numberOfShares, closeTo(14.42, 0.01));
        expect(results.endingBalance, closeTo(1441.80, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..annualContribution = 0
          ..taxRate = 20;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(180.88, 0.01));
        expect(results.numberOfShares, closeTo(11.81, 0.01));
        expect(results.endingBalance, closeTo(1180.88, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..annualSharePriceIncrease = 10
          ..taxRate = 0;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(228.81, 0.01));
        expect(results.numberOfShares, closeTo(12.05, 0.01));
        expect(results.endingBalance, closeTo(1457.61, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..annualSharePriceIncrease = 0
          ..taxRate = 20
          ..annualContribution = 100;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(189.97, 0.01));
        expect(results.numberOfShares, closeTo(13.90, 0.01));
        expect(results.endingBalance, closeTo(1389.97, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..annualContribution = 0
          ..taxRate = 0
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(210.0, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1210.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(168.00, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1168.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));
      });

      test('Should return proper results when set to monthly', () {
        calculator
          ..dividendPaymentFrequency = MatexFinancialFrequency.monthly
          ..drip = true
          ..sharePrice = 100
          ..numberOfShares = 10
          ..dividendYield = 10
          ..yearsToGrow = 2
          ..annualDividendIncrease = 10;

        var results = calculator.value();

        expect(results.netDividendPaid, closeTo(232.55, 0.01));
        expect(results.numberOfShares, closeTo(12.33, 0.01));
        expect(results.endingBalance, closeTo(1232.55, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.annualContribution = 100;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(244.12, 0.01));
        expect(results.numberOfShares, closeTo(14.44, 0.01));
        expect(results.endingBalance, closeTo(1444.12, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..annualContribution = 0
          ..taxRate = 20;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(182.24, 0.01));
        expect(results.numberOfShares, closeTo(11.82, 0.01));
        expect(results.endingBalance, closeTo(1182.24, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..annualSharePriceIncrease = 10
          ..taxRate = 0;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(230.95, 0.01));
        expect(results.numberOfShares, closeTo(12.08, 0.01));
        expect(results.endingBalance, closeTo(1461.90, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..annualSharePriceIncrease = 0
          ..taxRate = 20
          ..annualContribution = 100;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(191.41, 0.01));
        expect(results.numberOfShares, closeTo(13.91, 0.01));
        expect(results.endingBalance, closeTo(1391.41, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator
          ..annualContribution = 0
          ..taxRate = 0
          ..drip = false;

        results = calculator.value();

        expect(results.netDividendPaid, closeTo(210.0, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1210.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));

        calculator.taxRate = 20;
        results = calculator.value();

        expect(results.netDividendPaid, closeTo(168.00, 0.01));
        expect(results.numberOfShares, closeTo(10, 0.01));
        expect(results.endingBalance, closeTo(1168.00, 0.01));
        expect(results.reports?.length, closeTo(2, 0.01));
      });
    });

    group('#reset()', () {
      test('should reset the calculator', () {
        calculator
          ..dividendPaymentFrequency = MatexFinancialFrequency.quarterly
          ..reset();

        final results = calculator.value();

        expect(
          results,
          equals(MatexDividendReinvestmentCalculator.defaultResults),
        );
      });
    });
  });
}
