import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';
import 'package:matex_core/core.dart';
import 'package:tenhance/tenhance.dart';

class MatexCompoundInterestCalculator extends MatexCalculator<
    MatexCompoundInterestCalculatorState,
    MatexCompoundInterestCalculatorResults> {
  static const defaultResults = MatexCompoundInterestCalculatorResults();

  set duration(int? value) {
    setState(state.copyWith(duration: value));
  }

  int? get duration => state.duration;

  set rate(double? value) {
    setState(state.copyWith(rate: value));
  }

  double? get rate => state.rate;

  set startBalance(double? value) {
    setState(state.copyWith(startBalance: value));
  }

  double? get startBalance => state.startBalance;

  set additionalContribution(double? value) {
    setState(state.copyWith(additionalContribution: value));
  }

  double? get additionalContribution => state.additionalContribution;

  set withdrawalAmount(double? value) {
    setState(state.copyWith(withdrawalAmount: value));
  }

  double? get withdrawalAmount => state.withdrawalAmount;

  set rateFrequency(MatexFinancialFrequency? value) {
    if (value == null) return;

    if (value > state.compoundFrequency) {
      setState(state.copyWith(compoundFrequency: value));
    }

    if (value > state.contributionFrequency) {
      setState(state.copyWith(contributionFrequency: value));
    }

    if (value > state.withdrawalFrequency) {
      setState(state.copyWith(withdrawalFrequency: value));
    }

    setState(state.copyWith(rateFrequency: value));
  }

  MatexFinancialFrequency get rateFrequency => state.rateFrequency;

  set withdrawalFrequency(MatexFinancialFrequency? value) {
    if (value == null || value < state.rateFrequency) return;

    setState(state.copyWith(withdrawalFrequency: value));
  }

  MatexFinancialFrequency get withdrawalFrequency => state.withdrawalFrequency;

  set compoundFrequency(MatexFinancialFrequency? value) {
    if (value == null || value < state.rateFrequency) return;

    setState(state.copyWith(compoundFrequency: value));
  }

  MatexFinancialFrequency get compoundFrequency => state.compoundFrequency;

  set contributionFrequency(MatexFinancialFrequency? value) {
    if (value == null || value < state.rateFrequency) return;

    setState(state.copyWith(contributionFrequency: value));
  }

  MatexFinancialFrequency get contributionFrequency =>
      state.contributionFrequency;

  MatexCompoundInterestCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: compoundInterestValidators);

  @override
  MatexCompoundInterestCalculatorState initializeState() =>
      const MatexCompoundInterestCalculatorState();

  @override
  MatexCompoundInterestCalculatorState initializeDefaultState() =>
      initializeState();

  @override
  MatexCompoundInterestCalculatorResults value() {
    if (!isValid) return defaultResults;

    final results = breakdown();

    if (results.isEmpty) return defaultResults;

    return MatexCompoundInterestCalculatorResults(
      totalWithdrawals: results.last.totalWithdrawals,
      totalContributions: results.last.totalDeposits,
      rateOfReturn: _computeRateOfReturn(results),
      totalEarnings: results.last.totalEarnings,
      endBalance: results.last.endBalance,
      startBalance: startBalance!,
      breakdown: results,
    );
  }

  // Updated breakdown methods
  List<MatexCompoundInterestBreakdownEntry> breakdown() {
    final dAdditionalContribution = toDecimalOrDefault(additionalContribution);
    final dWithdrawalAmount = toDecimalOrDefault(withdrawalAmount);
    final dPrincipal = toDecimalOrDefault(startBalance);
    final dRate = toDecimalOrDefault(rate);

    final contributionPeriods = _getPeriods(contributionFrequency);
    final withdrawalPeriods = _getPeriods(withdrawalFrequency);
    final compoundPeriods = _getPeriods(compoundFrequency);
    final periods = _getPeriods(rateFrequency);

    final List<MatexCompoundInterestBreakdownEntry> breakdown = [];
    var balance = dPrincipal;
    var totalDeposits = dZero;
    var totalWithdrawals = dZero;
    var totalEarnings = dZero;
    var pendingEarnings = dZero;

    for (int period = 1; period <= periods; period++) {
      final startBalance = balance;
      final earnings = startBalance * dRate;
      var deposit = dZero;
      var withdrawal = dZero;

      // Handle deposits
      if (period % (periods / contributionPeriods) == 0) {
        deposit = dAdditionalContribution;
      }

      // Handle withdrawals
      if (period % (periods / withdrawalPeriods) == 0) {
        // Check if the withdrawal amount is greater than the current balance
        if (dWithdrawalAmount <= balance + earnings + deposit) {
          withdrawal = dWithdrawalAmount;
        } else {
          // If withdrawal amount is too high, only withdraw up to
          // the available balance
          withdrawal = balance + earnings + deposit;
        }
      }

      // Apply compound interest
      if (period % (periods / compoundPeriods) == 0) {
        balance += pendingEarnings + earnings;
        pendingEarnings = dZero;
      } else {
        pendingEarnings += earnings;
      }

      balance += deposit - withdrawal;
      // Prevent balance from going negative
      balance = balance < dZero ? dZero : balance;

      totalDeposits += deposit;
      totalWithdrawals += withdrawal;
      totalEarnings += earnings;

      final entry = MatexCompoundInterestBreakdownEntry(
        totalEarnings: totalEarnings.toSafeDouble(),
        earnings: earnings.toSafeDouble(),
        startBalance: startBalance.toSafeDouble(),
        endBalance: balance.toSafeDouble(),
        totalDeposits: totalDeposits.toSafeDouble(),
        deposit: deposit.toSafeDouble(),
        totalWithdrawals: totalWithdrawals.toSafeDouble(),
        withdrawal: withdrawal.toSafeDouble(),
        period: period,
      );

      breakdown.add(entry);
    }

    return breakdown;
  }

  int _getPeriodsPerYear(MatexFinancialFrequency frequency) {
    switch (frequency) {
      case MatexFinancialFrequency.daily:
        return 365;
      case MatexFinancialFrequency.weekly:
        return 52;
      case MatexFinancialFrequency.monthly:
        return 12;
      case MatexFinancialFrequency.quarterly:
        return 4;
      case MatexFinancialFrequency.semiAnnually:
        return 2;
      case MatexFinancialFrequency.annually:
        return 1;
      default:
        return 0;
    }
  }

  int _getPeriods(MatexFinancialFrequency frequency) {
    final periodsPerYear = _getPeriodsPerYear(frequency);
    final years = duration ?? 0;
    int periods;

    switch (frequency) {
      case MatexFinancialFrequency.daily:
        periods = periodsPerYear * years;
      case MatexFinancialFrequency.weekly:
        periods = periodsPerYear * years;
      case MatexFinancialFrequency.monthly:
        periods = periodsPerYear * years;
      case MatexFinancialFrequency.quarterly:
        periods = periodsPerYear * years;
      case MatexFinancialFrequency.semiAnnually:
        periods = periodsPerYear * years;
      case MatexFinancialFrequency.annually:
        periods = periodsPerYear * years;
    }

    return periods;
  }

  double _computeRateOfReturn(
    List<MatexCompoundInterestBreakdownEntry> breakdown,
  ) {
    if (startBalance == null || startBalance == 0 || !isValid) return 0.0;

    final endBalance = breakdown.last.endBalance;
    final initialBalance = startBalance!;
    final rateOfReturn = (endBalance - initialBalance) / initialBalance;

    return rateOfReturn;
  }
}
