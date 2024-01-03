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
      // FIXME: localize
      subtitle: 'Forex Compounding Calculator',
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
    final hasContributions = results.totalContributions > 0;
    final hasWithdrawals = results.totalWithdrawals > 0;

    return [
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_starting_balance.tr(),
        value: fields.formattedStartBalance,
      ),
      FastReportEntry(
        name: 'Expected gain %',
        value: fields.formattedRate,
      ),
      FastReportEntry(
        name: 'Expected gain frequency',
        value: fields.formattedRateFrequency,
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_duration_years.tr(),
        value: fields.formattedDuration,
      ),
      FastReportEntry(
        name: 'Compounding frequency',
        value: fields.formattedCompoundFrequency,
      ),
      if (hasContributions) ...[
        FastReportEntry(
          name: 'Additional contribution',
          value: fields.formattedAdditionalContribution,
        ),
        FastReportEntry(
          name: 'Additional contribution frequency',
          value: fields.formattedContributionFrequency,
        ),
      ],
      if (hasWithdrawals) ...[
        FastReportEntry(
          name: 'Withdrawal amount',
          value: fields.formattedWithdrawalAmount,
        ),
        FastReportEntry(
          name: 'Withdrawal frequency',
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
    final hasContributions = results.totalContributions > 0;
    final hasWithdrawals = results.totalWithdrawals > 0;

    return [
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_ending_balance.tr(),
        value: results.formattedEndBalance!,
      ),
      FastReportEntry(
        name: 'Total Earnings',
        value: results.formattedTotalEarnings!,
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_total_return.tr(),
        value: results.formattedRateOfReturn!,
      ),
      if (hasContributions)
        FastReportEntry(
          name: 'Total contributions',
          value: results.formattedTotalContributions!,
        ),
      if (hasWithdrawals)
        FastReportEntry(
          name: 'Total withdrawals',
          value: results.formattedTotalWithdrawals!,
        ),
    ];
  }
}
