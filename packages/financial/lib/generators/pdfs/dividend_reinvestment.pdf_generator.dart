// Dart imports:
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:lingua_core/generated/locale_keys.g.dart';
import 'package:lingua_finance/generated/locale_keys.g.dart';
import 'package:lingua_finance_dividend/generated/locale_keys.g.dart';
import 'package:lingua_finance_stock/generated/locale_keys.g.dart';
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexDividendReinvestmentCalculatorPdfGenerator {
  final appSettingsBloc = FastAppSettingsBloc();
  final appInfoBloc = FastAppInfoBloc();

  Future<Uint8List> generate(
    BuildContext context,
    MatexDividendReinvestmentCalculatorBlocFields fields,
    MatexDividendReinvestmentCalculatorBlocResults results,
  ) async {
    final reporter = FastPdfCalculatorReporter();
    final appInfo = appInfoBloc.currentState;

    return reporter.report(
      use24HourFormat: appSettingsBloc.currentState.use24HourFormat,
      disclaimerText:
          FinanceLocaleKeys.finance_disclaimer_intervening_markets.tr(),
      subtitle:
          FinanceDividendLocaleKeys.dividend_label_dividend_reinvestment.tr(),
      inputs: _buildInputReportEntries(context, fields, results),
      languageCode: appSettingsBloc.currentState.languageCode,
      title: CoreLocaleKeys.core_label_report_text.tr(),
      results: _buildResults(context, fields, results),
      countryCode: appInfo.deviceCountryCode,
      categoryColumns: 3,
      author: CoreLocaleKeys.core_message_pdf_generated_by.tr(
        namedArgs: {'app_name': appInfo.appName},
      ),
    );
  }

  List<FastReportEntry> _buildInputReportEntries(
    BuildContext context,
    MatexDividendReinvestmentCalculatorBlocFields fields,
    MatexDividendReinvestmentCalculatorBlocResults results,
  ) {
    final annualContribution =
        parseFieldValueToDouble(fields.annualContribution);
    final annualSharePriceIncrease =
        parseFieldValueToDouble(fields.annualSharePriceIncrease);
    final annualDividendIncrease =
        parseFieldValueToDouble(fields.annualDividendIncrease);
    final taxRate = parseFieldValueToDouble(fields.taxRate);

    return [
      FastReportEntry(
        name: FinanceDividendLocaleKeys.dividend_label_total_dividends.tr(),
        value: fields.formattedSharePrice,
      ),
      FastReportEntry(
        name: FinanceStockLocaleKeys.stock_label_shares_owned.tr(),
        value: fields.formattedNumberOfShares,
      ),
      FastReportEntry(
        name: FinanceDividendLocaleKeys.dividend_label_dividend_yield.tr(),
        value: fields.formattedDividendYield,
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_duration_years.tr(),
        value: fields.formattedYearsToGrow,
      ),
      FastReportEntry(
        name: FinanceDividendLocaleKeys
            .dividend_label_dividend_payment_frequency
            .tr(),
        value: fields.formattedDividendYield,
      ),
      FastReportEntry(
        name: FinanceDividendLocaleKeys
            .dividend_label_dividend_reinvestment_plan
            .tr(),
        value: fields.formattedDrip,
      ),
      if (annualContribution > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_annual_contribution.tr(),
          value: fields.formattedAnnualContribution,
        ),
      if (annualSharePriceIncrease > 0)
        FastReportEntry(
          name: FinanceStockLocaleKeys
              .stock_label_expected_annual_share_price_appreciation
              .tr(),
          value: fields.formattedAnnualSharePriceIncrease,
        ),
      if (annualDividendIncrease > 0)
        FastReportEntry(
          name: FinanceDividendLocaleKeys
              .dividend_label_expected_annual_dividend_increase
              .tr(),
          value: fields.formattedAnnualDividendIncrease,
        ),
      if (taxRate > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_tax_rate.tr(),
          value: fields.formattedTaxRate,
        ),
    ];
  }

  List<FastReportEntry> _buildResults(
    BuildContext context,
    MatexDividendReinvestmentCalculatorBlocFields fields,
    MatexDividendReinvestmentCalculatorBlocResults results,
  ) {
    final endingBalance = results.endingBalance;
    final totalReturn = results.totalReturn;
    final grossDividendPaid = results.grossDividendPaid;
    final totalTaxAmount = results.totalTaxAmount;
    final netDividendPaid = results.netDividendPaid;
    final netDividendIncome = results.netDividendIncome;
    final sharePrice = results.sharePrice;
    final sharesOwned = results.sharesOwned;
    final totalAdditionalContribution = results.totalAdditionalContribution;

    return [
      if (endingBalance != null && endingBalance > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_ending_balance.tr(),
          value: results.formattedEndingBalance!,
        ),
      if (totalReturn != null && totalReturn > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_total_return.tr(),
          value: results.formattedTotalReturn!,
        ),
      if (grossDividendPaid != null && grossDividendPaid > 0)
        FastReportEntry(
          name:
              FinanceDividendLocaleKeys.dividend_label_gross_dividend_paid.tr(),
          value: results.formattedGrossDividendPaid!,
        ),
      if (totalTaxAmount != null && totalTaxAmount > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_tax_amount.tr(),
          value: results.formattedTotalTaxAmount!,
        ),
      if (netDividendPaid != null && netDividendPaid > 0)
        FastReportEntry(
          name: FinanceDividendLocaleKeys.dividend_label_net_dividend_paid.tr(),
          value: results.formattedNetDividendPaid!,
        ),
      if (netDividendIncome != null && netDividendIncome > 0)
        FastReportEntry(
          name: FinanceDividendLocaleKeys
              .dividend_label_annual_net_dividend_income
              .tr(),
          value: results.formattedNetDividendIncome!,
        ),
      if (sharePrice != null && sharePrice > 0)
        FastReportEntry(
          name: FinanceStockLocaleKeys.stock_label_share_price.tr(),
          value: results.formattedSharePrice!,
        ),
      if (sharesOwned != null && sharesOwned > 0)
        FastReportEntry(
          name: FinanceStockLocaleKeys.stock_label_shares_owned.tr(),
          value: results.formattedSharesOwned!,
        ),
      if (totalAdditionalContribution != null &&
          totalAdditionalContribution > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_total_contributions.tr(),
          value: results.formattedTotalAdditionalContribution!,
        ),
    ];
  }
}
