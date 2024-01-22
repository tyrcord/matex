// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexDividendReinvestmentCalculator extends MatexCalculator<
    MatexDividendReinvestmentCalculatorState,
    MatexDividendReinvestmentCalculatorResults> {
  MatexDividendReinvestmentCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: dividendReinvestmentValidators);

  @override
  MatexDividendReinvestmentCalculatorState initializeState() =>
      const MatexDividendReinvestmentCalculatorState();

  @override
  MatexDividendReinvestmentCalculatorState initializeDefaultState() =>
      initializeState();

  // Properties
  MatexFinancialFrequency get dividendPaymentFrequency =>
      state.dividendPaymentFrequency;
  double? get sharePrice => state.sharePrice;
  double? get numberOfShares => state.numberOfShares;
  double? get dividendYield => state.dividendYield;
  int? get yearsToGrow => state.yearsToGrow;
  double? get annualContribution => state.annualContribution;
  double? get annualSharePriceIncrease => state.annualSharePriceIncrease;
  double? get annualDividendIncrease => state.annualDividendIncrease;
  double? get taxRate => state.taxRate;
  bool get drip => state.drip;

  // Setters
  set dividendPaymentFrequency(MatexFinancialFrequency value) {
    setState(state.copyWith(paymentFrequency: value));
  }

  set sharePrice(double? value) {
    setState(state.copyWith(sharePrice: value));
  }

  set numberOfShares(double? value) {
    setState(state.copyWith(numberOfShares: value));
  }

  set dividendYield(double? value) {
    setState(state.copyWith(dividendYield: value));
  }

  set yearsToGrow(int? value) {
    setState(state.copyWith(yearsToGrow: value));
  }

  set annualContribution(double? value) {
    setState(state.copyWith(annualContribution: value));
  }

  set annualSharePriceIncrease(double? value) {
    setState(state.copyWith(annualSharePriceIncrease: value));
  }

  set annualDividendIncrease(double? value) {
    setState(state.copyWith(annualDividendIncrease: value));
  }

  set taxRate(double? value) {
    setState(state.copyWith(taxRate: value));
  }

  set drip(bool value) {
    setState(state.copyWith(drip: value));
  }

  double get dStartingPrincipal => (numberOfShares ?? 0) * (sharePrice ?? 0);
  double get dTotalContribution =>
      (annualContribution ?? 0) * (yearsToGrow ?? 0);

  int get paymentFrequency {
    return getPaymentFrequency(state.dividendPaymentFrequency);
  }

  // Default Results
  static const defaultResults = MatexDividendReinvestmentCalculatorResults(
    endingBalance: 0,
  );

  @override
  MatexDividendReinvestmentCalculatorResults value() {
    if (!isValid) return defaultResults;

    final reports = <MatexDividendReinvestementYearlyPayoutReport>[];
    MatexDividendReinvestementYearlyPayoutReport? lastReport;
    MatexDividendReinvestementYearlyPayoutReport? futureReport;
    var dividendAmountPerShare = (sharePrice ?? 0) * (dividendYield ?? 0);

    for (var i = 0; i <= state.yearsToGrow!; i++) {
      if (lastReport != null) {
        dividendAmountPerShare = lastReport.dividendAmountPerShare ?? 0;
        dividendAmountPerShare =
            dividendAmountPerShare * (1 + (annualDividendIncrease ?? 0));
      }

      if (i < state.yearsToGrow!) {
        lastReport = _makeYearlyReport(lastReport, dividendAmountPerShare);
        reports.add(lastReport);
      } else {
        futureReport = _makeYearlyReport(lastReport, dividendAmountPerShare);
      }
    }

    return MatexDividendReinvestmentCalculatorResults(
      totalReturn: _computeTotalReturn(lastReport!.endingBalance!),
      totalTaxAmount: _computeTotalTaxAmount(lastReport),
      grossDividendPaid: lastReport.cumulativeGrossAmount,
      netDividendIncome: futureReport!.netDividendPayout,
      netDividendPaid: lastReport.cumulativeNetAmount,
      totalContribution: dTotalContribution,
      startingBalance: dStartingPrincipal,
      numberOfShares: lastReport.numberOfShares,
      endingBalance: lastReport.endingBalance,
      sharePrice: lastReport.sharePrice,
      reports: reports,
    );
  }

  MatexDividendReinvestementYearlyPayoutReport _makeYearlyReport(
    MatexDividendReinvestementYearlyPayoutReport? lastReport,
    double dDividendAmountPerShare,
  ) {
    final dividendPaymentFrequency = paymentFrequency;
    final dividendAmount = dDividendAmountPerShare / dividendPaymentFrequency;
    final payoutReports = <MatexDividendReinvestementPayoutReport>[];
    final dSharePrice = _getInitialSharePrice(lastReport: lastReport);

    var dCumulativeGrossAmount = lastReport?.cumulativeGrossAmount ?? 0.0;
    var dCumulativeNetAmount = lastReport?.cumulativeNetAmount ?? 0.0;
    var dCumulativeShares =
        lastReport?.numberOfShares ?? state.numberOfShares ?? 0.0;

    var dEndingBalance = _computeEndingBalance(
      lastReport,
      dSharePrice,
      dCumulativeShares,
    );

    var dCumulativeNetDividendPayout = 0.0;
    var dSharePriceIncreaseAmount = 0.0;
    var dCurrentSharePrice = dSharePrice;

    if (annualSharePriceIncrease != null && annualSharePriceIncrease! > 0.0) {
      dSharePriceIncreaseAmount =
          dSharePrice * (annualSharePriceIncrease! / dividendPaymentFrequency);
    }

    for (var i = 0; i < paymentFrequency; i++) {
      final dividendPayout = _computeDividendPayout(
        MatexDividendReinvestementRecord(
          numberOfshares: dCumulativeShares,
          dividendAmount: dividendAmount,
        ),
      );

      final grossDividendPayout = dividendPayout.grossDividendPayout ?? 0.0;
      final netDividendPayout = dividendPayout.netDividendPayout ?? 0.0;

      var dAdditionalShareFromAnnualContribution = 0.0;
      var dAdditionalSharesFromDrip = 0.0;

      dCurrentSharePrice += dSharePriceIncreaseAmount;
      dEndingBalance += dCumulativeShares * dSharePriceIncreaseAmount;

      if (state.drip) {
        dAdditionalSharesFromDrip = _computeAdditionalShare(
          netDividendPayout,
          dCurrentSharePrice,
        );

        dCumulativeShares += dAdditionalSharesFromDrip;
        dEndingBalance += dAdditionalSharesFromDrip * dCurrentSharePrice;
      } else {
        dEndingBalance += netDividendPayout;
      }

      dCumulativeGrossAmount += grossDividendPayout;
      dCumulativeNetAmount += netDividendPayout;
      dCumulativeNetDividendPayout += netDividendPayout;

      if (_isAnnualContributionTime(i)) {
        dAdditionalShareFromAnnualContribution =
            _computeAdditionalShareFromAnnualContribution(
          dCurrentSharePrice,
        );

        dCumulativeShares += dAdditionalShareFromAnnualContribution;
        dEndingBalance +=
            dAdditionalShareFromAnnualContribution * dCurrentSharePrice;
      }

      payoutReports.add(
        MatexDividendReinvestementPayoutReport(
          additionalSharesFromAnnualContribution:
              dAdditionalShareFromAnnualContribution,
          sharePrice: dCurrentSharePrice,
          grossDividendPayout: dividendPayout.grossDividendPayout,
          netDividendPayout: dividendPayout.netDividendPayout,
          cumulativeGrossAmount: dCumulativeGrossAmount,
          cumulativeNetAmount: dCumulativeNetAmount,
          additionalSharesFromDrip: dAdditionalSharesFromDrip,
          endingBalance: dEndingBalance,
          numberOfShares: dCumulativeShares,
        ),
      );
    }

    return MatexDividendReinvestementYearlyPayoutReport(
      netDividendPayout: dCumulativeNetDividendPayout,
      dividendAmountPerShare: dDividendAmountPerShare,
      cumulativeGrossAmount: dCumulativeGrossAmount,
      cumulativeNetAmount: dCumulativeNetAmount,
      numberOfShares: dCumulativeShares,
      sharePrice: dCurrentSharePrice,
      endingBalance: dEndingBalance,
      payouts: payoutReports,
    );
  }

  double _computeTotalTaxAmount(
    MatexDividendReinvestementYearlyPayoutReport? lastReport,
  ) {
    final dCumulativeGrossAmount = lastReport?.cumulativeGrossAmount ?? 0.0;
    final dCumulativeNetAmount = lastReport?.cumulativeNetAmount ?? 0.0;

    return dCumulativeGrossAmount - dCumulativeNetAmount;
  }

  double _computeTotalReturn(double endingBalance) {
    final denominator = dTotalContribution + dStartingPrincipal;

    return (endingBalance / denominator) - 1;
  }

  double _getInitialSharePrice({
    MatexDividendReinvestementYearlyPayoutReport? lastReport,
  }) {
    return lastReport?.sharePrice ?? state.sharePrice ?? 0.0;
  }

  bool _isAnnualContributionTime(int currentIndex) {
    return currentIndex + 1 == paymentFrequency;
  }

  double _computeAdditionalShareFromAnnualContribution(
    double dCurrentSharePrice,
  ) {
    final dAnnualContribution = state.annualContribution ?? 0.0;

    if (dAnnualContribution > 0) {
      return _computeAdditionalShare(dAnnualContribution, dCurrentSharePrice);
    }

    return 0;
  }

  double _computeEndingBalance(
    MatexDividendReinvestementYearlyPayoutReport? lastReport,
    double sharePrice,
    double shares,
  ) {
    if (lastReport != null) return lastReport.endingBalance ?? 0;

    return sharePrice * shares;
  }

  MatexDividendReinvestementPayout _computeDividendPayout(
    MatexDividendReinvestementRecord record,
  ) {
    final dDividendAmount = record.dividendAmount ?? 0;
    final shares = record.numberOfshares ?? 0;
    final grossAmount = shares * dDividendAmount;
    final taxRate = state.taxRate ?? 0;
    final netAmount = grossAmount * (1 - taxRate);

    return MatexDividendReinvestementPayout(
      grossDividendPayout: grossAmount,
      netDividendPayout: netAmount,
    );
  }

  double _computeAdditionalShare(double amount, double sharePrice) {
    return amount / sharePrice;
  }
}
