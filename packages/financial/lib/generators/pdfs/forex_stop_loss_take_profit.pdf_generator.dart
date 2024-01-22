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
    final positionSize = parseStringToDouble(fields.positionSize);
    final positionSizeFieldType = fields.positionSizeFieldType;
    final lotSize = parseStringToDouble(fields.lotSize);
    final entryPrice = parseStringToDouble(fields.entryPrice);
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
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_position_text.tr(),
        value: fields.formattedPosition,
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
      if (entryPrice > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_entry_price_at.tr(),
          value: fields.formattedEntryPrice,
        ),
      if (fields.stopLossFieldType ==
          FastFinancialAmountSwitchFieldType.amount.name)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_amount_at_risk.tr(),
          value: fields.formattedStopLossAmount,
        ),
      if (fields.stopLossFieldType ==
          FastFinancialAmountSwitchFieldType.price.name)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_stop_loss_at.tr(),
          value: fields.formattedStopLossPrice,
        ),
      if (fields.stopLossFieldType ==
          FastFinancialAmountSwitchFieldType.pip.name)
        FastReportEntry(
          name: FinanceForexLocaleKeys.forex_label_stop_loss_pips.tr(),
          value: fields.formattedStopLossPips,
        ),
      if (fields.takeProfitFieldType ==
          FastFinancialAmountSwitchFieldType.amount.name)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_take_profit_amount.tr(),
          value: fields.formattedTakeProfitAmount,
        ),
      if (fields.takeProfitFieldType ==
          FastFinancialAmountSwitchFieldType.price.name)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_take_profit_at.tr(),
          value: fields.formattedTakeProfitPrice,
        ),
      if (fields.takeProfitFieldType ==
          FastFinancialAmountSwitchFieldType.pip.name)
        FastReportEntry(
          name: FinanceForexLocaleKeys.forex_label_take_profit_pips.tr(),
          value: fields.formattedTakeProfitPips,
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
    final stopLossFieldType = fields.stopLossFieldType;
    final takeProfitFieldType = fields.takeProfitFieldType;

    return [
      if (riskRewardRatio != null && riskRewardRatio != 0)
        FastReportEntry(
          color: getRiskRewardRatioColorForValue(context, riskRewardRatio),
          name: FinanceLocaleKeys.finance_label_risk_reward_ratio.tr(),
          value: results.formattedRiskRewardRatio!,
        ),
      if (takeProfitAmount != null &&
          takeProfitAmount != 0 &&
          takeProfitFieldType != FastFinancialAmountSwitchFieldType.amount.name)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_take_profit_amount.tr(),
          color: getColorBasedOnValue(context, takeProfitAmount),
          value: results.formattedTakeProfitAmount!,
        ),
      if (takeProfitPrice != null &&
          takeProfitPrice != 0 &&
          takeProfitFieldType != FastFinancialAmountSwitchFieldType.price.name)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_take_profit_at.tr(),
          color: getColorBasedOnValue(context, takeProfitPrice),
          value: results.formattedTakeProfitPrice!,
        ),
      if (takeProfitPips != null &&
          takeProfitPips != 0 &&
          takeProfitFieldType != FastFinancialAmountSwitchFieldType.pip.name)
        FastReportEntry(
          name: FinanceForexLocaleKeys.forex_label_take_profit_pips.tr(),
          color: getColorBasedOnValue(context, takeProfitPips),
          value: results.formattedTakeProfitPips!,
        ),
      if (pipValue != null && pipValue != 0)
        FastReportEntry(
          name: FinanceForexLocaleKeys.forex_label_pip_value.tr(),
          value: results.formattedPipValue!,
        ),
      if (stopLossAmount != null &&
          stopLossAmount != 0 &&
          stopLossFieldType != FastFinancialAmountSwitchFieldType.amount.name)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_stop_loss_amount.tr(),
          color: getColorBasedOnValue(context, -stopLossAmount),
          value: results.formattedStopLossAmount!,
        ),
      if (stopLossPrice != null &&
          stopLossPrice != 0 &&
          stopLossFieldType != FastFinancialAmountSwitchFieldType.price.name)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_stop_loss_at.tr(),
          color: getColorBasedOnValue(context, -stopLossPrice),
          value: results.formattedStopLossPrice!,
        ),
      if (stopLossPips != null &&
          stopLossPips != 0 &&
          stopLossFieldType != FastFinancialAmountSwitchFieldType.pip.name)
        FastReportEntry(
          name: FinanceForexLocaleKeys.forex_label_stop_loss_pips.tr(),
          color: getColorBasedOnValue(context, -stopLossPips),
          value: results.formattedStopLossPips!,
        ),
    ];
  }
}
