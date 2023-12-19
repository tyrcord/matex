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
import 'package:t_helpers/helpers.dart';
import 'package:lingua_units/lingua_units.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexStopLossTakeProfitCalculatorPdfGenerator {
  final appSettingsBloc = FastAppSettingsBloc();
  final appInfoBloc = FastAppInfoBloc();

  Future<Uint8List> generate(
    BuildContext context,
    MatexForexStopLossTakeProfitCalculatorBlocFields fields,
    MatexForexStopLossTakeProfitCalculatorBlocResults results,
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
    MatexForexStopLossTakeProfitCalculatorBlocFields fields,
    MatexForexStopLossTakeProfitCalculatorBlocResults results,
    Map<String, dynamic> metadata,
  ) {
    final positionSize = parseFieldValueToDouble(fields.positionSize);
    final positionSizeFieldType = fields.positionSizeFieldType;
    final lotSize = parseFieldValueToDouble(fields.lotSize);
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
    ];
  }

  List<FastReportEntry> _buildResults(
    BuildContext context,
    MatexForexStopLossTakeProfitCalculatorBlocFields fields,
    MatexForexStopLossTakeProfitCalculatorBlocResults results,
  ) {
    final pipValue = results.pipValue;
    final takeProfitPrice = results.takeProfitPrice;
    final takeProfitPips = results.takeProfitPips;
    final takeProfitAmount = results.takeProfitAmount;
    final stopLossPrice = results.stopLossPrice;
    final stopLossPips = results.stopLossPips;
    final stopLossAmount = results.stopLossAmount;
    final riskRewardRatio = results.riskRewardRatio;

    return [
      if (pipValue != null && pipValue > 0)
        FastReportEntry(
          name: FinanceForexLocaleKeys.forex_label_pip_value.tr(),
          value: results.formattedPipValue!,
        ),
      if (takeProfitPrice != null)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_take_profit_at.tr(),
          value: results.formattedTakeProfitPrice!,
        ),
      if (takeProfitPips != null)
        FastReportEntry(
          name: FinanceForexLocaleKeys.forex_label_take_profit_pips.tr(),
          value: results.formattedTakeProfitPips!,
        ),
      if (takeProfitAmount != null)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_take_profit_amount.tr(),
          value: results.formattedTakeProfitAmount!,
        ),
      if (stopLossPrice != null)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_stop_loss_at.tr(),
          value: results.formattedStopLossPrice!,
        ),
      if (stopLossPips != null)
        FastReportEntry(
          name: FinanceForexLocaleKeys.forex_label_stop_loss_pips.tr(),
          value: results.formattedStopLossPips!,
        ),
      if (stopLossAmount != null)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_stop_loss_amount.tr(),
          value: results.formattedStopLossAmount!,
        ),
      if (riskRewardRatio != null)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_risk_reward_ratio.tr(),
          value: results.formattedRiskRewardRatio!,
        ),
    ];
  }
}
