// Dart imports:
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:fastyle_forms/fastyle_forms.dart';
import 'package:lingua_core/generated/locale_keys.g.dart';
import 'package:lingua_finance/generated/locale_keys.g.dart';
import 'package:lingua_finance_stock/generated/locale_keys.g.dart';
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexStockPositionSizeCalculatorPdfGenerator {
  final appSettingsBloc = FastAppSettingsBloc();
  final appInfoBloc = FastAppInfoBloc();

  Future<Uint8List> generate(
    BuildContext context,
    MatexStockPositionSizeCalculatorBlocFields fields,
    MatexStockPositionSizeCalculatorBlocResults results,
  ) async {
    final reporter = FastPdfCalculatorReporter();
    final appInfo = appInfoBloc.currentState;

    return reporter.report(
      title: CoreLocaleKeys.core_label_report_text.tr(),
      disclaimerText:
          FinanceLocaleKeys.finance_disclaimer_intervening_markets.tr(),
      inputs: _buildInputReportEntries(context, fields, results),
      results: _buildResultReportEntries(context, fields, results),
      subtitle: FinanceLocaleKeys.finance_label_position_size.tr(),
      author: CoreLocaleKeys.core_message_pdf_generated_by.tr(
        namedArgs: {'app_name': appInfo.appName},
      ),
      categories: _buildCategoryEntries(context, fields, results),
      use24HourFormat: appSettingsBloc.currentState.use24HourFormat,
      languageCode: appSettingsBloc.currentState.languageCode,
      countryCode: appInfo.deviceCountryCode,
    );
  }

  List<FastReportEntry> _buildInputReportEntries(
    BuildContext context,
    MatexStockPositionSizeCalculatorBlocFields fields,
    MatexStockPositionSizeCalculatorBlocResults results,
  ) {
    final riskReward = parseStringToDouble(fields.riskReward);
    final entryFees = parseStringToDouble(fields.entryFees);
    final exitFees = parseStringToDouble(fields.exitFees);
    final slippage = parseStringToDouble(fields.slippagePercent);
    final takeProfitPrice = parseStringToDouble(fields.takeProfitPrice);

    return [
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_account_balance.tr(),
        value: fields.formattedAccountSize,
      ),
      if (fields.riskFieldType == FastAmountSwitchFieldType.amount.name)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_amount_at_risk.tr(),
          value: fields.formattedStopLossAmount,
        )
      else
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_risk_text.tr(),
          value: fields.formattedRiskPercent,
        ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_position_text.tr(),
        value: fields.formattedPosition,
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_entry_price_at.tr(),
        value: fields.formattedEntryPrice,
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_stop_loss_at.tr(),
        value: fields.formattedStopLossPrice,
      ),
      if (riskReward > 0 && fields.takeProfitFieldType == 'riskReward')
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_risk_reward_ratio.tr(),
          value: fields.formattedRiskReward,
        )
      else if (takeProfitPrice > 0 && fields.takeProfitFieldType == 'price')
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_take_profit_at.tr(),
          value: fields.formattedTakeProfitPrice,
        ),
      if (entryFees > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_entry_fees_text.tr(),
          value: fields.formattedEntryFees,
        ),
      if (exitFees > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_exit_fees_text.tr(),
          value: fields.formattedExitFees,
        ),
      if (slippage > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_slippage.tr(),
          value: fields.formattedSlippagePercent,
        ),
    ];
  }

  List<FastReportEntry> _buildResultReportEntries(
    BuildContext context,
    MatexStockPositionSizeCalculatorBlocFields fields,
    MatexStockPositionSizeCalculatorBlocResults results,
  ) {
    final palette = ThemeHelper.getPaletteColors(context);

    return [
      FastReportEntry(
        name: FinanceStockLocaleKeys.stock_label_stock.tr(),
        value: results.formattedShares.toString(),
        color: palette.indigo.mid,
      ),
      if (results.positionAmount != null && results.positionAmount != 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_position_amount.tr(),
          value: results.formattedPositionAmount!,
          color: palette.blueGray.mid,
        ),
    ];
  }

  /// Builds a list of [FastReportCategoryEntry] objects based on the current
  /// state and context.
  ///
  /// The function retrieves the necessary data from the [currentState] and
  /// [fields] objects and initializes the [palette] using the
  /// [ThemeHelper.getPaletteColors] method. It constructs a list of
  /// [FastReportCategoryEntry] objects representing different categories in the
  /// report, based on certain conditions and data.
  ///
  /// Returns a list of [FastReportCategoryEntry] objects.
  List<FastReportCategoryEntry> _buildCategoryEntries(
    BuildContext context,
    MatexStockPositionSizeCalculatorBlocFields fields,
    MatexStockPositionSizeCalculatorBlocResults results,
  ) {
    final palette = ThemeHelper.getPaletteColors(context);

    return [
      if (_shouldAddRiskCategory(results))
        _buildRiskCategory(results, fields, palette),
      if (_shouldAddEntryCategory(results, fields))
        _buildEntryCategory(results, fields),
      if (_shouldAddTakeProfitCategory(results))
        _buildTakeProfitCategory(results, fields, palette),
      if (_shouldAddStopLossCategory(results))
        _buildStopLossCategory(results, fields, palette),
    ];
  }

  bool _shouldAddRiskCategory(
    MatexStockPositionSizeCalculatorBlocResults results,
  ) {
    final effectiveRisk = results.effectiveRisk;

    return effectiveRisk != null && effectiveRisk != 0;
  }

  /// Builds the "Risk" category of the report.
  ///
  /// The function takes [results], [fields], and [palette] as parameters and
  /// constructs a [FastReportCategoryEntry] object representing the "Risk"
  /// category. The category contains entries such as "Involved Capital", "Risk
  /// Percent", "Tolerated Risk", and "Effective Risk", based on certain
  /// conditions and values.
  ///
  /// Returns a [FastReportCategoryEntry] object representing the "Risk"
  /// category.
  FastReportCategoryEntry _buildRiskCategory(
    MatexStockPositionSizeCalculatorBlocResults results,
    MatexStockPositionSizeCalculatorBlocFields fields,
    FastPaletteColors palette,
  ) {
    final entries = <FastReportEntry>[];

    if (results.involvedCapital != null && results.involvedCapital != 0) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_involved_capital.tr(),
        value: results.formattedInvolvedCapital!,
      ));
    }

    if (results.riskPercent != null &&
        results.riskPercent != 0 &&
        fields.riskFieldType != FastAmountSwitchFieldType.percent.name) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_risk_in_percentage.tr(),
        value: results.formattedRiskPercent!,
      ));
    }

    if (results.toleratedRisk != null &&
        results.toleratedRisk != 0 &&
        fields.riskFieldType != FastAmountSwitchFieldType.amount.name) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_risk_tolerated.tr(),
        value: results.formattedToleratedRisk!,
        color: results.toleratedRisk == results.effectiveRisk
            ? palette.red.mid
            : null,
      ));
    }

    if (results.effectiveRisk != null &&
        results.effectiveRisk != 0 &&
        results.effectiveRisk != results.toleratedRisk) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_risk_effective.tr(),
        value: results.formattedEffectiveRisk!,
        color: palette.red.mid,
      ));
    }

    return FastReportCategoryEntry(
      name: FinanceLocaleKeys.finance_label_risk_text.tr(),
      entries: entries,
    );
  }

  /// Checks if the "Entry" category should be added to the report.
  ///
  /// The function takes [results] and [fields] as parameters and checks if the
  /// "Entry" category should be added based on certain conditions and values.
  ///
  /// Returns a boolean value indicating whether the "Entry" category should be
  /// added.
  bool _shouldAddEntryCategory(
    MatexStockPositionSizeCalculatorBlocResults results,
    MatexStockPositionSizeCalculatorBlocFields fields,
  ) {
    final entryPrice = results.entryPriceWithSlippage;
    final entryFeeAmount = results.entryFeeAmount;
    final slippagePercent = fields.slippagePercent;
    final dSlippagePercent = parseStringToDouble(slippagePercent);

    return (entryFeeAmount != null && entryFeeAmount > 0) ||
        (entryPrice != null && entryPrice > 0 && dSlippagePercent != 0);
  }

  /// Builds the "Entry" category of the report.
  ///
  /// The function takes [results] and [fields] as parameters and constructs a
  /// [FastReportCategoryEntry] object representing the "Entry" category. The
  /// category contains entries such as "Entry Price with Slippage" and
  /// "Entry Fee Amount", based on certain conditions and values.
  ///
  /// Returns a [FastReportCategoryEntry] object representing the "Entry"
  /// category.
  FastReportCategoryEntry _buildEntryCategory(
    MatexStockPositionSizeCalculatorBlocResults results,
    MatexStockPositionSizeCalculatorBlocFields fields,
  ) {
    final entries = <FastReportEntry>[];

    if (results.entryPriceWithSlippage != null &&
        results.entryPriceWithSlippage != 0 &&
        fields.slippagePercent != null &&
        fields.slippagePercent!.isNotEmpty) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_entry_price_with_slippage.tr(),
        value: results.formattedEntryPriceWithSlippage!,
      ));
    }

    if (results.entryFeeAmount != null && results.entryFeeAmount != 0) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_entry_fees_amount.tr(),
        value: results.formattedEntryFeeAmount!,
      ));
    }

    return FastReportCategoryEntry(
      name: FinanceLocaleKeys.finance_label_entry_text.tr(),
      entries: entries,
    );
  }

  bool _shouldAddStopLossCategory(
    MatexStockPositionSizeCalculatorBlocResults results,
  ) {
    final stopLossPrice = results.stopLossPriceWithSlippage;

    return stopLossPrice != null && stopLossPrice != 0;
  }

  /// Builds the "Stop Loss" category of the report.
  ///
  /// The function takes [results], [fields], and [palette] as parameters and
  /// constructs a [FastReportCategoryEntry] object representing the "Stop Loss"
  /// category. The category contains entries such as "Stop Loss Price with
  /// Slippage", "Stop Loss Percent", "Stop Loss Percent with Slippage", "Stop
  /// Loss Fee Amount", and "Total Fees for Loss Position", based on certain
  /// conditions and values.
  ///
  /// Returns a [FastReportCategoryEntry] object representing the "Stop Loss"
  /// category.
  FastReportCategoryEntry _buildStopLossCategory(
    MatexStockPositionSizeCalculatorBlocResults results,
    MatexStockPositionSizeCalculatorBlocFields fields,
    FastPaletteColors palette,
  ) {
    final entries = <FastReportEntry>[];

    if (results.stopLossPriceWithSlippage != null &&
        results.stopLossPriceWithSlippage != 0 &&
        fields.slippagePercent != null &&
        fields.slippagePercent!.isNotEmpty) {
      final slippagePercent = fields.slippagePercent;
      final dSlippagePercent = parseStringToDouble(slippagePercent);

      if (dSlippagePercent != 0) {
        entries.add(FastReportEntry(
          name: FinanceLocaleKeys.finance_label_stop_loss_price_with_slippage
              .tr(),
          value: results.formattedStopLossPriceWithSlippage!,
        ));
      }
    }

    if (results.stopLossPercent != null && results.stopLossPercent != 0) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_stop_loss_in_percentage_text.tr(),
        value: results.formattedStopLossPercent!,
      ));
    }

    if (results.stopLossPercentWithSlippage != null &&
        results.stopLossPercentWithSlippage != 0 &&
        results.stopLossPercent != results.stopLossPercentWithSlippage) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys
            .finance_label_stop_loss_in_percentage_with_slippage
            .tr(),
        value: results.formattedStopLossPercentWithSlippage!,
      ));
    }

    if (results.stopLossFeeAmount != null && results.stopLossFeeAmount != 0) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_amount_fee.tr(),
        value: results.formattedStopLossFeeAmount!,
      ));
    }

    if (results.totalFeesForLossPosition != null &&
        results.totalFeesForLossPosition != 0 &&
        results.totalFeesForLossPosition != results.stopLossFeeAmount) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_total_costs_losing_position.tr(),
        value: results.formattedTotalFeesForLossPosition!,
        color: palette.orange.mid,
      ));
    }

    return FastReportCategoryEntry(
      name: FinanceLocaleKeys.finance_label_stop_loss_text.tr(),
      entries: entries,
    );
  }

  bool _shouldAddTakeProfitCategory(
    MatexStockPositionSizeCalculatorBlocResults results,
  ) {
    final takeProfitPrice = results.takeProfitPrice;
    final takeProfitAmount = results.takeProfitAmount;

    return takeProfitPrice != null &&
        takeProfitAmount != null &&
        takeProfitPrice > 0 &&
        takeProfitAmount > 0;
  }

  /// Builds the "Take Profit" category of the report.
  ///
  /// The function takes [results], [fields], and [palette] as parameters and
  /// constructs a [FastReportCategoryEntry] object representing the
  /// "Take Profit" category. The category contains entries such as
  /// "Take Profit Amount", "Take Profit Price", "Take Profit Fee Amount", and
  /// "Total Fees for Profit Position", based on certain conditions and values.
  ///
  /// Returns a [FastReportCategoryEntry] object representing the "Take Profit"
  /// category.
  FastReportCategoryEntry _buildTakeProfitCategory(
    MatexStockPositionSizeCalculatorBlocResults results,
    MatexStockPositionSizeCalculatorBlocFields fields,
    FastPaletteColors palette,
  ) {
    final entries = <FastReportEntry>[];

    if (results.takeProfitAmount != null && results.takeProfitAmount != 0) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_take_profit_amount.tr(),
        value: results.formattedTakeProfitAmount!,
        color: results.takeProfitAmount == results.takeProfitAmountAfterFee
            ? palette.green.mid
            : null,
      ));
    }

    if (results.takeProfitPrice != null &&
        results.takeProfitPrice != 0 &&
        fields.takeProfitFieldType == 'riskReward') {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_take_profit_price_at.tr(),
        value: results.formattedTakeProfitPrice!,
      ));
    }

    if (results.riskRewardRatio != null &&
        results.riskRewardRatio != 0 &&
        fields.takeProfitFieldType == 'price') {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_risk_reward_ratio.tr(),
        value: results.formattedRiskRewardRatio!,
      ));
    }

    if (results.returnOnCapital != null && results.returnOnCapital != 0) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_return_on_capital.tr(),
        value: results.formattedReturnOnCapital!,
        color: palette.green.mid,
      ));
    }

    if (results.takeProfitFeeAmount != null &&
        results.takeProfitFeeAmount != 0) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_amount_fee.tr(),
        value: results.formattedTakeProfitFeeAmount!,
      ));
    }

    if (results.takeProfitAmountAfterFee != null &&
        results.takeProfitAmountAfterFee != 0 &&
        results.takeProfitAmount != results.takeProfitAmountAfterFee) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_take_profit_price_after_fee.tr(),
        value: results.formattedTakeProfitAmountAfterFee!,
        color: palette.green.mid,
      ));
    }

    if (results.totalFeesForProfitPosition != null &&
        results.totalFeesForProfitPosition != 0 &&
        results.takeProfitFeeAmount != results.totalFeesForProfitPosition) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_total_costs_profit_position.tr(),
        value: results.formattedTotalFeesForProfitPosition!,
        color: palette.orange.mid,
      ));
    }

    return FastReportCategoryEntry(
      name: FinanceLocaleKeys.finance_label_take_profit_text.tr(),
      entries: entries,
    );
  }
}
