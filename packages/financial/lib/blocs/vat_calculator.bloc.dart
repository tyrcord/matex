// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:matex_core/core.dart';
import 'package:matex_data/matex_data.dart';
import 'package:t_helpers/helpers.dart';

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
    super.exportAlternativeAction,
    super.debouceComputeEvents = true,
    super.getExportDialog,
    super.delegate,
    super.getContext,
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
      priceBeforeVat: results.priceBeforeVat,
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
      formattedPriceBeforeVat: localizeCurrency(value: results.priceBeforeVat),
      formattedVatAmount: localizeCurrency(value: results.vatAmount),
      formattedCustomVatAmount: localizeCurrency(
        value: results.customVatAmount,
      ),
      formattedFederalVatAmount: localizeCurrency(
        value: results.federalVatAmount,
      ),
      formattedRegionalVatAmount: localizeCurrency(
        value: results.regionalVatAmount,
      ),
    );
  }

  @override
  Future<MatexVatCalculatorBlocDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      final dValue = parseStringToDouble(value);
      final isNumber = isStringNumber(value) || value.isEmpty;

      if (dValue < 0 || !isNumber) return null;

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
      } else if (key == MatexVatCalculatorBlocKey.priceAfterVat) {
        return document.copyWith(priceAfterVat: value);
      } else if (key == MatexVatCalculatorBlocKey.tipFieldType) {
        return document.copyWith(
          tipFieldType: value,
          tipAmount: '',
          tipRate: '',
        );
      } else if (key == MatexVatCalculatorBlocKey.discountFieldType) {
        return document.copyWith(
          discountFieldType: value,
          discountAmount: '',
          discountRate: '',
        );
      } else if (key == MatexVatCalculatorBlocKey.vatCalculationStrategy) {
        return document.copyWith(
          vatCalculationStrategy: value,
          priceAfterVat: '',
          priceBeforeVat: '',
        );
      }
    } else if (key == MatexVatCalculatorBlocKey.vatCalculationStrategy &&
        value is MatexVatCalculationStrategy) {
      return document.copyWith(
        vatCalculationStrategy: value.name,
        priceAfterVat: '',
        priceBeforeVat: '',
      );
    } else if (value is Enum) {
      if (key == MatexVatCalculatorBlocKey.tipFieldType) {
        return document.copyWith(
          tipFieldType: value.name,
          tipAmount: '',
          tipRate: '',
        );
      } else if (key == MatexVatCalculatorBlocKey.discountFieldType) {
        return document.copyWith(
          discountFieldType: value.name,
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
    if (value is String?) {
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
      } else if (key == MatexVatCalculatorBlocKey.vatCalculationStrategy) {
        return patchVatCalculationStrategy(value);
      } else if (key == MatexVatCalculatorBlocKey.priceAfterVat) {
        return patchPriceAfterVat(value);
      }
    } else if (key == MatexVatCalculatorBlocKey.vatCalculationStrategy &&
        value is MatexVatCalculationStrategy) {
      return patchVatCalculationStrategy(value.name);
    } else if (value is Enum) {
      if (key == MatexVatCalculatorBlocKey.tipFieldType) {
        return patchTipFieldType(value.name);
      } else if (key == MatexVatCalculatorBlocKey.discountFieldType) {
        return patchDiscountFieldType(value.name);
      }
    }

    return currentState;
  }

  @override
  Future<void> resetCalculator(MatexVatCalculatorBlocDocument document) async {
    final vatRate = parseStringToDouble(document.vatRate);
    final customVatRate = parseStringToDouble(document.customVatRate);
    final tipRate = parseStringToDouble(document.tipRate);
    final discountRate = parseStringToDouble(document.discountRate);
    final federalVatRate = parseStringToDouble(document.federalVatRate);
    final regionalVatRate = parseStringToDouble(document.regionalVatRate);

    calculator.setState(MatexVatCalculatorState(
      priceAfterVat: tryParseStringToDouble(document.priceAfterVat),
      priceBeforeVat: tryParseStringToDouble(document.priceBeforeVat),
      discountAmount: tryParseStringToDouble(document.discountAmount),
      tipAmount: tryParseStringToDouble(document.tipAmount),
      regionalVatRate: (regionalVatRate / 100),
      federalVatRate: (federalVatRate / 100),
      customVatRate: (customVatRate / 100),
      discountRate: (discountRate / 100),
      vatRate: (vatRate / 100),
      tipRate: (tipRate / 100),
    ));
  }

  @override
  Future<MatexVatCalculatorBlocState> resetCalculatorBlocState(
    MatexVatCalculatorBlocDocument document,
  ) async {
    return _kDefaultVatBlocState.copyWith(
      results: await retrieveDefaultResult(),
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
      formattedPriceBeforeVat: localizeCurrency(value: 0),
      formattedTotal: localizeCurrency(value: 0),
      priceBeforeVat: 0,
      total: 0,
    );
  }

  MatexVatCalculatorBlocState patchPriceAfterVat(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetPriceAfterVat: true);
      calculator.priceAfterVat = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(priceAfterVat: value);
      calculator.priceAfterVat = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchPriceBeforeVat(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetPriceBeforeVat: true);
      calculator.priceBeforeVat = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(priceBeforeVat: value);
      calculator.priceBeforeVat = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchCustomVatRate(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetCustomVatRate: true);
      calculator.customVatRate = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(customVatRate: value);
      calculator.customVatRate = (dValue / 100);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchVatRate(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetVatRate: true);
      calculator.vatRate = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(vatRate: value);
      calculator.vatRate = (dValue / 100);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchFederalVatRate(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetFederalVatRate: true);
      calculator.federalVatRate = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(federalVatRate: value);
      calculator.federalVatRate = (dValue / 100);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchRegionalVatRate(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetRegionalVatRate: true);
      calculator.regionalVatRate = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(regionalVatRate: value);
      calculator.regionalVatRate = (dValue / 100);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchDiscountAmount(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetDiscountAmount: true);
      calculator.discountAmount = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(discountAmount: value, discountRate: '');
      calculator.discountAmount = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchDiscountRate(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetDiscountRate: true);
      calculator.discountRate = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(discountRate: value, discountAmount: '');
      calculator.discountRate = (dValue / 100);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchTipRate(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetTipRate: true);
      calculator.tipRate = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(tipRate: value, tipAmount: '');
      calculator.tipRate = (dValue / 100);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchTipAmount(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetTipAmount: true);
      calculator.tipAmount = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(tipAmount: value, tipRate: '');
      calculator.tipAmount = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchTipFieldType(String? value) {
    value ??= MatexVatCalculatorBlocFields.defaulTipFieldType;

    final fields = currentState.fields
        .copyWithDefaults(resetTipRate: true, resetTipAmount: true)
        .copyWith(tipFieldType: value);

    // also reset tip rate
    calculator.tipAmount = 0;

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchDiscountFieldType(String? value) {
    value ??= MatexVatCalculatorBlocFields.defaulDiscountFieldType;

    final fields = currentState.fields
        .copyWithDefaults(resetDiscountAmount: true, resetDiscountRate: true)
        .copyWith(discountFieldType: value);

    // also reset discount rate
    calculator.discountAmount = 0;

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchVatCalculationStrategy(String? value) {
    value ??= MatexVatCalculatorBlocFields.defaultVatCalculationStrategy;

    final fields = currentState.fields
        .copyWithDefaults(resetPriceAfterVat: true, resetPriceBeforeVat: true)
        .copyWith(vatCalculationStrategy: value);

    if (value == MatexVatCalculationStrategy.excluded.name) {
      calculator.priceBeforeVat = 0;
    } else if (value == MatexVatCalculationStrategy.included.name) {
      calculator.priceAfterVat = 0;
    }

    return currentState.copyWith(fields: fields);
  }

  @override
  String getReportFilename() => 'vat_report';

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexVatCalculatorPdfGenerator();
    final fields = currentState.fields;
    final results = await compute();

    // ignore: use_build_context_synchronously
    return pdfGenerator.generate(context, fields, results);
  }
}
