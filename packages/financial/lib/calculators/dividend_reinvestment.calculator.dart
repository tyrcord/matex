// Package imports:
import 'package:decimal/decimal.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexDividendReinvestmentCalculator extends MatexCalculator<
    DividendReinvestmentCalculatorState,
    DividendReinvestmentCalculatorResults> {
  MatexDividendReinvestmentCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: dividendReinvestmentValidators);

  @override
  DividendReinvestmentCalculatorState initializeState() =>
      const DividendReinvestmentCalculatorState();

  @override
  DividendReinvestmentCalculatorState initializeDefaultState() =>
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
    setState(state.copyWith(dividendPaymentFrequency: value));
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

  Decimal toDecimalOrDefault(dynamic value) => toDecimal(value) ?? dZero;

  Decimal get dNumberOfShares => toDecimalOrDefault(state.numberOfShares);
  Decimal get dSharePrice => toDecimalOrDefault(state.sharePrice);
  Decimal get dStartingPrincipal => dNumberOfShares * dSharePrice;
  Decimal get dYearsToGrow => toDecimalOrDefault(state.yearsToGrow);
  Decimal get dTotalContribution => dAnnualContribution * dYearsToGrow;
  Decimal get dDividendYield => toDecimalOrDefault(state.dividendYield);
  Decimal get dTaxRate => toDecimalOrDefault(state.taxRate);

  int get paymentFrequency {
    return getPaymentFrequency(state.dividendPaymentFrequency);
  }

  Decimal get dDividendPaymentFrequency => toDecimalOrDefault(paymentFrequency);

  Decimal get dAnnualDividendIncrease {
    return toDecimalOrDefault(state.annualDividendIncrease);
  }

  Decimal get dAnnualSharePriceIncrease {
    return toDecimalOrDefault(state.annualSharePriceIncrease);
  }

  Decimal get dAnnualContribution =>
      toDecimalOrDefault(state.annualContribution);

  // Default Results
  static const defaultResults = DividendReinvestmentCalculatorResults(
    endingBalance: 0,
  );

  @override
  DividendReinvestmentCalculatorResults value() {
    if (!isValid) return defaultResults;

    final reports = <MatexDividendReinvestementYearlyPayoutReport>[];
    MatexDividendReinvestementYearlyPayoutReport? lastReport;
    MatexDividendReinvestementYearlyPayoutReport? futureReport;
    var dividendAmountPerShare = dSharePrice * dDividendYield;

    for (var i = 0; i <= state.yearsToGrow!; i++) {
      if (lastReport != null) {
        dividendAmountPerShare =
            toDecimalOrDefault(lastReport.dividendAmountPerShare);
        dividendAmountPerShare =
            dividendAmountPerShare * (dOne + dAnnualDividendIncrease);
      }

      if (i < state.yearsToGrow!) {
        lastReport = _makeYearlyReport(lastReport, dividendAmountPerShare);
        reports.add(lastReport);
      } else {
        futureReport = _makeYearlyReport(lastReport, dividendAmountPerShare);
      }
    }

    return DividendReinvestmentCalculatorResults(
      totalReturn: _computeTotalReturn(lastReport!.endingBalance!).toDouble(),
      grossDividendPaid: lastReport.cumulativeGrossAmount,
      netDividendeIncome: futureReport!.netDividendPayout,
      netDividendPaid: lastReport.cumulativeNetAmount,
      totalContribution: dTotalContribution.toDouble(),
      startingBalance: dStartingPrincipal.toDouble(),
      numberOfShares: lastReport.numberOfShares,
      endingBalance: lastReport.endingBalance,
      sharePrice: lastReport.sharePrice,
      reports: reports,
    );
  }

  MatexDividendReinvestementYearlyPayoutReport _makeYearlyReport(
    MatexDividendReinvestementYearlyPayoutReport? lastReport,
    Decimal dDividendAmountPerShare,
  ) {
    final payoutReports = <MatexDividendReinvestementPayoutReport>[];
    final dSharePrice = _getInitialSharePrice(lastReport: lastReport);

    final dividendAmount = decimalFromRational(
      dDividendAmountPerShare / dDividendPaymentFrequency,
    );

    var dCumulativeShares =
        toDecimalOrDefault(lastReport?.dNumberOfShares ?? state.numberOfShares);
    var dCumulativeGrossAmount =
        toDecimalOrDefault(lastReport?.dCumulativeGrossAmount);
    var dCumulativeNetAmount =
        toDecimalOrDefault(lastReport?.dCumulativeNetAmount);

    var dEndingBalance = _computeEndingBalance(
      lastReport,
      dSharePrice,
      dCumulativeShares,
    );

    var dCumulativeNetDividendPayout = dZero;
    var dSharePriceIncreaseAmount = dZero;
    var dCurrentSharePrice = dSharePrice;

    if (dAnnualSharePriceIncrease > dZero) {
      dSharePriceIncreaseAmount = dSharePrice *
          decimalFromRational(
            dAnnualSharePriceIncrease / dDividendPaymentFrequency,
          );
    }

    for (var i = 0; i < paymentFrequency; i++) {
      final dividendPayout = _computeDividendPayout(
        MatexDividendReinvestementRecord(
          numberOfshares: dCumulativeShares.toDouble(),
          dividendAmount: dividendAmount.toDouble(),
        ),
      );

      final dNetDividendPayout =
          toDecimalOrDefault(dividendPayout.netDividendPayout);

      final dGrossDividendPayout = toDecimalOrDefault(
        dividendPayout.grossDividendPayout,
      );

      var dAdditionalShareFromAnnualContribution = dZero;
      var dAdditionalSharesFromDrip = dZero;

      dCurrentSharePrice += dSharePriceIncreaseAmount;
      dEndingBalance += dCumulativeShares * dSharePriceIncreaseAmount;

      if (state.drip) {
        dAdditionalSharesFromDrip = _computeAdditionalShare(
          dNetDividendPayout,
          dCurrentSharePrice,
        );

        dCumulativeShares += dAdditionalSharesFromDrip;
        dEndingBalance += dAdditionalSharesFromDrip * dCurrentSharePrice;
      } else {
        dEndingBalance += dNetDividendPayout;
      }

      dCumulativeGrossAmount += dGrossDividendPayout;
      dCumulativeNetAmount += dNetDividendPayout;
      dCumulativeNetDividendPayout += dNetDividendPayout;

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
              dAdditionalShareFromAnnualContribution.toDouble(),
          sharePrice: dCurrentSharePrice.toDouble(),
          grossDividendPayout: dividendPayout.grossDividendPayout,
          netDividendPayout: dividendPayout.netDividendPayout,
          cumulativeGrossAmount: dCumulativeGrossAmount.toDouble(),
          cumulativeNetAmount: dCumulativeNetAmount.toDouble(),
          additionalSharesFromDrip: dAdditionalSharesFromDrip.toDouble(),
          endingBalance: dEndingBalance.toDouble(),
          numberOfShares: dCumulativeShares.toDouble(),
        ),
      );
    }

    return MatexDividendReinvestementYearlyPayoutReport(
      netDividendPayout: dCumulativeNetDividendPayout.toDouble(),
      dividendAmountPerShare: dDividendAmountPerShare.toDouble(),
      cumulativeGrossAmount: dCumulativeGrossAmount.toDouble(),
      cumulativeNetAmount: dCumulativeNetAmount.toDouble(),
      numberOfShares: dCumulativeShares.toDouble(),
      sharePrice: dCurrentSharePrice.toDouble(),
      endingBalance: dEndingBalance.toDouble(),
      payouts: payoutReports,
    );
  }

  Decimal _computeTotalReturn(double endingBalance) {
    final dEndingBalance = toDecimalOrDefault(endingBalance);
    final denominator = dTotalContribution + dStartingPrincipal;
    final dTotalReturn = decimalFromRational(dEndingBalance / denominator);

    return (dTotalReturn * dHundred) - dHundred;
  }

  Decimal _getInitialSharePrice({
    MatexDividendReinvestementYearlyPayoutReport? lastReport,
  }) {
    return toDecimalOrDefault(lastReport?.sharePrice ?? state.sharePrice);
  }

  bool _isAnnualContributionTime(int currentIndex) {
    return currentIndex + 1 == paymentFrequency;
  }

  Decimal _computeAdditionalShareFromAnnualContribution(
    Decimal dCurrentSharePrice,
  ) {
    final dAnnualContribution = toDecimalOrDefault(state.annualContribution);

    if (dAnnualContribution > dZero) {
      return _computeAdditionalShare(dAnnualContribution, dCurrentSharePrice);
    }

    return dZero;
  }

  Decimal _computeEndingBalance(
    MatexDividendReinvestementYearlyPayoutReport? lastReport,
    Decimal sharePrice,
    Decimal shares,
  ) {
    if (lastReport != null) return toDecimalOrDefault(lastReport.endingBalance);

    return sharePrice * shares;
  }

  MatexDividendReinvestementPayout _computeDividendPayout(
    MatexDividendReinvestementRecord record,
  ) {
    final dDividendAmount = toDecimalOrDefault(record.dividendAmount);
    final dShares = toDecimalOrDefault(record.numberOfshares);
    final dGrossAmount = dShares * dDividendAmount;
    final netAmount = dGrossAmount * (dOne - dTaxRate);

    return MatexDividendReinvestementPayout(
      grossDividendPayout: dGrossAmount.toDouble(),
      netDividendPayout: netAmount.toDouble(),
    );
  }

  Decimal _computeAdditionalShare(Decimal amount, Decimal sharePrice) {
    return decimalFromRational(amount / sharePrice);
  }
}
