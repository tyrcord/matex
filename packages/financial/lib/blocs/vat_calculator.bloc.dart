import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';
import 'package:flutter/foundation.dart';
import 'package:t_helpers/helpers.dart';
import 'package:matex_core/core.dart';
import 'package:decimal/decimal.dart';

const _kDefaultVatBlocState = MatexVatCalculatorBlocState(
  fields: MatexVatCalculatorBlocFields(),
  results: MatexVatCalculatorBlocResults(),
);

class MatexVatCalculatorBloc extends MatexCalculatorBloc<
    MatexVatCalculator,
    FastCalculatorBlocEvent,
    MatexVatCalculatorBlocState,
    MatexVatCalculatorBlocDocument,
    MatexVatCalculatorBlocResults> {
  MatexVatCalculatorBloc({
    super.initialState = _kDefaultVatBlocState,
  }) : super(dataProvider: MatexVatCalculatorDataProvider()) {
    calculator = MatexVatCalculator();
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
      formattedTotalTaxes: localizeCurrency(value: results.totalTaxes),
      formattedTotal: localizeCurrency(value: results.total),
      formattedTipAmount: localizeCurrency(value: results.tipAmount),
      formattedGrandTotal: localizeCurrency(value: results.grandTotal),
      formattedTipRate: localizePercentage(value: results.tipRate),
      formattedSubTotal: localizeCurrency(value: results.subTotal),
      formattedDiscountAmount: localizeCurrency(value: results.discountAmount),
      formattedDiscountRate: localizePercentage(value: results.discountRate),
    );
  }

  @override
  Future<MatexVatCalculatorBlocDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (key == MatexVatCalculatorBlocKey.priceBeforeVat) {
      return document.copyWith(priceBeforeVat: value?.toString());
    } else if (key == MatexVatCalculatorBlocKey.customVatRate) {
      return document.copyWith(customVatRate: value?.toString());
    } else if (key == MatexVatCalculatorBlocKey.vatRate) {
      return document.copyWith(vatRate: value?.toString());
    } else if (key == MatexVatCalculatorBlocKey.federalVatRate) {
      return document.copyWith(federalVatRate: value?.toString());
    } else if (key == MatexVatCalculatorBlocKey.regionalVatRate) {
      return document.copyWith(regionalVatRate: value?.toString());
    } else if (key == MatexVatCalculatorBlocKey.discountAmount) {
      return document.copyWith(
        discountAmount: value?.toString(),
        discountRate: '',
      );
    } else if (key == MatexVatCalculatorBlocKey.tipAmount) {
      return document.copyWith(
        tipAmount: value?.toString(),
        tipRate: '',
      );
    } else if (key == MatexVatCalculatorBlocKey.tipRate) {
      return document.copyWith(
        tipRate: value?.toString(),
        tipAmount: '',
      );
    } else if (key == MatexVatCalculatorBlocKey.discountRate) {
      return document.copyWith(
        discountRate: value?.toString(),
        discountAmount: '',
      );
    } else if (value is Enum) {
      value = describeEnum(value);

      if (key == MatexVatCalculatorBlocKey.tipFieldType) {
        return document.copyWith(
          tipFieldType: value?.toString(),
          tipAmount: '',
          tipRate: '',
        );
      } else if (key == MatexVatCalculatorBlocKey.discountFieldType) {
        return document.copyWith(
          discountFieldType: value?.toString(),
          discountAmount: '',
          discountRate: '',
        );
      }
    }

    return document;
  }

  @override
  Future<MatexVatCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
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
    var dParse = Decimal.tryParse;
    var dZero = Decimal.zero;
    var vatRate = dParse(document.vatRate ?? '0') ?? dZero;
    var customVatRate = dParse(document.customVatRate ?? '0') ?? dZero;
    var tipRate = dParse(document.tipRate ?? '0') ?? dZero;
    var discountRate = dParse(document.discountRate ?? '0') ?? dZero;
    var federalVatRate = dParse(document.federalVatRate ?? '0') ?? dZero;
    var regionalVatRate = dParse(document.regionalVatRate ?? '0') ?? dZero;

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
    return _kDefaultVatBlocState;
  }

  @override
  Future<MatexVatCalculatorBlocDocument>
      retrieveDefaultCalculatorDocument() async {
    return const MatexVatCalculatorBlocDocument();
  }

  @override
  Future<MatexVatCalculatorBlocResults> retrieveDefaultResult() async {
    return const MatexVatCalculatorBlocResults();
  }

  MatexVatCalculatorBlocState patchPriceBeforeVat(String value) {
    final dValue = Decimal.tryParse(value) ?? Decimal.zero;
    final fields = currentState.fields.copyWith(priceBeforeVat: value);
    calculator.priceBeforeVat = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchCustomVatRate(String value) {
    final dValue = Decimal.tryParse(value) ?? Decimal.zero;
    final fields = currentState.fields.copyWith(customVatRate: value);
    calculator.customVatRate = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchVatRate(String value) {
    final dValue = Decimal.tryParse(value) ?? Decimal.zero;
    final fields = currentState.fields.copyWith(vatRate: value);
    calculator.vatRate = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchFederalVatRate(String value) {
    final dValue = Decimal.tryParse(value) ?? Decimal.zero;
    final fields = currentState.fields.copyWith(federalVatRate: value);
    calculator.federalVatRate = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchRegionalVatRate(String value) {
    final dValue = Decimal.tryParse(value) ?? Decimal.zero;
    final fields = currentState.fields.copyWith(regionalVatRate: value);
    calculator.regionalVatRate = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchDiscountAmount(String value) {
    final dValue = Decimal.tryParse(value) ?? Decimal.zero;
    final fields = currentState.fields.copyWith(
      discountAmount: value,
      discountRate: '',
    );

    calculator.discountAmount = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchDiscountRate(String value) {
    final dValue = Decimal.tryParse(value) ?? Decimal.zero;
    final fields = currentState.fields.copyWith(
      discountRate: value,
      discountAmount: '',
    );

    calculator.discountRate = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchTipRate(String value) {
    final dValue = Decimal.tryParse(value) ?? Decimal.zero;
    final fields = currentState.fields.copyWith(
      tipRate: value,
      tipAmount: '',
    );

    calculator.tipRate = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchTipAmount(String value) {
    final dValue = Decimal.tryParse(value) ?? Decimal.zero;
    final fields = currentState.fields.copyWith(
      tipAmount: value,
      tipRate: '',
    );

    calculator.tipAmount = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  Future<MatexVatCalculatorBlocState?> patchTipFieldType(dynamic value) async {
    final fields = currentState.fields.copyWith(
      tipFieldType: value.toString(),
      tipAmount: '',
      tipRate: '',
    );

    calculator.tipAmount = 0;

    return currentState.copyWith(fields: fields);
  }

  Future<MatexVatCalculatorBlocState?> patchDiscountFieldType(
    String value,
  ) async {
    final fields = currentState.fields.copyWith(
      discountFieldType: value.toString(),
      discountAmount: '',
      discountRate: '',
    );

    calculator.discountAmount = 0;

    return currentState.copyWith(fields: fields);
  }
}
