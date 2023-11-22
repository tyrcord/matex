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
import 'package:t_helpers/helpers.dart';
import 'package:fastyle_forms/fastyle_forms.dart';
import 'package:fastyle_financial/fastyle_financial.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexPositionSizeCalculatorPdfGenerator {
  final appSettingsBloc = FastAppSettingsBloc();
  final appInfoBloc = FastAppInfoBloc();

  Future<Uint8List> generate(
    BuildContext context,
    MatexForexPositionSizeCalculatorBlocFields fields,
    MatexForexPositionSizeCalculatorBlocResults results,
    Map<String, dynamic> metadata,
  ) async {
    final reporter = FastPdfCalculatorReporter();
    final appInfo = appInfoBloc.currentState;

    return reporter.report(
      use24HourFormat: appSettingsBloc.currentState.use24HourFormat,
      subtitle: FinanceLocaleKeys.finance_label_position_size.tr(),
      disclaimerText:
          FinanceLocaleKeys.finance_disclaimer_intervening_markets.tr(),
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
    MatexForexPositionSizeCalculatorBlocFields fields,
    MatexForexPositionSizeCalculatorBlocResults results,
    Map<String, dynamic> metadata,
  ) {
    final updatedOn = metadata['updatedOn'] as String?;
    final formattedInstrumentExchangeRate =
        metadata['formattedInstrumentExchangeRate'] as String?;
    final accountSize = fields.accountSize;

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
      if (accountSize != null)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_account_balance.tr(),
          value: fields.formattedAccountSize,
        ),
      if (fields.riskFieldType == FastAmountSwitchFieldType.amount.name)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_amount_at_risk.tr(),
          value: fields.formattedRiskAmount,
        )
      else
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_risk_text.tr(),
          value: fields.formattedRiskPercent,
        ),
      if (fields.stopLossFieldType ==
          FastFinancialAmountSwitchFieldType.price.name)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_entry_price_at.tr(),
          value: fields.formattedEntryPrice,
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
    ];
  }

  List<FastReportEntry> _buildResults(
    BuildContext context,
    MatexForexPositionSizeCalculatorBlocFields fields,
    MatexForexPositionSizeCalculatorBlocResults results,
  ) {
    final positionSize = results.positionSize;
    final standardLotSize = results.standardLotSize;
    final microLotSize = results.microLotSize;
    final miniLotSize = results.miniLotSize;
    final riskRatio = results.riskRatio;
    final amountAtRisk = results.amountAtRisk;
    final stopLossPips = results.stopLossPips;
    final stopLossPrice = results.stopLossPrice;
    final pipValue = results.pipValue;
    final stopLossFieldType = fields.stopLossFieldType;
    final riskFieldType = fields.riskFieldType;

    return [
      if (positionSize != null && positionSize > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_position_size.tr(),
          value: results.formattedPositionSize!,
        ),
      if (standardLotSize != null && standardLotSize > 0)
        FastReportEntry(
          name: FinanceForexLocaleKeys.forex_label_lot_standard.tr(),
          value: results.formattedStandardLotSize!,
        ),
      if (miniLotSize != null && miniLotSize > 0)
        FastReportEntry(
          name: FinanceForexLocaleKeys.forex_label_lot_mini.tr(),
          value: results.formattedMiniLotSize!,
        ),
      if (microLotSize != null && microLotSize > 0)
        FastReportEntry(
          name: FinanceForexLocaleKeys.forex_label_lot_micro.tr(),
          value: results.formattedMicroLotSize!,
        ),
      if (riskRatio != null &&
          riskRatio > 0 &&
          riskFieldType == FastAmountSwitchFieldType.amount.name)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_risk_ratio.tr(),
          value: results.formattedRiskRatio!,
        ),
      if (amountAtRisk != null &&
          amountAtRisk > 0 &&
          riskFieldType == FastAmountSwitchFieldType.percent.name)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_amount_at_risk.tr(),
          value: results.formattedAmountAtRisk!,
        ),
      if (stopLossPips != null &&
          stopLossPips > 0 &&
          stopLossFieldType == FastFinancialAmountSwitchFieldType.price.name)
        FastReportEntry(
          name: FinanceForexLocaleKeys.forex_label_stop_loss_pips.tr(),
          value: results.formattedStopLossPips!,
        ),
      if (stopLossPrice != null &&
          stopLossPrice > 0 &&
          stopLossFieldType == FastFinancialAmountSwitchFieldType.pip.name)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_stop_loss_price_text.tr(),
          value: results.formattedStopLossPips!,
        ),
      if (pipValue != null && pipValue > 0)
        FastReportEntry(
          name: FinanceForexLocaleKeys.forex_label_pip_value.tr(),
          value: results.formattedPipValue!,
        ),
    ];
  }
}
