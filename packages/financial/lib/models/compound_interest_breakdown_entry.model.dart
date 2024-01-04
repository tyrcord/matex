class MatexCompoundInterestBreakdownEntry {
  final double startBalance;
  final double endBalance;

  final double earnings;
  final double totalEarnings;

  late final double deposit;
  late final double totalDeposits;

  late final double withdrawal;
  late final double totalWithdrawals;

  late final double cashFlow;
  late final int period;

  // Formatted properties
  final String? formattedStartBalance;
  final String? formattedEndBalance;
  final String? formattedEarnings;
  final String? formattedTotalEarnings;
  final String? formattedDeposit;
  final String? formattedTotalDeposits;
  final String? formattedWithdrawal;
  final String? formattedTotalWithdrawals;
  final String? formattedCashFlow;
  final String? formattedPeriod;

  MatexCompoundInterestBreakdownEntry({
    required this.startBalance,
    required this.endBalance,
    required this.earnings,
    required this.totalEarnings,
    required this.period,
    this.formattedStartBalance,
    this.formattedEndBalance,
    this.formattedEarnings,
    this.formattedTotalEarnings,
    this.formattedDeposit,
    this.formattedTotalDeposits,
    this.formattedWithdrawal,
    this.formattedTotalWithdrawals,
    this.formattedCashFlow,
    this.formattedPeriod,
    double? totalWithdrawals,
    double? totalDeposits,
    double? withdrawal,
    double? deposit,
  }) {
    this.totalWithdrawals = totalWithdrawals ?? 0;
    this.totalDeposits = totalDeposits ?? 0;
    this.withdrawal = withdrawal ?? 0;
    this.deposit = deposit ?? 0;
    cashFlow = this.totalDeposits - this.totalWithdrawals;
  }

  MatexCompoundInterestBreakdownEntry copyWith({
    double? startBalance,
    double? endBalance,
    double? earnings,
    double? totalEarnings,
    String? formattedStartBalance,
    String? formattedEndBalance,
    String? formattedEarnings,
    String? formattedTotalEarnings,
    String? formattedDeposit,
    String? formattedTotalDeposits,
    String? formattedWithdrawal,
    String? formattedTotalWithdrawals,
    String? formattedCashFlow,
    double? totalWithdrawals,
    double? totalDeposits,
    double? withdrawal,
    double? deposit,
    int? period,
    String? formattedPeriod,
  }) {
    return MatexCompoundInterestBreakdownEntry(
      startBalance: startBalance ?? this.startBalance,
      endBalance: endBalance ?? this.endBalance,
      earnings: earnings ?? this.earnings,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      formattedStartBalance:
          formattedStartBalance ?? this.formattedStartBalance,
      formattedEndBalance: formattedEndBalance ?? this.formattedEndBalance,
      formattedEarnings: formattedEarnings ?? this.formattedEarnings,
      formattedTotalEarnings:
          formattedTotalEarnings ?? this.formattedTotalEarnings,
      formattedDeposit: formattedDeposit ?? this.formattedDeposit,
      formattedTotalDeposits:
          formattedTotalDeposits ?? this.formattedTotalDeposits,
      formattedWithdrawal: formattedWithdrawal ?? this.formattedWithdrawal,
      formattedTotalWithdrawals:
          formattedTotalWithdrawals ?? this.formattedTotalWithdrawals,
      formattedCashFlow: formattedCashFlow ?? this.formattedCashFlow,
      totalWithdrawals: totalWithdrawals ?? this.totalWithdrawals,
      totalDeposits: totalDeposits ?? this.totalDeposits,
      withdrawal: withdrawal ?? this.withdrawal,
      deposit: deposit ?? this.deposit,
      period: period ?? this.period,
      formattedPeriod: formattedPeriod ?? this.formattedPeriod,
    );
  }
}
