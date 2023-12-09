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
      subtitle: FinanceLocaleKeys.finance_label_pivot_points.tr(),
      inputs: _buildInputReportEntries(context, fields, results),
      languageCode: appSettingsBloc.currentState.languageCode,
      title: CoreLocaleKeys.core_label_report_text.tr(),
      results: _buildResultReportEntries(context, fields, results),
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
        name: FinanceLocaleKeys.finance_label_low_price.tr(),
        value: fields.formattedLowPrice,
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_high_price.tr(),
        value: fields.formattedHighPrice,
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

  List<FastReportEntry> _buildResultReportEntries(
    BuildContext context,
    MatexPivotPointsCalculatorBlocFields fields,
    MatexPivotPointsCalculatorBlocResults results,
  ) {
    return [
      if (fields.method != MatexPivotPointsMethods.deMark &&
          fields.method != MatexPivotPointsMethods.camarilla)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_pivot_point_text.tr(),
          value: results.formattedPivotPoint.toString(),
        ),
    ];
  }

  List<FastReportCategoryEntry> _buildCategoryEntries(
    BuildContext context,
    MatexPivotPointsCalculatorBlocFields fields,
    MatexPivotPointsCalculatorBlocResults results,
  ) {
    final palette = ThemeHelper.getPaletteColors(context);

    return [
      _buildResistancesCategory(results, palette.red.mid),
      _buildSupportsCategory(results, palette.green.mid),
    ];
  }

  FastReportCategoryEntry _buildResistancesCategory(
    MatexPivotPointsCalculatorBlocResults results,
    Color color,
  ) {
    return FastReportCategoryEntry(
      name: FinanceLocaleKeys.finance_label_resistances.tr(),
      entries: _buildResistanceEntries(results, color),
    );
  }

  List<FastReportEntry> _buildResistanceEntries(
    MatexPivotPointsCalculatorBlocResults results,
    Color color,
  ) {
    const labelKey = FinanceLocaleKeys.finance_label_resistance_level;
    final values = results.formattedResistances ?? [];

    return _buildEntries(values, labelKey, color);
  }

  FastReportCategoryEntry _buildSupportsCategory(
    MatexPivotPointsCalculatorBlocResults results,
    Color color,
  ) {
    return FastReportCategoryEntry(
      name: FinanceLocaleKeys.finance_label_supports.tr(),
      entries: _buildSupportEntries(results, color),
    );
  }

  List<FastReportEntry> _buildSupportEntries(
    MatexPivotPointsCalculatorBlocResults results,
    Color color,
  ) {
    const labelKey = FinanceLocaleKeys.finance_label_support_level;
    final values = results.formattedSupports ?? [];

    return _buildEntries(values, labelKey, color);
  }

  List<FastReportEntry> _buildEntries(
    List<String> values,
    String labelKey,
    Color color,
  ) {
    var level = values.length;

    return values.reversed.map((String value) {
      final label = labelKey.tr(namedArgs: {'level': (level--).toString()});

      return _buildEntry(value, label, color);
    }).toList();
  }

  FastReportEntry _buildEntry(String valueText, String labelText, Color color) {
    return FastReportEntry(color: color, name: labelText, value: valueText);
  }
}
