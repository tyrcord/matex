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

class MatexPivotPointsCalculatorPdfGenerator {
  final appSettingsBloc = FastAppSettingsBloc();
  final appInfoBloc = FastAppInfoBloc();

  Future<Uint8List> generate(
    BuildContext context,
    MatexPivotPointsCalculatorBlocFields fields,
    MatexPivotPointsCalculatorBlocResults results,
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
    MatexPivotPointsCalculatorBlocFields fields,
    MatexPivotPointsCalculatorBlocResults results,
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
        name: FinanceLocaleKeys.finance_label_close_price.tr(),
        value: fields.formattedClosePrice,
      ),
      if (fields.method == MatexPivotPointsMethods.deMark)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_open_price.tr(),
          value: fields.formattedOpenPrice,
        ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_pivot_point_method.tr(),
        value: fields.formattedMethod,
      ),
    ];
  }

  List<FastReportCategoryEntry> _buildCategoryEntries(
    BuildContext context,
    MatexPivotPointsCalculatorBlocFields fields,
    MatexPivotPointsCalculatorBlocResults results,
  ) {
    return [
      // FIXME: implement
    ];
  }
}
