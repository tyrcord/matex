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
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexVatCalculatorPdfGenerator {
  final appSettingsBloc = FastAppSettingsBloc();
  final appInfoBloc = FastAppInfoBloc();

  Future<Uint8List> generate(
    BuildContext context,
    MatexVatCalculatorBlocFields fields,
    MatexVatCalculatorBlocResults results,
  ) async {
    final reporter = FastPdfCalculatorReporter();
    final appInfo = appInfoBloc.currentState;

    return reporter.report(
      use24HourFormat: appSettingsBloc.currentState.use24HourFormat,
      subtitle: FinanceLocaleKeys.finance_label_vat_text.tr(),
      inputs: _buildInputReportEntries(context, fields, results),
      categories: _buildCategoryEntries(context, fields, results),
      languageCode: appSettingsBloc.currentState.languageCode,
      title: CoreLocaleKeys.core_label_report_text.tr(),
      countryCode: appInfo.deviceCountryCode,
      categoryColumns: 3,
      // FIXME: make optional
      results: [],
      author: CoreLocaleKeys.core_message_pdf_generated_by.tr(
        namedArgs: {
          'app_name': appInfo.appName,
        },
      ),
    );
  }

  List<FastReportEntry> _buildInputReportEntries(
    BuildContext context,
    MatexVatCalculatorBlocFields fields,
    MatexVatCalculatorBlocResults results,
  ) {
    final discountAmount = parseStringToDouble(fields.discountAmount);
    final discountRate = parseStringToDouble(fields.discountRate);
    final customVatRate = parseStringToDouble(fields.customVatRate);
    final tipAmount = parseStringToDouble(fields.tipAmount);
    final tipRate = parseStringToDouble(fields.tipRate);
    final discountFieldType = fields.discountFieldType;
    final tipFieldType = fields.tipFieldType;

    return [
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_before_vat_price.tr(),
        value: fields.formattedPriceBeforeVat,
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_vat_rate.tr(),
        value: fields.formattedVatRate,
      ),
      if (discountFieldType == FastAmountSwitchFieldType.amount.name &&
          discountAmount > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_discount_amount.tr(),
          value: fields.formattedDiscountAmount,
        )
      else if (discountFieldType == FastAmountSwitchFieldType.percent.name &&
          discountRate > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_discount_rate.tr(),
          value: fields.formattedDiscountRate,
        ),
      if (customVatRate > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_additional_tax_rate.tr(),
          value: fields.formattedCustomVatRate,
        ),
      if (tipFieldType == FastAmountSwitchFieldType.amount.name &&
          tipAmount > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_tip_amount.tr(),
          value: fields.formattedTipAmount,
        )
      else if (tipFieldType == FastAmountSwitchFieldType.percent.name &&
          tipRate > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_tip_rate.tr(),
          value: fields.formattedTipRate,
        ),
    ];
  }

  List<FastReportCategoryEntry> _buildCategoryEntries(
    BuildContext context,
    MatexVatCalculatorBlocFields fields,
    MatexVatCalculatorBlocResults results,
  ) {
    final palette = ThemeHelper.getPaletteColors(context);

    return [
      if (_shouldAddDiscountCategory(results))
        _buildDiscountCategory(results, fields, palette),
      if (_shouldAddTaxCategory(results))
        _buildTaxCategory(results, fields, palette),
      if (_shouldAddTipCategory(results))
        _buildTipCategory(results, fields, palette),
    ];
  }

  bool _shouldAddDiscountCategory(
    MatexVatCalculatorBlocResults results,
  ) {
    final discountAmount = results.discountAmount;
    final discountRate = results.discountRate;

    return discountAmount != null && discountAmount != 0 ||
        discountRate != null && discountRate != 0;
  }

  FastReportCategoryEntry _buildDiscountCategory(
    MatexVatCalculatorBlocResults results,
    MatexVatCalculatorBlocFields fields,
    FastPaletteColors palette,
  ) {
    final entries = <FastReportEntry>[];

    if (fields.discountFieldType == FastAmountSwitchFieldType.percent.name &&
        results.discountAmount != null &&
        results.discountAmount != 0) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_amount_text.tr(),
        value: results.formattedDiscountAmount!,
      ));
    }

    if (fields.discountFieldType == FastAmountSwitchFieldType.amount.name &&
        results.discountRate != null &&
        results.discountRate != 0) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_rate.tr(),
        value: results.formattedDiscountAmount!,
      ));
    }

    return FastReportCategoryEntry(
      name: FinanceLocaleKeys.finance_label_discount_label.tr(),
      entries: entries,
      summary: entries.isNotEmpty
          ? FastReportEntry(
              name: FinanceLocaleKeys.finance_label_subtotal.tr(),
              value: results.formattedSubTotal!,
            )
          : null,
    );
  }

  bool _shouldAddTaxCategory(
    MatexVatCalculatorBlocResults results,
  ) {
    final totalTaxes = results.totalTaxes;

    return totalTaxes != null && totalTaxes != 0;
  }

  FastReportCategoryEntry _buildTaxCategory(
    MatexVatCalculatorBlocResults results,
    MatexVatCalculatorBlocFields fields,
    FastPaletteColors palette,
  ) {
    final entries = <FastReportEntry>[];

    if (results.totalTaxes != null && results.totalTaxes != 0) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_amount_text.tr(),
        value: results.formattedTotalTaxes!,
        color: palette.red.mid,
      ));
    }

    return FastReportCategoryEntry(
      name: FinanceLocaleKeys.finance_label_taxes.tr(),
      entries: entries,
      summary: entries.isNotEmpty
          ? FastReportEntry(
              name: FinanceLocaleKeys.finance_label_total_text.tr(),
              value: results.formattedTotal!,
            )
          : null,
    );
  }

  bool _shouldAddTipCategory(
    MatexVatCalculatorBlocResults results,
  ) {
    final tipAmount = results.tipAmount;
    final tipRate = results.tipRate;

    return tipAmount != null && tipAmount != 0 ||
        tipRate != null && tipRate != 0;
  }

  FastReportCategoryEntry _buildTipCategory(
    MatexVatCalculatorBlocResults results,
    MatexVatCalculatorBlocFields fields,
    FastPaletteColors palette,
  ) {
    final entries = <FastReportEntry>[];

    if (fields.tipFieldType == FastAmountSwitchFieldType.percent.name &&
        results.tipAmount != null &&
        results.tipAmount != 0) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_amount_text.tr(),
        value: results.formattedTipAmount!,
      ));
    }

    if (fields.tipFieldType == FastAmountSwitchFieldType.amount.name &&
        results.tipRate != null &&
        results.tipRate != 0) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_rate.tr(),
        value: results.formattedTipRate!,
      ));
    }

    return FastReportCategoryEntry(
      name: FinanceLocaleKeys.finance_label_tip_text.tr(),
      entries: entries,
      summary: entries.isNotEmpty
          ? FastReportEntry(
              name: FinanceLocaleKeys.finance_label_grand_total.tr(),
              value: results.formattedGrandTotal!,
            )
          : null,
    );
  }
}
