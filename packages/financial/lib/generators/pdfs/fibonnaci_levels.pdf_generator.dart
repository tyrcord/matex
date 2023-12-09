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

class MatexFibonnaciLevelsCalculatorPdfGenerator {
  final appSettingsBloc = FastAppSettingsBloc();
  final appInfoBloc = FastAppInfoBloc();

  Future<Uint8List> generate(
    BuildContext context,
    MatexFibonnaciLevelsCalculatorBlocFields fields,
    MatexFibonnaciLevelsCalculatorBlocResults results,
  ) async {
    final reporter = FastPdfCalculatorReporter();
    final appInfo = appInfoBloc.currentState;

    return reporter.report(
      use24HourFormat: appSettingsBloc.currentState.use24HourFormat,
      disclaimerText:
          FinanceLocaleKeys.finance_disclaimer_intervening_markets.tr(),
      subtitle: FinanceLocaleKeys.finance_label_fibonacci_levels.tr(),
      inputs: _buildInputReportEntries(context, fields, results),
      languageCode: appSettingsBloc.currentState.languageCode,
      title: CoreLocaleKeys.core_label_report_text.tr(),
      results: const [],
      categories: _buildCategoryEntries(context, fields, results),
      countryCode: appInfo.deviceCountryCode,
      categoryColumns: 3,
      author: CoreLocaleKeys.core_message_pdf_generated_by.tr(
        namedArgs: {'app_name': appInfo.appName},
      ),
    );
  }

  List<FastReportEntry> _buildInputReportEntries(
    BuildContext context,
    MatexFibonnaciLevelsCalculatorBlocFields fields,
    MatexFibonnaciLevelsCalculatorBlocResults results,
  ) {
    return [
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_high_price.tr(),
        value: fields.formattedHighPrice,
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_low_price.tr(),
        value: fields.formattedLowPrice,
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_trend_text.tr(),
        value: fields.formattedTrend,
      ),
    ];
  }

  List<FastReportCategoryEntry> _buildCategoryEntries(
    BuildContext context,
    MatexFibonnaciLevelsCalculatorBlocFields fields,
    MatexFibonnaciLevelsCalculatorBlocResults results,
  ) {
    return [
      _buildRetracementCategory(results, fields),
      _buildExtensionCategory(results, fields),
    ];
  }

  FastReportCategoryEntry _buildRetracementCategory(
    MatexFibonnaciLevelsCalculatorBlocResults results,
    MatexFibonnaciLevelsCalculatorBlocFields fields,
  ) {
    return FastReportCategoryEntry(
      name: FinanceLocaleKeys.finance_label_retracement.tr(),
      entries: _buildLevelEntries(results.retracementLevels),
    );
  }

  FastReportCategoryEntry _buildExtensionCategory(
    MatexFibonnaciLevelsCalculatorBlocResults results,
    MatexFibonnaciLevelsCalculatorBlocFields fields,
  ) {
    return FastReportCategoryEntry(
      name: FinanceLocaleKeys.finance_label_extension.tr(),
      entries: _buildLevelEntries(results.extensionLevels),
    );
  }

  List<FastReportEntry> _buildLevelEntries(List<MatexFibonacciLevel> levels) {
    return levels.map((MatexFibonacciLevel fibonacciLevel) {
      return FastReportEntry(
        value: fibonacciLevel.formattedValue,
        name: fibonacciLevel.formattedLevel,
      );
    }).toList();
  }
}
