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

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexCompoundCalculatorPdfGenerator {
  final appSettingsBloc = FastAppSettingsBloc();
  final appInfoBloc = FastAppInfoBloc();

  Future<Uint8List> generate(
    BuildContext context,
    MatexForexCompoundCalculatorBlocFields fields,
    MatexForexCompoundCalculatorBlocResults results,
  ) async {
    final reporter = FastPdfCalculatorReporter();
    final appInfo = appInfoBloc.currentState;

    return reporter.report(
      use24HourFormat: appSettingsBloc.currentState.use24HourFormat,
      disclaimerText:
          FinanceLocaleKeys.finance_disclaimer_intervening_markets.tr(),
      subtitle: FinanceLocaleKeys.finance_label_compounding_text.tr(),
      inputs: _buildInputReportEntries(context, fields, results),
      languageCode: appSettingsBloc.currentState.languageCode,
      title: CoreLocaleKeys.core_label_report_text.tr(),
      results: _buildResults(context, fields, results),
      countryCode: appInfo.deviceCountryCode,
      categoryColumns: 3,
      author: CoreLocaleKeys.core_message_pdf_generated_by.tr(
        namedArgs: {'app_name': appInfo.appName},
      ),
      // TODO: implement breakdown table
    );
  }

  List<FastReportEntry> _buildInputReportEntries(
    BuildContext context,
    MatexForexCompoundCalculatorBlocFields fields,
    MatexForexCompoundCalculatorBlocResults results,
  ) {
    final hasContributions = fields.additionalContribution?.isNotEmpty ?? false;
    final hasWithdrawals = fields.withdrawalAmount?.isNotEmpty ?? false;

    return [
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_starting_balance.tr(),
        value: fields.formattedStartBalance,
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_rate_of_return_text.tr(),
        value: fields.formattedRate,
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_return_frequency.tr(),
        value: fields.formattedRateFrequency,
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_duration_years.tr(),
        value: fields.formattedDuration,
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_compounding_frequency.tr(),
        value: fields.formattedCompoundFrequency,
      ),
      if (hasContributions) ...[
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_additional_contributions.tr(),
          value: fields.formattedAdditionalContribution,
        ),
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_contribution_frequency.tr(),
          value: fields.formattedContributionFrequency,
        ),
      ],
      if (hasWithdrawals) ...[
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_withdrawals_amount.tr(),
          value: fields.formattedWithdrawalAmount,
        ),
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_withdrawal_frequency.tr(),
          value: fields.formattedWithdrawalFrequency,
        ),
      ],
    ];
  }

  List<FastReportEntry> _buildResults(
    BuildContext context,
    MatexForexCompoundCalculatorBlocFields fields,
    MatexForexCompoundCalculatorBlocResults results,
  ) {
    final hasContributions = fields.additionalContribution?.isNotEmpty ?? false;
    final hasWithdrawals = fields.withdrawalAmount?.isNotEmpty ?? false;

    return [
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_ending_balance.tr(),
        value: results.formattedEndBalance!,
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_total_earnings.tr(),
        value: results.formattedTotalEarnings!,
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_rate_of_return_all_time.tr(),
        value: results.formattedRateOfReturn!,
      ),
      if (hasContributions)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_total_deposits.tr(),
          value: results.formattedTotalContributions!,
        ),
      if (hasWithdrawals)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_total_withdrawals.tr(),
          value: results.formattedTotalWithdrawals!,
        ),
    ];
  }
}
