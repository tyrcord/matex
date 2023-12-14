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
import 'package:lingua_finance_forex/generated/locale_keys.g.dart';
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexPipDeltaCalculatorPdfGenerator {
  final appSettingsBloc = FastAppSettingsBloc();
  final appInfoBloc = FastAppInfoBloc();

  Future<Uint8List> generate(
    BuildContext context,
    MatexForexPipDeltaCalculatorBlocFields fields,
    MatexForexPipDeltaCalculatorBlocResults results,
    Map<String, dynamic> metadata,
  ) async {
    final reporter = FastPdfCalculatorReporter();
    final appInfo = appInfoBloc.currentState;

    return reporter.report(
      use24HourFormat: appSettingsBloc.currentState.use24HourFormat,
      disclaimerText:
          FinanceLocaleKeys.finance_disclaimer_intervening_markets.tr(),
      subtitle: FinanceForexLocaleKeys.forex_label_pip_difference.tr(),
      inputs: _buildInputReportEntries(context, fields, results, metadata),
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
    MatexForexPipDeltaCalculatorBlocFields fields,
    MatexForexPipDeltaCalculatorBlocResults results,
    Map<String, dynamic> metadata,
  ) {
    final priceA = parseFieldValueToDouble(fields.priceA);
    final priceB = parseFieldValueToDouble(fields.priceB);

    return [
      if (fields.financialInstrument != null)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_financial_instrument.tr(),
          value: fields.formattedFinancialInstrument,
        ),
      if (priceA > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_price_a.tr(),
          value: fields.formattedPriceA,
        ),
      if (priceB > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_price_b.tr(),
          value: fields.formattedPriceB,
        ),
    ];
  }

  List<FastReportEntry> _buildResults(
    BuildContext context,
    MatexForexPipDeltaCalculatorBlocFields fields,
    MatexForexPipDeltaCalculatorBlocResults results,
  ) {
    final numberOfPips = results.numberOfPips;

    return [
      if (numberOfPips != null && numberOfPips > 0)
        FastReportEntry(
          name: FinanceForexLocaleKeys.forex_label_pips_number.tr(),
          value: results.formattedNumberOfPips!,
        ),
    ];
  }
}
