// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

void main() {
  group('CompoundInterestCalculator', () {
    test('Calculates daily compounded amount correctly', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          startBalance: 10000,
          rateFrequency: MatexFinancialFrequency.daily,
          compoundFrequency: MatexFinancialFrequency.daily,
          rate: 0.001,
          duration: 1,
        ),
      );

      final results = await calculator.valueAsync();

      expect(results.endBalance, closeTo(14402.51, 0.01));
    });

    test('Calculates weekly compounded amount correctly', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          startBalance: 10000,
          rateFrequency: MatexFinancialFrequency.weekly,
          compoundFrequency: MatexFinancialFrequency.weekly,
          rate: 0.005,
          duration: 1,
        ),
      );

      final results = await calculator.valueAsync();

      expect(results.endBalance, closeTo(12960.90, 0.01));
    });

    test('Calculates monthly compounded amount correctly', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          startBalance: 10000,
          rateFrequency: MatexFinancialFrequency.monthly,
          compoundFrequency: MatexFinancialFrequency.monthly,
          rate: 0.05,
          duration: 2,
        ),
      );

      final results = await calculator.valueAsync();

      expect(results.endBalance, closeTo(32251.00, 0.01));
      expect(results.totalEarnings, closeTo(22251.00, 0.01));
      expect(results.rateOfReturn, closeTo(2.2251, 0.0001));
    });

    test(
        'Calculates monthly compounded amount with '
        'monthly contributions correctly', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          contributionFrequency: MatexFinancialFrequency.monthly,
          compoundFrequency: MatexFinancialFrequency.monthly,
          rateFrequency: MatexFinancialFrequency.monthly,
          additionalContribution: 300.0,
          startBalance: 1000.0,
          duration: 5,
          rate: 0.02,
        ),
      );

      final results = await calculator.valueAsync();
      final last = results.breakdown!.last;

      expect(last.endBalance, closeTo(37496.49, 0.01));
      expect(last.totalEarnings, closeTo(18496.49, 0.01));
      expect(last.earnings, closeTo(729.34, 0.01));
      expect(last.deposit, closeTo(300, 0.01));
      expect(last.totalDeposits, closeTo(18000, 0.01));
    });

    test(
        'Calculates monthly compounded amount with '
        'monthly withdrawal correctly', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          withdrawalFrequency: MatexFinancialFrequency.monthly,
          compoundFrequency: MatexFinancialFrequency.monthly,
          rateFrequency: MatexFinancialFrequency.monthly,
          withdrawalAmount: 100.0,
          startBalance: 10000.0,
          duration: 5,
          rate: 0.02,
        ),
      );

      final results = await calculator.valueAsync();
      final last = results.breakdown!.last;

      expect(last.endBalance, closeTo(21405.15, 0.01));
      expect(last.totalEarnings, closeTo(17405.15, 0.01));
      expect(last.earnings, closeTo(421.67, 0.01));
      expect(last.deposit, closeTo(0, 0.01));
      expect(last.withdrawal, closeTo(100, 0.01));
      expect(last.totalWithdrawals, closeTo(6000, 0.01));
      expect(results.rateOfReturn, closeTo(1.1405, 0.0001));
    });

    test(
        'Calculates monthly compounded amount with '
        'quarterly contributions correctly', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          contributionFrequency: MatexFinancialFrequency.quarterly,
          compoundFrequency: MatexFinancialFrequency.monthly,
          rateFrequency: MatexFinancialFrequency.monthly,
          additionalContribution: 300.0,
          startBalance: 1000.0,
          duration: 5,
          rate: 0.02,
        ),
      );

      final results = await calculator.valueAsync();

      expect(results.endBalance, closeTo(14461.09, 0.01));
    });

    test(
        'Calculates monthly compounded amount with '
        'semi-annually contributions correctly', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          contributionFrequency: MatexFinancialFrequency.semiAnnually,
          compoundFrequency: MatexFinancialFrequency.monthly,
          rateFrequency: MatexFinancialFrequency.monthly,
          additionalContribution: 300.0,
          startBalance: 1000.0,
          duration: 5,
          rate: 0.02,
        ),
      );

      final results = await calculator.valueAsync();

      expect(results.endBalance, closeTo(8705.06, 0.01));
    });

    test(
        'Calculates monthly compounded amount with '
        'annually contributions correctly', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          contributionFrequency: MatexFinancialFrequency.annually,
          compoundFrequency: MatexFinancialFrequency.monthly,
          rateFrequency: MatexFinancialFrequency.monthly,
          additionalContribution: 300.0,
          startBalance: 1000.0,
          duration: 5,
          rate: 0.02,
        ),
      );

      final results = await calculator.valueAsync();

      expect(results.endBalance, closeTo(5832.12, 0.01));
    });

    test('Calculates quarterly compounded amount correctly', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          startBalance: 10000,
          rateFrequency: MatexFinancialFrequency.quarterly,
          compoundFrequency: MatexFinancialFrequency.quarterly,
          rate: 0.005,
          duration: 1,
        ),
      );

      final results = await calculator.valueAsync();

      expect(results.endBalance, closeTo(10201.51, 0.01));
    });

    test(
        'Calculates quarterly compounded amount with '
        'quarterly contributions correctly', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          contributionFrequency: MatexFinancialFrequency.quarterly,
          compoundFrequency: MatexFinancialFrequency.quarterly,
          rateFrequency: MatexFinancialFrequency.quarterly,
          additionalContribution: 300.0,
          startBalance: 1000.0,
          duration: 5,
          rate: 0.02,
        ),
      );

      final results = await calculator.valueAsync();

      expect(results.endBalance, closeTo(8775.16, 0.01));
    });

    test(
        'Calculates quarterly compounded amount with '
        'semi-annually contributions correctly', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          contributionFrequency: MatexFinancialFrequency.semiAnnually,
          compoundFrequency: MatexFinancialFrequency.quarterly,
          rateFrequency: MatexFinancialFrequency.quarterly,
          additionalContribution: 300.0,
          startBalance: 1000.0,
          duration: 5,
          rate: 0.02,
        ),
      );

      final results = await calculator.valueAsync();

      expect(results.endBalance, closeTo(5094.47, 0.01));
    });

    test(
        'Calculates quarterly compounded amount with '
        'annually contributions correctly', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          contributionFrequency: MatexFinancialFrequency.annually,
          compoundFrequency: MatexFinancialFrequency.quarterly,
          rateFrequency: MatexFinancialFrequency.quarterly,
          additionalContribution: 300.0,
          startBalance: 1000.0,
          duration: 5,
          rate: 0.02,
        ),
      );

      final results = await calculator.valueAsync();

      expect(results.endBalance, closeTo(3254.48, 0.01));
    });

    test(
        'Calculates quartely compounded amount with '
        'monlty interest correctly', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          contributionFrequency: MatexFinancialFrequency.annually,
          compoundFrequency: MatexFinancialFrequency.quarterly,
          rateFrequency: MatexFinancialFrequency.monthly,
          startBalance: 1000.0,
          duration: 2,
          rate: 0.02,
        ),
      );

      final results = await calculator.valueAsync();

      expect(results.endBalance, closeTo(1593.85, 0.01));
    });

    test('Calculates semi-annually compounded amount correctly', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          startBalance: 10000,
          rateFrequency: MatexFinancialFrequency.semiAnnually,
          compoundFrequency: MatexFinancialFrequency.semiAnnually,
          rate: 0.02,
          duration: 3,
        ),
      );

      final results = await calculator.valueAsync();

      expect(results.endBalance, closeTo(11261.62, 0.01));
    });

    test(
        'Calculates semi-annually compounded amount with '
        'semi-annually contributions correctly', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          contributionFrequency: MatexFinancialFrequency.semiAnnually,
          compoundFrequency: MatexFinancialFrequency.semiAnnually,
          rateFrequency: MatexFinancialFrequency.semiAnnually,
          additionalContribution: 300.0,
          startBalance: 1000.0,
          duration: 5,
          rate: 0.02,
        ),
      );

      final results = await calculator.valueAsync();

      expect(results.endBalance, closeTo(4503.91, 0.01));
    });

    test(
        'Calculates semi-annually compounded amount with '
        'annually contributions correctly', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          contributionFrequency: MatexFinancialFrequency.annually,
          compoundFrequency: MatexFinancialFrequency.semiAnnually,
          rateFrequency: MatexFinancialFrequency.semiAnnually,
          additionalContribution: 300.0,
          startBalance: 1000.0,
          duration: 5,
          rate: 0.02,
        ),
      );

      final results = await calculator.valueAsync();

      expect(results.endBalance, closeTo(2845.191, 0.01));
    });

    test('Calculates annually compounded amount correctly', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          startBalance: 10000,
          rateFrequency: MatexFinancialFrequency.annually,
          compoundFrequency: MatexFinancialFrequency.annually,
          rate: 0.05,
          duration: 2,
        ),
      );

      final results = await calculator.valueAsync();

      expect(results.endBalance, closeTo(11025, 0.01));
    });

    test(
        'Calculates annually compounded amount with '
        'annually contributions correctly', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          contributionFrequency: MatexFinancialFrequency.annually,
          compoundFrequency: MatexFinancialFrequency.annually,
          rateFrequency: MatexFinancialFrequency.annually,
          additionalContribution: 300.0,
          startBalance: 1000.0,
          duration: 5,
          rate: 0.02,
        ),
      );

      final results = await calculator.valueAsync();

      expect(results.endBalance, closeTo(2665.29, 0.01));
    });

    test('Provides correct daily breakdown', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          compoundFrequency: MatexFinancialFrequency.daily,
          rateFrequency: MatexFinancialFrequency.daily,
          startBalance: 10000,
          rate: 0.001,
          duration: 1,
        ),
      );

      final results = await calculator.valueAsync();
      final breakdown = results.breakdown!;

      expect(breakdown.length, 365);
      expect(breakdown.first.endBalance, closeTo(10010.00, 0.01));
      expect(breakdown.last.endBalance, closeTo(14402.51, 0.01));
    });

    test('Provides correct weekly breakdown', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          compoundFrequency: MatexFinancialFrequency.weekly,
          rateFrequency: MatexFinancialFrequency.weekly,
          startBalance: 10000,
          rate: 0.005,
          duration: 1,
        ),
      );

      final results = await calculator.valueAsync();
      final breakdown = results.breakdown!;

      expect(breakdown.length, 52);
      expect(breakdown.first.endBalance, closeTo(10050.00, 0.01));
      expect(breakdown[8].endBalance, closeTo(10459.11, 0.01));
      expect(breakdown[15].endBalance, closeTo(10830.71, 0.01));
      expect(breakdown[28].endBalance, closeTo(11556.22, 0.01));
      expect(breakdown[39].endBalance, closeTo(12207.94, 0.01));
      expect(breakdown.last.endBalance, closeTo(12960.90, 0.01));
    });

    test('Provides correct monthly breakdown', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          compoundFrequency: MatexFinancialFrequency.monthly,
          rateFrequency: MatexFinancialFrequency.monthly,
          startBalance: 10000,
          rate: 0.005,
          duration: 1,
        ),
      );

      final results = await calculator.valueAsync();
      final breakdown = results.breakdown!;

      expect(breakdown.length, 12);
      expect(breakdown.first.endBalance, closeTo(10050.00, 0.01));
      expect(breakdown.last.endBalance, closeTo(10616.78, 0.01));
    });

    test('Provides correct quarterly breakdown', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          compoundFrequency: MatexFinancialFrequency.quarterly,
          rateFrequency: MatexFinancialFrequency.quarterly,
          startBalance: 10000,
          rate: 0.01,
          duration: 2,
        ),
      );

      final results = await calculator.valueAsync();
      final breakdown = results.breakdown!;

      expect(breakdown.length, 8);
      expect(breakdown.first.endBalance, closeTo(10100.00, 0.01));
      expect(breakdown[1].endBalance, closeTo(10201.00, 0.01));
      expect(breakdown[2].endBalance, closeTo(10303.01, 0.01));
      expect(breakdown[3].endBalance, closeTo(10406.04, 0.01));
      expect(breakdown[4].endBalance, closeTo(10510.10, 0.01));
      expect(breakdown[5].endBalance, closeTo(10615.20, 0.01));
      expect(breakdown[6].endBalance, closeTo(10721.35, 0.01));
      expect(breakdown.last.endBalance, closeTo(10828.57, 0.01));
    });

    test('Provides correct semi-annually breakdown', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          compoundFrequency: MatexFinancialFrequency.semiAnnually,
          rateFrequency: MatexFinancialFrequency.semiAnnually,
          startBalance: 10000,
          rate: 0.02,
          duration: 3,
        ),
      );

      final results = await calculator.valueAsync();
      final breakdown = results.breakdown!;

      expect(breakdown.length, 6);
      expect(breakdown.first.endBalance, closeTo(10200.00, 0.01));
      expect(breakdown[1].endBalance, closeTo(10404.00, 0.01));
      expect(breakdown[2].endBalance, closeTo(10612.08, 0.01));
      expect(breakdown[3].endBalance, closeTo(10824.32, 0.01));
      expect(breakdown[4].endBalance, closeTo(11040.81, 0.01));
      expect(breakdown.last.endBalance, closeTo(11261.62, 0.01));
    });

    test('Provides correct annually breakdown', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          compoundFrequency: MatexFinancialFrequency.annually,
          rateFrequency: MatexFinancialFrequency.annually,
          startBalance: 10000,
          rate: 0.05,
          duration: 5,
        ),
      );

      final results = await calculator.valueAsync();
      final breakdown = results.breakdown!;

      expect(breakdown.length, 5);
      expect(breakdown.first.endBalance, closeTo(10500.00, 0.01));
      expect(breakdown[1].endBalance, closeTo(11025, 0.01));
      expect(breakdown[2].endBalance, closeTo(11576.25, 0.01));
      expect(breakdown[3].endBalance, closeTo(12155.06, 0.01));
      expect(breakdown.last.endBalance, closeTo(12762.82, 0.01));
    });

    test('Effective Annual Rate without contributions or withdrawals',
        () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          compoundFrequency: MatexFinancialFrequency.annually,
          rateFrequency: MatexFinancialFrequency.annually,
          startBalance: 1000.0,
          rate: 0.05,
          duration: 1,
        ),
      );

      final result = await calculator.valueAsync();
      expect(result.effectiveAnnualRate, closeTo(0.05, 0.01));

      final calculator2 = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          compoundFrequency: MatexFinancialFrequency.monthly,
          rateFrequency: MatexFinancialFrequency.monthly,
          startBalance: 1000.0,
          rate: 0.02,
          duration: 10,
        ),
      );

      final result2 = await calculator2.valueAsync();
      expect(result2.effectiveAnnualRate, closeTo(0.2682, 0.0001));

      final calculator3 = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          compoundFrequency: MatexFinancialFrequency.quarterly,
          rateFrequency: MatexFinancialFrequency.monthly,
          startBalance: 1000.0,
          rate: 0.02,
          duration: 10,
        ),
      );

      final result3 = await calculator3.valueAsync();
      expect(result3.effectiveAnnualRate, closeTo(0.2625, 0.0001));
    });

    test('Effective Annual Rate with monthly contributions', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          compoundFrequency: MatexFinancialFrequency.annually,
          rateFrequency: MatexFinancialFrequency.annually,
          additionalContribution: 1000.0,
          startBalance: 1000.0,
          rate: 0.05,
          duration: 1,
        ),
      );

      final result = await calculator.valueAsync();
      expect(result.effectiveAnnualRate, closeTo(0.05, 0.01));
    });

    test('Effective Annual Rate with contributions and withdrawals', () async {
      final calculator = MatexCompoundInterestCalculator(
        state: const MatexCompoundInterestCalculatorState(
          compoundFrequency: MatexFinancialFrequency.monthly,
          rateFrequency: MatexFinancialFrequency.monthly,
          startBalance: 1000.0,
          rate: 0.02,
          duration: 1,
          additionalContribution: 100.0,
          contributionFrequency: MatexFinancialFrequency.monthly,
          withdrawalAmount: 50.0,
          withdrawalFrequency: MatexFinancialFrequency.monthly,
        ),
      );

      final result = await calculator.valueAsync();
      expect(result.effectiveAnnualRate, closeTo(0.3388, 0.0001));
    });
  });
}
