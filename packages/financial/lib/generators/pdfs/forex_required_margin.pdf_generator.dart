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
import 'package:lingua_units/lingua_units.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexRequiredMarginCalculatorPdfGenerator {
  final appSettingsBloc = FastAppSettingsBloc();
  final appInfoBloc = FastAppInfoBloc();

  Future<Uint8List> generate(
    BuildContext context,
    MatexForexRequiredMarginCalculatorBlocFields fields,
    MatexForexRequiredMarginCalculatorBlocResults results,
    Map<String, dynamic> metadata,
  ) async {
    final reporter = FastPdfCalculatorReporter();
    final appInfo = appInfoBloc.currentState;

    return reporter.report(
      use24HourFormat: appSettingsBloc.currentState.use24HourFormat,
      disclaimerText:
          FinanceLocaleKeys.finance_disclaimer_intervening_markets.tr(),
      subtitle: FinanceForexLocaleKeys.forex_label_pip_value.tr(),
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
    MatexForexRequiredMarginCalculatorBlocFields fields,
    MatexForexRequiredMarginCalculatorBlocResults results,
    Map<String, dynamic> metadata,
  ) {
    final positionSize = parseStringToDouble(fields.positionSize);
    final positionSizeFieldType = fields.positionSizeFieldType;
    final lotSize = parseStringToDouble(fields.lotSize);
    final updatedOn = metadata['updatedOn'] as String?;
    final formattedInstrumentExchangeRate =
        metadata['formattedInstrumentExchangeRate'] as String?;

    return [
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_account_currency.tr(),
        value: fields.accountCurrency.toString(),
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_financial_instrument.tr(),
        value: fields.formattedFinancialInstrument,
      ),
      if (formattedInstrumentExchangeRate != null)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_rate.tr(),
          value: revertSuperscripts(formattedInstrumentExchangeRate),
        ),
      if (updatedOn != null)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_last_updated_on.tr(),
          value: updatedOn,
        ),
      if (positionSize > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_position_size.tr(),
          value: localizeUnitSize(
            localeCode: FastAppSettingsBloc.instance.currentState.localeCode,
            unitKey: LinguaUnits.unit.name,
            value: positionSize,
          )!,
        ),
      if (lotSize > 0 &&
          positionSizeFieldType == MatexPositionSizeType.standard)
        FastReportEntry(
          name: FinanceForexLocaleKeys.forex_label_lot_standard.tr(),
          value: fields.formattedLotSize,
        ),
      if (lotSize > 0 && positionSizeFieldType == MatexPositionSizeType.mini)
        FastReportEntry(
          name: FinanceForexLocaleKeys.forex_label_lot_mini.tr(),
          value: fields.formattedLotSize,
        ),
      if (lotSize > 0 && positionSizeFieldType == MatexPositionSizeType.micro)
        FastReportEntry(
          name: FinanceForexLocaleKeys.forex_label_lot_micro.tr(),
          value: fields.formattedLotSize,
        ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_leverage.tr(),
        value: fields.formattedLeverage,
      ),
    ];
  }

  List<FastReportEntry> _buildResults(
    BuildContext context,
    MatexForexRequiredMarginCalculatorBlocFields fields,
    MatexForexRequiredMarginCalculatorBlocResults results,
  ) {
    final requiredMargin = results.requiredMargin;

    return [
      if (requiredMargin != null && requiredMargin > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_required_margin.tr(),
          value: results.formattedRequiredMargin!,
        ),
    ];
  }
}
