// Dart imports:
import 'dart:async';
import 'dart:math';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:matex_core/core.dart';
import 'package:tenhance/tenhance.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

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
  Future<MatexCompoundInterestCalculatorResults> valueAsync() async {
    if (!isValid) return defaultResults;

    final results = await compute(_computeBreakdown, state.toJson());

    if (results.isEmpty) return defaultResults;

    return MatexCompoundInterestCalculatorResults(
      effectiveAnnualRate: _computeEffectiveAnnualRate(results),
      totalWithdrawals: results.last.totalWithdrawals,
      totalContributions: results.last.totalDeposits,
      rateOfReturn: _computeRateOfReturn(results),
      totalEarnings: results.last.totalEarnings,
      endBalance: results.last.endBalance,
      startBalance: startBalance!,
      breakdown: results,
    );
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

  double _computeEffectiveAnnualRate(
    List<MatexCompoundInterestBreakdownEntry> breakdown,
  ) {
    if (breakdown.isEmpty) return 0.0;

    final entry = breakdown.first;
    final startBalance = entry.startBalance;
    final periods = _getPeriodsPerYear(state.rateFrequency);
    final entries = breakdown.sublist(0, periods);
    final endBalance = entries.last.endBalance;
    final effectiveAnnualRate = pow(endBalance / startBalance, 1 / 1) - 1;

    return effectiveAnnualRate.toDouble();
  }
}

// Updated breakdown methods
List<MatexCompoundInterestBreakdownEntry> _computeBreakdown(
  Map<String, dynamic> json,
) {
  final state = MatexCompoundInterestCalculatorState.fromJson(json);

  final dAdditionalContribution = state.additionalContribution ?? 0.0;
  final dWithdrawalAmount = state.withdrawalAmount ?? 0.0;
  final dPrincipal = state.startBalance ?? 0.0;
  final duration = state.duration ?? 0;
  final dRate = state.rate ?? 0.0;

  final contributionPeriods =
      _getPeriods(state.contributionFrequency, duration);
  final withdrawalPeriods = _getPeriods(state.withdrawalFrequency, duration);
  final compoundPeriods = _getPeriods(state.compoundFrequency, duration);
  final periods = _getPeriods(state.rateFrequency, duration);

  final List<MatexCompoundInterestBreakdownEntry> breakdown = [];
  var balance = dPrincipal;
  var totalDeposits = 0.0;
  var totalWithdrawals = 0.0;
  var totalEarnings = 0.0;
  var pendingEarnings = 0.0;

  for (int period = 1; period <= periods; period++) {
    final startBalance = balance;
    final earnings = startBalance * dRate;
    var deposit = 0.0;
    var withdrawal = 0.0;

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
      pendingEarnings = 0.0;
    } else {
      pendingEarnings += earnings;
    }

    balance += deposit - withdrawal;
    // Prevent balance from going negative
    balance = balance < 0.0 ? 0.0 : balance;

    totalDeposits += deposit;
    totalWithdrawals += withdrawal;
    totalEarnings += earnings;

    final entry = MatexCompoundInterestBreakdownEntry(
      totalEarnings: totalEarnings,
      earnings: earnings,
      startBalance: startBalance,
      endBalance: balance,
      totalDeposits: totalDeposits,
      deposit: deposit,
      totalWithdrawals: totalWithdrawals,
      withdrawal: withdrawal,
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

int _getPeriods(MatexFinancialFrequency frequency, [int? duration]) {
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
