// Package imports:
import 'package:decimal/decimal.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class DividendReinvestmentCalculator extends MatexCalculator<
    DividendReinvestmentCalculatorState,
    DividendReinvestmentCalculatorResults> {
  DividendReinvestmentCalculator({
    super.defaultState,
    super.state,
  }) : super(validators: []);

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

  // FIXME: move to helpers
  Decimal toPercentageDecimal(num? value) {
    final dValue = toDecimal(value) ?? dZero;

    return decimalFromRational(dValue / dHundred);
  }

  Decimal get dNumberOfShares => toDecimal(state.numberOfShares) ?? dZero;
  Decimal get dSharePrice => toDecimal(state.sharePrice) ?? dZero;
  Decimal get dStartingPrincipal => dNumberOfShares * dSharePrice;
  Decimal get dYearsToGrow => toDecimal(state.yearsToGrow) ?? dZero;
  Decimal get dTotalContribution => dAnnualContribution * dYearsToGrow;
  Decimal get dDividendYield => toPercentageDecimal(state.dividendYield);
  Decimal get dTaxRate => toPercentageDecimal(state.taxRate);

  Decimal get dDividendPaymentFrequency {
    final paymentFrequency = getPaymentFrequency(
      state.dividendPaymentFrequency,
    );

    return toDecimal(paymentFrequency) ?? dZero;
  }

  Decimal get dAnnualDividendIncrease {
    return toPercentageDecimal(state.annualDividendIncrease);
  }

  Decimal get dAnnualSharePriceIncrease {
    return toPercentageDecimal(state.annualSharePriceIncrease);
  }

  Decimal get dAnnualContribution =>
      toDecimal(state.annualContribution) ?? dZero;

  // Default Results
  static const defaultResults = DividendReinvestmentCalculatorResults(
      // Default result properties
      // Example: property: 0,
      // TODO: Define default result properties
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
            toDecimal(lastReport.dividendAmountPerShare) ?? dZero;
        dividendAmountPerShare =
            dividendAmountPerShare * (Decimal.one + dAnnualDividendIncrease);
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
      // FIXME:
      // yearlyReports: reports,
    );
  }

  Decimal _computeTotalReturn(double endingBalance) {
    final dEndingBalance = toDecimal(endingBalance) ?? dZero;
    final denominator = dTotalContribution + dStartingPrincipal;
    final dTotalReturn = decimalFromRational(dEndingBalance / denominator);

    return (dTotalReturn * dHundred) - dHundred;
  }

  // ignore: long-method
  MatexDividendReinvestementYearlyPayoutReport _makeYearlyReport(
    MatexDividendReinvestementYearlyPayoutReport? lastReport,
    Decimal dDividendAmountPerShare,
  ) {
    final payoutReports = <MatexDividendReinvestementPayoutReport>[];

    final dSharePrice =
        toDecimal(lastReport?.sharePrice ?? state.sharePrice!) ?? dZero;

    final dividendAmount = decimalFromRational(
      dDividendAmountPerShare / dDividendPaymentFrequency,
    );

    var dCumulativeShares = toDecimal(
          lastReport?.numberOfShares ?? state.numberOfShares!,
        ) ??
        dZero;

    var dCumulativeGrossAmount = toDecimal(
          lastReport?.cumulativeGrossAmount ?? 0,
        ) ??
        dZero;

    var dCumulativeNetAmount =
        toDecimal(lastReport?.cumulativeNetAmount) ?? dZero;

    var dEndingBalance = _computeEndingBalance(
      lastReport,
      dSharePrice,
      dCumulativeShares,
    );

    var dCumulativeNetDividendPayout = Decimal.zero;
    var dSharePriceIncreaseAmount = Decimal.zero;
    var dCurrentSharePrice = dSharePrice;

    if (dAnnualSharePriceIncrease > Decimal.zero) {
      dSharePriceIncreaseAmount = dSharePrice *
          decimalFromRational(
            dAnnualSharePriceIncrease / dDividendPaymentFrequency,
          );
    }

    for (var i = 0; i < dDividendPaymentFrequency.toBigInt().toInt(); i++) {
      final dividendPayout = _computeDividendPayout(
        MatexDividendReinvestementRecord(
          numberOfshares: dCumulativeShares.toDouble(),
          dividendAmount: dividendAmount.toDouble(),
        ),
      );

      final dNetDividendPayout =
          toDecimal(dividendPayout.netDividendPayout) ?? dZero;

      final dGrossDividendPayout = toDecimal(
            dividendPayout.grossDividendPayout,
          ) ??
          dZero;

      var dAdditionalShareFromAnnualContribution = Decimal.zero;
      var dAdditionalSharesFromDrip = Decimal.zero;

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

      if (i + 1 == dDividendPaymentFrequency.toBigInt().toInt()) {
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

  Decimal _computeAdditionalShareFromAnnualContribution(
    Decimal dCurrentSharePrice,
  ) {
    final dAnnualContribution = toDecimal(state.annualContribution) ?? dZero;

    if (dAnnualContribution > Decimal.zero) {
      return _computeAdditionalShare(
        dAnnualContribution,
        dCurrentSharePrice,
      );
    }

    return Decimal.zero;
  }

  Decimal _computeEndingBalance(
    MatexDividendReinvestementYearlyPayoutReport? lastReport,
    Decimal sharePrice,
    Decimal shares,
  ) {
    if (lastReport != null) {
      return toDecimal(lastReport.endingBalance) ?? dZero;
    }

    return sharePrice * shares;
  }

  MatexDividendReinvestementPayout _computeDividendPayout(
    MatexDividendReinvestementRecord record,
  ) {
    final dDividendAmount = toDecimal(record.dividendAmount) ?? dZero;
    final dShares = toDecimal(record.numberOfshares) ?? dZero;
    final dGrossAmount = dShares * dDividendAmount;
    final netAmount = dGrossAmount * (Decimal.one - dTaxRate);

    return MatexDividendReinvestementPayout(
      grossDividendPayout: dGrossAmount.toDouble(),
      netDividendPayout: netAmount.toDouble(),
    );
  }

  Decimal _computeAdditionalShare(Decimal amount, Decimal sharePrice) {
    return decimalFromRational(amount / sharePrice);
  }
}
