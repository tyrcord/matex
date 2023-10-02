// Flutter imports:
import 'package:fastyle_core/fastyle_core.dart';
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:flutter/material.dart';
import 'package:matex_core/core.dart';
import 'package:matex_data/matex_data.dart';
import 'package:t_helpers/helpers.dart';
import 'package:lingua_finance/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lingua_core/generated/locale_keys.g.dart';
import 'package:fastyle_forms/fastyle_forms.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

final _kDefaultVatBlocState = MatexVatCalculatorBlocState(
  fields: MatexVatCalculatorBlocFields(),
  results: const MatexVatCalculatorBlocResults(),
);

class MatexVatCalculatorBloc extends MatexCalculatorBloc<
    MatexVatCalculator,
    FastCalculatorBlocEvent,
    MatexVatCalculatorBlocState,
    MatexVatCalculatorBlocDocument,
    MatexVatCalculatorBlocResults> {
  MatexVatCalculatorBloc({
    MatexVatCalculatorBlocState? initialState,
    super.showExportPdfDialog,
    super.debouceComputeEvents,
    super.delegate,
  }) : super(
          dataProvider: MatexVatCalculatorDataProvider(),
          initialState: initialState ?? _kDefaultVatBlocState,
          debugLabel: 'MatexVatCalculatorBloc',
        ) {
    calculator = MatexVatCalculator();

    subxList.add(appSettingsBloc.onData
        .where((event) => isInitialized)
        .distinct((previous, next) {
      final previousValue = previous.countryCode;
      final nextValue = next.countryCode;

      return previousValue == nextValue;
    }).listen(handleUserCountryChanges));
  }

  /// Handles user's country changes.
  @protected
  void handleUserCountryChanges(FastAppSettingsBlocState state) {
    if (isInitialized) {
      addEvent(FastCalculatorBlocEvent.retrieveDefaultValues());

      if (state.countryCode == null) {
        addEvent(FastCalculatorBlocEvent.patchValue(
          key: MatexVatCalculatorBlocKey.vatRate,
          value: '',
        ));
      }
    }
  }

  @override
  Future<MatexVatCalculatorBlocResults> compute() async {
    final results = calculator.value();

    return MatexVatCalculatorBlocResults(
      totalTaxes: results.totalTaxes,
      total: results.total,
      tipAmount: results.tipAmount,
      grandTotal: results.grandTotal,
      tipRate: results.tipRate,
      subTotal: results.subTotal,
      discountAmount: results.discountAmount,
      discountRate: results.discountRate,
      customVatAmount: results.customVatAmount,
      federalVatAmount: results.federalVatAmount,
      regionalVatAmount: results.regionalVatAmount,
      vatAmount: results.vatAmount,
      formattedTotalTaxes: localizeCurrency(value: results.totalTaxes),
      formattedTotal: localizeCurrency(value: results.total),
      formattedTipAmount: localizeCurrency(value: results.tipAmount),
      formattedGrandTotal: localizeCurrency(value: results.grandTotal),
      formattedTipRate: localizePercentage(value: results.tipRate),
      formattedSubTotal: localizeCurrency(value: results.subTotal),
      formattedDiscountAmount: localizeCurrency(value: results.discountAmount),
      formattedDiscountRate: localizePercentage(value: results.discountRate),
      formattedCustomVatAmount: localizeCurrency(
        value: results.customVatAmount,
      ),
      formattedFederalVatAmount: localizeCurrency(
        value: results.federalVatAmount,
      ),
      formattedRegionalVatAmount: localizeCurrency(
        value: results.regionalVatAmount,
      ),
      formattedVatAmount: localizeCurrency(
        value: results.vatAmount,
      ),
    );
  }

  @override
  Future<MatexVatCalculatorBlocDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      final dValue = toDecimal(value) ?? dZero;
      final isNumber = isStringNumber(value) || value.isEmpty;

      if (dValue < dZero || !isNumber) return null;

      if (key == MatexVatCalculatorBlocKey.priceBeforeVat) {
        return document.copyWith(priceBeforeVat: value);
      } else if (key == MatexVatCalculatorBlocKey.customVatRate) {
        return document.copyWith(customVatRate: value);
      } else if (key == MatexVatCalculatorBlocKey.vatRate) {
        return document.copyWith(vatRate: value);
      } else if (key == MatexVatCalculatorBlocKey.federalVatRate) {
        return document.copyWith(federalVatRate: value);
      } else if (key == MatexVatCalculatorBlocKey.regionalVatRate) {
        return document.copyWith(regionalVatRate: value);
      } else if (key == MatexVatCalculatorBlocKey.discountAmount) {
        return document.copyWith(discountAmount: value, discountRate: '');
      } else if (key == MatexVatCalculatorBlocKey.tipAmount) {
        return document.copyWith(tipAmount: value, tipRate: '');
      } else if (key == MatexVatCalculatorBlocKey.tipRate) {
        return document.copyWith(tipRate: value, tipAmount: '');
      } else if (key == MatexVatCalculatorBlocKey.discountRate) {
        return document.copyWith(discountRate: value, discountAmount: '');
      }
    } else if (value is Enum) {
      value = describeEnum(value);

      if (key == MatexVatCalculatorBlocKey.tipFieldType) {
        return document.copyWith(
          tipFieldType: value.toString(),
          tipAmount: '',
          tipRate: '',
        );
      } else if (key == MatexVatCalculatorBlocKey.discountFieldType) {
        return document.copyWith(
          discountFieldType: value.toString(),
          discountAmount: '',
          discountRate: '',
        );
      }
    }

    return null;
  }

  @override
  Future<MatexVatCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      final dValue = toDecimal(value) ?? dZero;
      final isNumber = isStringNumber(value) || value.isEmpty;

      if (dValue < dZero || !isNumber) return null;

      if (key == MatexVatCalculatorBlocKey.priceBeforeVat) {
        return patchPriceBeforeVat(value);
      } else if (key == MatexVatCalculatorBlocKey.customVatRate) {
        return patchCustomVatRate(value);
      } else if (key == MatexVatCalculatorBlocKey.vatRate) {
        return patchVatRate(value);
      } else if (key == MatexVatCalculatorBlocKey.federalVatRate) {
        return patchFederalVatRate(value);
      } else if (key == MatexVatCalculatorBlocKey.regionalVatRate) {
        return patchRegionalVatRate(value);
      } else if (key == MatexVatCalculatorBlocKey.discountAmount) {
        return patchDiscountAmount(value);
      } else if (key == MatexVatCalculatorBlocKey.discountRate) {
        return patchDiscountRate(value);
      } else if (key == MatexVatCalculatorBlocKey.tipRate) {
        return patchTipRate(value);
      } else if (key == MatexVatCalculatorBlocKey.tipAmount) {
        return patchTipAmount(value);
      } else if (key == MatexVatCalculatorBlocKey.tipFieldType) {
        return patchTipFieldType(value);
      } else if (key == MatexVatCalculatorBlocKey.discountFieldType) {
        return patchDiscountFieldType(value);
      }
    } else if (value is Enum) {
      value = describeEnum(value);

      if (key == MatexVatCalculatorBlocKey.tipFieldType) {
        return patchTipFieldType(value);
      } else if (key == MatexVatCalculatorBlocKey.discountFieldType) {
        return patchDiscountFieldType(value);
      }
    }

    return currentState;
  }

  @override
  Future<void> resetCalculator(MatexVatCalculatorBlocDocument document) async {
    final vatRate = toDecimal(document.vatRate) ?? dZero;
    final customVatRate = toDecimal(document.customVatRate) ?? dZero;
    final tipRate = toDecimal(document.tipRate) ?? dZero;
    final discountRate = toDecimal(document.discountRate) ?? dZero;
    final federalVatRate = toDecimal(document.federalVatRate) ?? dZero;
    final regionalVatRate = toDecimal(document.regionalVatRate) ?? dZero;

    calculator.setState(MatexVatCalculatorState(
      priceBeforeVat: parseStringToDouble(document.priceBeforeVat),
      discountAmount: parseStringToDouble(document.discountAmount),
      tipAmount: parseStringToDouble(document.tipAmount),
      regionalVatRate: (regionalVatRate / dHundred).toDouble(),
      federalVatRate: (federalVatRate / dHundred).toDouble(),
      customVatRate: (customVatRate / dHundred).toDouble(),
      discountRate: (discountRate / dHundred).toDouble(),
      vatRate: (vatRate / dHundred).toDouble(),
      tipRate: (tipRate / dHundred).toDouble(),
    ));
  }

  @override
  Future<MatexVatCalculatorBlocState> resetCalculatorBlocState(
    MatexVatCalculatorBlocDocument document,
  ) async {
    return _kDefaultVatBlocState.copyWith(
      fields: document.toFields(),
    );
  }

  @override
  Future<MatexVatCalculatorBlocDocument>
      retrieveDefaultCalculatorDocument() async {
    final appSettingState = appSettingsBloc.currentState;
    final code = appSettingState.countryCode;

    if (code != null) {
      final future = MatexCountryBloc.instance.findOneByCountryCode(code);
      final countryMetadata = await future;

      if (countryMetadata != null &&
          countryMetadata.vatRates != null &&
          countryMetadata.vatRates!.isNotEmpty) {
        final value = formatDecimal(
          value: countryMetadata.vatRates![0],
          maximumFractionDigits: 2,
          minimumFractionDigits: 0,
        );

        return MatexVatCalculatorBlocDocument(vatRate: value);
      }
    }

    return MatexVatCalculatorBlocDocument();
  }

  @override
  Future<MatexVatCalculatorBlocResults> retrieveDefaultResult() async {
    return MatexVatCalculatorBlocResults(
      formattedTotal: localizeNumber(value: 0),
      total: 0,
    );
  }

  MatexVatCalculatorBlocState patchPriceBeforeVat(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(priceBeforeVat: value);
    calculator.priceBeforeVat = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchCustomVatRate(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(customVatRate: value);
    calculator.customVatRate = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchVatRate(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(vatRate: value);
    calculator.vatRate = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchFederalVatRate(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(federalVatRate: value);
    calculator.federalVatRate = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchRegionalVatRate(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(regionalVatRate: value);
    calculator.regionalVatRate = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchDiscountAmount(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(
      discountAmount: value,
      discountRate: '',
    );

    // also reset discount rate
    calculator.discountAmount = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchDiscountRate(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(
      discountRate: value,
      discountAmount: '',
    );

    // also reset discount amount
    calculator.discountRate = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchTipRate(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(
      tipRate: value,
      tipAmount: '',
    );

    // also reset tip amount
    calculator.tipRate = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchTipAmount(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(
      tipAmount: value,
      tipRate: '',
    );

    // also reset tip rate
    calculator.tipAmount = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchTipFieldType(dynamic value) {
    final fields = currentState.fields.copyWith(
      tipFieldType: value.toString(),
      tipAmount: '',
      tipRate: '',
    );

    // also reset tip rate
    calculator.tipAmount = 0;

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchDiscountFieldType(String value) {
    final fields = currentState.fields.copyWith(
      discountFieldType: value.toString(),
      discountAmount: '',
      discountRate: '',
    );

    // also reset discount rate
    calculator.discountAmount = 0;

    return currentState.copyWith(fields: fields);
  }

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final inputs = _buildInputReportEntries(context);
    final reporter = FastPdfCalculatorReporter();
    final appInfoBloc = FastAppInfoBloc();
    final appInfo = appInfoBloc.currentState;

    return reporter.report(
      alwaysUse24HourFormat: appSettingsBloc.currentState.alwaysUse24HourFormat,
      languageCode: appSettingsBloc.currentState.languageCode,
      countryCode: appInfo.deviceCountryCode,
      title: CoreLocaleKeys.core_label_report.tr(),
      categories: _buildCategoryEntries(context),
      categoryColumns: 3,
      results: [],
      inputs: inputs,
      subtitle: FinanceLocaleKeys.finance_label_vat_text.tr(),
      author: CoreLocaleKeys.core_message_pdf_generated_by.tr(namedArgs: {
        'app_name': appInfo.appName,
      }),
    );
  }

  List<FastReportEntry> _buildInputReportEntries(BuildContext context) {
    final fields = currentState.fields;
    final priceBeforeVat = parseFieldValueToDouble(fields.priceBeforeVat);
    final vatRate = parseFieldValueToDouble(fields.vatRate);
    final discountAmount = parseFieldValueToDouble(fields.discountAmount);
    final discountRate = parseFieldValueToDouble(fields.discountRate);
    final customVatRate = parseFieldValueToDouble(fields.customVatRate);
    final tipAmount = parseFieldValueToDouble(fields.tipAmount);
    final tipRate = parseFieldValueToDouble(fields.tipRate);

    return [
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_before_vat_price.tr(),
        value: localizeCurrency(value: priceBeforeVat),
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_vat_rate.tr(),
        value: '${localizeNumber(value: vatRate)}%',
      ),
      if (fields.discountFieldType == FastAmountSwitchFieldType.amount.name &&
          discountAmount > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_discount_amount.tr(),
          value: localizeCurrency(value: discountAmount),
        )
      else if (discountRate > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_discount_rate.tr(),
          value: '${localizeNumber(value: discountRate)}%',
        ),
      if (customVatRate > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_additional_tax_rate.tr(),
          value: '${localizeNumber(value: customVatRate)}%',
        ),
      if (fields.tipFieldType == FastAmountSwitchFieldType.amount.name &&
          tipAmount > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_tip_amount.tr(),
          value: localizeCurrency(value: tipAmount),
        )
      else if (tipRate > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_tip_rate.tr(),
          value: '${localizeNumber(value: tipRate)}%',
        ),
    ];
  }

  List<FastReportCategoryEntry> _buildCategoryEntries(BuildContext context) {
    final results = currentState.results;
    final fields = currentState.fields;
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
