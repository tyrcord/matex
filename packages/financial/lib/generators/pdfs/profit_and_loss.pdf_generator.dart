import 'dart:typed_data';

import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:fastyle_forms/fastyle_forms.dart';
import 'package:flutter/widgets.dart';
import 'package:lingua_core/generated/locale_keys.g.dart';
import 'package:lingua_finance/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexProfitAndLossCalculatorPdfGenerator {
  final appSettingsBloc = FastAppSettingsBloc();
  final appInfoBloc = FastAppInfoBloc();

  Future<Uint8List> generate(
    BuildContext context,
    MatexProfitAndLossCalculatorBlocFields fields,
    MatexProfitAndLossCalculatorBlocResults results,
  ) async {
    final reporter = FastPdfCalculatorReporter();
    final appInfo = appInfoBloc.currentState;

    return reporter.report(
      alwaysUse24HourFormat: appSettingsBloc.currentState.alwaysUse24HourFormat,
      subtitle: FinanceLocaleKeys.finance_label_profit_and_loss.tr(),
      inputs: _buildInputReportEntries(context, fields, results),
      languageCode: appSettingsBloc.currentState.languageCode,
      title: CoreLocaleKeys.core_label_report_text.tr(),
      results: _buildResults(context, fields, results),
      countryCode: appInfo.deviceCountryCode,
      categoryColumns: 3,
      author: CoreLocaleKeys.core_message_pdf_generated_by.tr(
        namedArgs: {
          'app_name': appInfo.appName,
        },
      ),
    );
  }

  List<FastReportEntry> _buildInputReportEntries(
    BuildContext context,
    MatexProfitAndLossCalculatorBlocFields fields,
    MatexProfitAndLossCalculatorBlocResults results,
  ) {
    final operatingExpenses = parseFieldValueToDouble(fields.operatingExpenses);
    final buyingExpensePerUnitAmount = parseFieldValueToDouble(
      fields.buyingExpensePerUnitAmount,
    );
    final buyingExpensePerUnitRate = parseFieldValueToDouble(
      fields.buyingExpensePerUnitRate,
    );
    final sellingExpensePerUnitAmount = parseFieldValueToDouble(
      fields.sellingExpensePerUnitAmount,
    );
    final sellingExpensePerUnitRate = parseFieldValueToDouble(
      fields.sellingExpensePerUnitRate,
    );
    final taxRate = parseFieldValueToDouble(fields.taxRate);
    final sellingCostsPerUnitType = fields.sellingCostsPerUnitType;
    final buyingCostsPerUnitType = fields.buyingCostsPerUnitType;

    return [
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_buy_price.tr(),
        value: fields.formattedBuyingPrice,
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_sell_price.tr(),
        value: fields.formattedSellingPrice,
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_expected_sale_units.tr(),
        value: fields.formattedExpectedSaleUnits,
      ),
      if (operatingExpenses > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_operating_expenses.tr(),
          value: fields.formattedOperatingExpenses,
        ),
      if (buyingCostsPerUnitType == FastAmountSwitchFieldType.amount.name &&
          buyingExpensePerUnitAmount > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_buy_costs_per_unit.tr(),
          value: fields.formattedBuyingExpensePerUnitAmount,
        ),
      if (buyingCostsPerUnitType == FastAmountSwitchFieldType.percent.name &&
          buyingExpensePerUnitRate > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_buy_costs_per_unit.tr(),
          value: fields.formattedBuyingExpensePerUnitRate,
        ),
      if (sellingCostsPerUnitType == FastAmountSwitchFieldType.amount.name &&
          sellingExpensePerUnitAmount > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_sell_costs_per_unit.tr(),
          value: fields.formattedSellingExpensePerUnitAmount,
        ),
      if (sellingCostsPerUnitType == FastAmountSwitchFieldType.percent.name &&
          sellingExpensePerUnitRate > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_sell_costs_per_unit.tr(),
          value: fields.formattedSellingExpensePerUnitRate,
        ),
      if (taxRate > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_risk_reward_ratio.tr(),
          value: fields.formattedTaxRate,
        ),
    ];
  }

  List<FastReportEntry> _buildResults(
    BuildContext context,
    MatexProfitAndLossCalculatorBlocFields fields,
    MatexProfitAndLossCalculatorBlocResults results,
  ) {
    final revenue = results.revenue;
    final costOfGoodsSold = results.costOfGoodsSold;
    final grossProfit = results.grossProfit;
    final sellingExpenses = results.sellingExpenses;
    final operatingProfit = results.operatingProfit;
    final taxAmount = results.taxAmount;
    final netProfit = results.netProfit;
    final returnOnInvestment = results.returnOnInvestment;
    final breakEvenUnits = results.breakEvenUnits;

    return [
      // Revenue
      if (revenue != null && revenue != 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_revenue.tr(),
          value: results.formattedRevenue!,
        ),
      // Cost of goods sold
      if (costOfGoodsSold != null && costOfGoodsSold != 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_cost_of_goods_sold.tr(),
          value: results.formattedCostOfGoodsSold!,
        ),
      // Gross profit
      if (grossProfit != null && grossProfit != 0 && netProfit != grossProfit)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_gross_profit.tr(),
          value: results.formattedGrossProfit!,
        ),
      // Selling expenses
      if (sellingExpenses != null && sellingExpenses != 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_selling_operating_expenses.tr(),
          value: results.formattedSellingExpenses!,
        ),
      // Operating profit
      if (operatingProfit != null &&
          operatingProfit != 0 &&
          operatingProfit != netProfit &&
          operatingProfit != grossProfit)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_operating_profit.tr(),
          value: results.formattedOperatingProfit!,
        ),
      // Tax amount
      if (taxAmount != null && taxAmount != 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_tax_amount.tr(),
          value: results.formattedTaxAmount!,
        ),
      // Net profit
      if (netProfit != null && netProfit != 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_net_profit_text.tr(),
          value: results.formattedNetProfit!,
          color: getColorBasedOnValue(context, netProfit),
        ),

      // Return on investment
      if (returnOnInvestment != null && returnOnInvestment != 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_return_on_investment.tr(),
          value: results.formattedReturnOnInvestment!,
          color: getColorBasedOnValue(context, returnOnInvestment),
        ),
      if (breakEvenUnits != null && breakEvenUnits != 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_break_even_units.tr(),
          value: results.formattedBreakEvenUnits!,
        ),
    ];
  }
}
