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

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexDividendPayoutRatioCalculatorPdfGenerator {
  final appSettingsBloc = FastAppSettingsBloc();
  final appInfoBloc = FastAppInfoBloc();

  Future<Uint8List> generate(
    BuildContext context,
    MatexDividendPayoutRatioCalculatorBlocFields fields,
    MatexDividendPayoutRatioCalculatorBlocResults results,
  ) async {
    final reporter = FastPdfCalculatorReporter();
    final appInfo = appInfoBloc.currentState;

    return reporter.report(
      use24HourFormat: appSettingsBloc.currentState.use24HourFormat,
      disclaimerText:
          FinanceLocaleKeys.finance_disclaimer_intervening_markets.tr(),
      subtitle:
          FinanceDividendLocaleKeys.dividend_label_dividend_payout_ratio.tr(),
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
    MatexDividendPayoutRatioCalculatorBlocFields fields,
    MatexDividendPayoutRatioCalculatorBlocResults results,
  ) {
    return [
      FastReportEntry(
        name: FinanceDividendLocaleKeys.dividend_label_total_dividends.tr(),
        value: fields.formattedTotalDividends,
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_net_income.tr(),
        value: fields.formattedNetIncome,
      ),
    ];
  }

  List<FastReportEntry> _buildResults(
    BuildContext context,
    MatexDividendPayoutRatioCalculatorBlocFields fields,
    MatexDividendPayoutRatioCalculatorBlocResults results,
  ) {
    final dividendYield = results.dividendPayoutRatio;

    return [
      if (dividendYield != null && dividendYield > 0)
        FastReportEntry(
          name: FinanceDividendLocaleKeys.dividend_label_dividend_yield.tr(),
          value: results.formattedDividendPayoutRatio!,
        ),
    ];
  }
}
