import 'package:fastyle_calculator/fastyle_calculator.dart';
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
    } else if (key == 'discountPercentage') {
      return document.copyWith(discountPercentage: value?.toString());
    } else if (key == 'tipRate') {
      return document.copyWith(tipRate: value?.toString());
    } else if (key == 'discountRate') {
      return document.copyWith(discountRate: value?.toString());
    } else if (key == 'tipAmount') {
      return document.copyWith(tipAmount: value?.toString());
    } else if (key == 'tipFieldType') {
      return document.copyWith(tipFieldType: value?.toString());
    } else if (key == 'discountFieldType') {
      return document.copyWith(discountFieldType: value?.toString());
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
      } else if (key == 'discountPercentage') {
        return patchDiscountPercentage(value);
      } else if (key == 'tipRate') {
        return patchTipRate(value);
      }

      // todo: tip amount
    }

    return currentState;
  }

  @override
  Future<void> resetCalculator(MatexVatCalculatorBlocDocument document) async {
    calculator.setState(MatexVatCalculatorState(
      priceBeforeVat: parseStringToDouble(document.priceBeforeVat),
      vatRate: parseStringToDouble(document.vatRate),
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
    final fields = currentState.fields.copyWith(priceBeforeVat: value);
    final dValue = Decimal.tryParse(value);

    if (dValue != null) {
      calculator.priceBeforeVat = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchCustomVatRate(String value) {
    final fields = currentState.fields.copyWith(customVatRate: value);
    final dValue = Decimal.tryParse(value);

    if (dValue != null) {
      calculator.customVatRate = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchVatRate(String value) {
    final fields = currentState.fields.copyWith(vatRate: value);
    final dValue = Decimal.tryParse(value);
    var nValue = 0.0;

    if (dValue != null) {
      if (dValue > Decimal.one) {
        nValue = (dValue / Decimal.fromInt(100)).toDouble();
      } else {
        nValue = dValue.toDouble();
      }
    }

    calculator.vatRate = nValue;

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchFederalVatRate(String value) {
    final fields = currentState.fields.copyWith(federalVatRate: value);
    final dValue = Decimal.tryParse(value);

    if (dValue != null) {
      calculator.federalVatRate = dValue.toDouble();
    } else {
      calculator.federalVatRate = 0;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchRegionalVatRate(String value) {
    final fields = currentState.fields.copyWith(regionalVatRate: value);
    final dValue = Decimal.tryParse(value);

    if (dValue != null) {
      calculator.regionalVatRate = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchDiscountAmount(String value) {
    final fields = currentState.fields.copyWith(discountAmount: value);
    final dValue = Decimal.tryParse(value);

    if (dValue != null) {
      calculator.discountAmount = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchDiscountPercentage(String value) {
    final fields = currentState.fields.copyWith(discountPercentage: value);
    final dValue = Decimal.tryParse(value);

    if (dValue != null) {
      calculator.discountPercentage = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexVatCalculatorBlocState patchTipRate(String value) {
    final fields = currentState.fields.copyWith(tipRate: value);
    final dValue = Decimal.tryParse(value);

    if (dValue != null) {
      if (dValue > Decimal.one) {
        calculator.tipRate = (dValue / Decimal.fromInt(100)).toDouble();
      } else {
        calculator.tipRate = dValue.toDouble();
      }
    }

    return currentState.copyWith(fields: fields);
  }
}
