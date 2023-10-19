import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:flutter/foundation.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

final _kDefaultProfitAndLossBlocState = MatexProfitAndLossCalculatorBlocState(
  fields: MatexProfitAndLossCalculatorBlocFields(),
  results: const MatexProfitAndLossCalculatorBlocResults(),
);

class MatexProfitAndLossCalculatorBloc extends MatexCalculatorBloc<
    MatexProfitAndLossCalculator,
    FastCalculatorBlocEvent,
    MatexProfitAndLossCalculatorBlocState,
    MatexProfitAndLossCalculatorDocument,
    MatexProfitAndLossCalculatorBlocResults> {
  MatexProfitAndLossCalculatorBloc({
    MatexProfitAndLossCalculatorBlocState? initialState,
    MatexProfitAndLossCalculatorDataProvider? dataProvider,
    super.showExportPdfDialog,
    super.debouceComputeEvents,
  }) : super(
          initialState: initialState ?? _kDefaultProfitAndLossBlocState,
          dataProvider:
              dataProvider ?? MatexProfitAndLossCalculatorDataProvider(),
          debugLabel: 'MatexProfitAndLossCalculatorBloc',
        ) {
    // FIXME: implement constructor
    calculator = MatexProfitAndLossCalculator();
  }

  @override
  Future<MatexProfitAndLossCalculatorBlocResults> compute() async {
    // FIXME: implement compute
    // final results = calculator.value();

    return retrieveDefaultResult();
  }

  @override
  Future<MatexProfitAndLossCalculatorDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      if (key == MatexProfitAndLossCalculatorBlocKey.expectedUnitSales) {
        return document.copyWith(expectedUnitSales: value.toString());
      } else if (key == MatexProfitAndLossCalculatorBlocKey.buyPrice) {
        return document.copyWith(buyPrice: value.toString());
      } else if (key == MatexProfitAndLossCalculatorBlocKey.sellPrice) {
        return document.copyWith(sellPrice: value.toString());
      } else if (key == MatexProfitAndLossCalculatorBlocKey.fixedCosts) {
        return document.copyWith(fixedCosts: value.toString());
      } else if (key == MatexProfitAndLossCalculatorBlocKey.buyFeeRate) {
        return document.copyWith(buyFeeRate: value.toString());
      } else if (key == MatexProfitAndLossCalculatorBlocKey.buyFeeAmount) {
        return document.copyWith(buyFeeAmount: value.toString());
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.sellFeeAmountPerUnit) {
        return document.copyWith(sellFeeAmountPerUnit: value.toString());
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.sellFeeRatePerUnit) {
        return document.copyWith(sellFeeRatePerUnit: value.toString());
      } else if (key == MatexProfitAndLossCalculatorBlocKey.taxRate) {
        return document.copyWith(taxRate: value.toString());
      } else if (key == MatexProfitAndLossCalculatorBlocKey.entryFeeType) {
        return document.copyWith(entryFeeType: value.toString());
      } else if (key == MatexProfitAndLossCalculatorBlocKey.exitFeeType) {
        return document.copyWith(exitFeeType: value.toString());
      }
    } else if (value is Enum) {
      value = describeEnum(value);

      if (key == MatexProfitAndLossCalculatorBlocKey.entryFeeType) {
        return document.copyWith(
          entryFeeType: value.toString(),
          //FIXME: You might want to reset other related fields depending on
          // your logic
        );
      } else if (key == MatexProfitAndLossCalculatorBlocKey.exitFeeType) {
        return document.copyWith(
          exitFeeType: value.toString(),
          //FIXME: You might want to reset other related fields depending on
          // your logic
        );
      }
    }

    return null;
  }

  @override
  Future<MatexProfitAndLossCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      // Match the key with the appropriate patch function for String values.
      if (key == MatexProfitAndLossCalculatorBlocKey.expectedUnitSales) {
        return patchExpectedUnitSales(value);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.buyPrice) {
        return patchBuyPrice(value);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.sellPrice) {
        return patchSellPrice(value);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.fixedCosts) {
        return patchFixedCosts(value);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.buyFeeRate) {
        return patchBuyFeeRate(value);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.buyFeeAmount) {
        return patchBuyFeeAmount(value);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.sellFeeAmountPerUnit) {
        return patchSellFeeAmountPerUnit(value);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.sellFeeRatePerUnit) {
        return patchSellFeeRatePerUnit(value);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.taxRate) {
        return patchTaxRate(value);
      }
    } else if (value is Enum) {
      // Handle the case where value is an Enum, using the describeEnum function to convert it.
      value = describeEnum(value);

      if (key == MatexProfitAndLossCalculatorBlocKey.entryFeeType) {
        return patchEntryFeeType(value);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.exitFeeType) {
        return patchExitFeeType(value);
      }
    }

    // If the key does not match any of the expected keys, or if the value type isn't handled,
    // return the current state without any modifications.
    return currentState;
  }

  @override
  Future<void> resetCalculator(
    MatexProfitAndLossCalculatorDocument document,
  ) async {
    // FIXME: implement resetCalculator
  }

  @override
  Future<MatexProfitAndLossCalculatorBlocState> resetCalculatorBlocState(
    MatexProfitAndLossCalculatorDocument document,
  ) async {
    return _kDefaultProfitAndLossBlocState;
  }

  @override
  Future<MatexProfitAndLossCalculatorDocument>
      retrieveDefaultCalculatorDocument() async {
    return MatexProfitAndLossCalculatorDocument();
  }

  @override
  Future<MatexProfitAndLossCalculatorBlocResults>
      retrieveDefaultResult() async {
    return MatexProfitAndLossCalculatorBlocResults(
      formattedReturnOnInvestment: localizePercentage(value: 0),
      formattedNetProfit: localizeNumber(value: 0),
      returnOnInvestment: 0,
      netProfit: 0,
    );
  }

  MatexProfitAndLossCalculatorBlocState patchExpectedUnitSales(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(expectedUnitSales: value);
    // calculator.expectedUnitSales = dValue.toDouble();

    return currentState.copyWith(fields: fields); // Return the updated state.
  }

  MatexProfitAndLossCalculatorBlocState patchBuyPrice(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(buyPrice: value);
    // calculator.buyPrice = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchSellPrice(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(sellPrice: value);
    // calculator.sellPrice = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchFixedCosts(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(fixedCosts: value);
    // calculator.fixedCosts = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchBuyFeeRate(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(buyFeeRate: value);
    // calculator.buyFeeRate = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchBuyFeeAmount(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(buyFeeAmount: value);
    // calculator.buyFeeAmount = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchSellFeeAmountPerUnit(
      String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(sellFeeAmountPerUnit: value);
    // calculator.sellFeeAmountPerUnit = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchSellFeeRatePerUnit(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(sellFeeRatePerUnit: value);
    // calculator.sellFeeRatePerUnit = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchTaxRate(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(taxRate: value);
    // calculator.taxRate = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchEntryFeeType(String value) {
    final fields = currentState.fields.copyWith(entryFeeType: value);
    // calculator.entryFeeType = value;

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchExitFeeType(String value) {
    final fields = currentState.fields.copyWith(exitFeeType: value);
    // calculator.exitFeeType = value;

    return currentState.copyWith(fields: fields);
  }
}
