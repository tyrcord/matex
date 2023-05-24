import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:flutter/foundation.dart';
import 'package:matex_financial/financial.dart';
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

    return MatexVatCalculatorBlocResults.fromCalculatorResults(results);
  }

  @override
  Future<MatexVatCalculatorBlocDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (key == 'priceBeforeVat') {
      return document.copyWith(priceBeforeVat: value?.toString());
    } else if (key == 'customVatRate') {
      return document.copyWith(customVatRate: value?.toString());
    } else if (key == 'vatRate') {
      return document.copyWith(vatRate: value?.toString());
    } else if (key == 'federalVatRate') {
      return document.copyWith(federalVatRate: value?.toString());
    } else if (key == 'regionalVatRate') {
      return document.copyWith(regionalVatRate: value?.toString());
    } else if (key == 'discountAmount') {
      return document.copyWith(discountAmount: value?.toString());
    } else if (key == 'tipRate') {
      return document.copyWith(tipRate: value?.toString());
    } else if (key == 'discountRate') {
      return document.copyWith(discountRate: value?.toString());
    } else if (key == 'tipAmount') {
      return document.copyWith(tipAmount: value?.toString());
    } else if (value is Enum) {
      value = describeEnum(value);

      if (key == 'tipFieldType') {
        return document.copyWith(tipFieldType: value?.toString());
      } else if (key == 'discountFieldType') {
        return document.copyWith(discountFieldType: value?.toString());
      }
    }

    return document;
  }

  @override
  Future<MatexVatCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value != null && value is String) {
      if (key == 'priceBeforeVat') {
        return patchPriceBeforeVat(value);
      } else if (key == 'customVatRate') {
        return patchCustomVatRate(value);
      } else if (key == 'vatRate') {
        return patchVatRate(value);
      } else if (key == 'federalVatRate') {
        return patchFederalVatRate(value);
      } else if (key == 'regionalVatRate') {
        return patchRegionalVatRate(value);
      } else if (key == 'discountAmount') {
        return patchDiscountAmount(value);
      } else if (key == 'discountRate') {
        return patchDiscountRate(value);
      } else if (key == 'tipRate') {
        return patchTipRate(value);
      } else if (key == 'tipAmount') {
        return patchTipAmount(value);
      }
    } else if (value is Enum) {
      value = describeEnum(value);

      if (key == 'tipFieldType') {
        final fields = currentState.fields.copyWith(
          tipFieldType: value.toString(),
        );

        return currentState.copyWith(fields: fields);
      } else if (key == 'discountFieldType') {
        final fields = currentState.fields.copyWith(
          discountFieldType: value.toString(),
        );

        return currentState.copyWith(fields: fields);
      }
    }

    return currentState;
  }

  @override
  Future<void> resetCalculator(MatexVatCalculatorBlocDocument document) async {
    double vatRate = parseStringToDouble(document.vatRate) ?? 0.0;

    // TODO: Add support for missing fields

    calculator.setState(MatexVatCalculatorState(
      priceBeforeVat: parseStringToDouble(document.priceBeforeVat),
      vatRate: vatRate / 100,
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
    final dValue = Decimal.tryParse(value);

    if (dValue != null) {
      final fields = currentState.fields.copyWith(priceBeforeVat: value);
      calculator.priceBeforeVat = dValue.toDouble();

      return currentState.copyWith(fields: fields);
    }

    return currentState;
  }

  MatexVatCalculatorBlocState patchCustomVatRate(String value) {
    final dValue = Decimal.tryParse(value);

    if (dValue != null) {
      final fields = currentState.fields.copyWith(customVatRate: value);
      calculator.customVatRate = (dValue / Decimal.fromInt(100)).toDouble();

      return currentState.copyWith(fields: fields);
    }

    return currentState;
  }

  MatexVatCalculatorBlocState patchVatRate(String value) {
    final dValue = Decimal.tryParse(value);

    if (dValue != null) {
      final fields = currentState.fields.copyWith(vatRate: value);
      calculator.vatRate = (dValue / Decimal.fromInt(100)).toDouble();

      return currentState.copyWith(fields: fields);
    }

    return currentState;
  }

  MatexVatCalculatorBlocState patchFederalVatRate(String value) {
    final dValue = Decimal.tryParse(value);

    if (dValue != null) {
      final fields = currentState.fields.copyWith(federalVatRate: value);
      calculator.federalVatRate = (dValue / Decimal.fromInt(100)).toDouble();

      return currentState.copyWith(fields: fields);
    }

    return currentState;
  }

  MatexVatCalculatorBlocState patchRegionalVatRate(String value) {
    final dValue = Decimal.tryParse(value);

    if (dValue != null) {
      final fields = currentState.fields.copyWith(regionalVatRate: value);
      calculator.regionalVatRate = (dValue / Decimal.fromInt(100)).toDouble();

      return currentState.copyWith(fields: fields);
    }

    return currentState;
  }

  MatexVatCalculatorBlocState patchDiscountAmount(String value) {
    final dValue = Decimal.tryParse(value);

    if (dValue != null) {
      final fields = currentState.fields.copyWith(discountAmount: value);
      calculator.discountAmount = dValue.toDouble();

      return currentState.copyWith(fields: fields);
    }

    return currentState;
  }

  MatexVatCalculatorBlocState patchDiscountRate(String value) {
    final dValue = Decimal.tryParse(value);

    if (dValue != null) {
      final fields = currentState.fields.copyWith(discountRate: value);
      calculator.discountRate = (dValue / Decimal.fromInt(100)).toDouble();

      return currentState.copyWith(fields: fields);
    }

    return currentState;
  }

  MatexVatCalculatorBlocState patchTipRate(String value) {
    final dValue = Decimal.tryParse(value);

    if (dValue != null) {
      final fields = currentState.fields.copyWith(tipRate: value);
      calculator.tipRate = (dValue / Decimal.fromInt(100)).toDouble();

      return currentState.copyWith(fields: fields);
    }

    return currentState;
  }

  MatexVatCalculatorBlocState patchTipAmount(String value) {
    final dValue = Decimal.tryParse(value);

    if (dValue != null) {
      final fields = currentState.fields.copyWith(tipAmount: value);
      calculator.tipAmount = dValue.toDouble();

      return currentState.copyWith(fields: fields);
    }

    return currentState;
  }
}
