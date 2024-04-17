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
  late final double totalTaxPaid;

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
  final String? formattedTotalTaxPaid;

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
    this.formattedTotalTaxPaid,
    double? totalWithdrawals,
    double? totalDeposits,
    double? withdrawal,
    double? deposit,
    double? totalTaxPaid,
  }) {
    this.totalWithdrawals = totalWithdrawals ?? 0;
    this.totalDeposits = totalDeposits ?? 0;
    this.withdrawal = withdrawal ?? 0;
    this.deposit = deposit ?? 0;
    this.totalTaxPaid = totalTaxPaid ?? 0;
    cashFlow = this.deposit - this.withdrawal;
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
    String? formattedTotalTaxPaid,
    double? totalTaxPaid,
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
      formattedTotalTaxPaid:
          formattedTotalTaxPaid ?? this.formattedTotalTaxPaid,
      totalTaxPaid: totalTaxPaid ?? this.totalTaxPaid,
    );
  }

  // FIXME: move to t_helpers
  String _escape(String field) {
    return '"${field.replaceAll('"', '""')}"';
  }

  String toCsv() {
    var csv = '';

    if (formattedPeriod != null) {
      csv += _escape(formattedPeriod!);
    }

    if (formattedStartBalance != null) {
      csv += ',${_escape(formattedStartBalance!)}';
    }

    if (formattedDeposit != null && deposit > 0) {
      csv += ',${_escape(formattedDeposit!)}';
    }

    if (formattedWithdrawal != null && withdrawal > 0) {
      csv += ',${_escape(formattedWithdrawal!)}';
    }

    if (formattedEarnings != null) {
      csv += ',${_escape(formattedEarnings!)}';
    }

    if (formattedEndBalance != null) {
      csv += ',${_escape(formattedEndBalance!)}';
    }

    return csv;
  }
}
