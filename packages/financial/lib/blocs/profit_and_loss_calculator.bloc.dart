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
    MatexStockPositionSizeCalculator,
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
    calculator = MatexStockPositionSizeCalculator();
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
      if (key == MatexProfitAndLossCalculatorBlocKey.positionSize) {
        return document.copyWith(positionSize: value.toString());
      } else if (key == MatexProfitAndLossCalculatorBlocKey.entryPrice) {
        return document.copyWith(entryPrice: value.toString());
      } else if (key == MatexProfitAndLossCalculatorBlocKey.exitPrice) {
        return document.copyWith(exitPrice: value.toString());
      } else if (key == MatexProfitAndLossCalculatorBlocKey.fixedCosts) {
        return document.copyWith(fixedCosts: value.toString());
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.entryFeePercentagePerUnit) {
        return document.copyWith(entryFeePercentagePerUnit: value.toString());
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.entryFeeAmountPerUnit) {
        return document.copyWith(entryFeeAmountPerUnit: value.toString());
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.exitFeeAmountPerUnit) {
        return document.copyWith(exitFeeAmountPerUnit: value.toString());
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.exitFeePercentagePerUnit) {
        return document.copyWith(exitFeePercentagePerUnit: value.toString());
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
      if (key == MatexProfitAndLossCalculatorBlocKey.positionSize) {
        return patchPositionSize(value);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.entryPrice) {
        return patchEntryPrice(value);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.exitPrice) {
        return patchExitPrice(value);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.fixedCosts) {
        return patchFixedCosts(value);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.entryFeePercentagePerUnit) {
        return patchEntryFeePercentagePerUnit(value);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.entryFeeAmountPerUnit) {
        return patchEntryFeeAmountPerUnit(value);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.exitFeeAmountPerUnit) {
        return patchExitFeeAmountPerUnit(value);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.exitFeePercentagePerUnit) {
        return patchExitFeePercentagePerUnit(value);
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

  MatexProfitAndLossCalculatorBlocState patchPositionSize(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(positionSize: value);
    // calculator.positionSize = dValue.toDouble();

    return currentState.copyWith(fields: fields); // Return the updated state.
  }

  MatexProfitAndLossCalculatorBlocState patchEntryPrice(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(entryPrice: value);
    calculator.entryPrice = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchExitPrice(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(exitPrice: value);
    // calculator.exitPrice = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchFixedCosts(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(fixedCosts: value);
    // calculator.fixedCosts = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchEntryFeePercentagePerUnit(
      String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields =
        currentState.fields.copyWith(entryFeePercentagePerUnit: value);
    // calculator.entryFeePercentagePerUnit = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchEntryFeeAmountPerUnit(
      String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(entryFeeAmountPerUnit: value);
    // calculator.entryFeeAmountPerUnit = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchExitFeeAmountPerUnit(
      String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(exitFeeAmountPerUnit: value);
    // calculator.exitFeeAmountPerUnit = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchExitFeePercentagePerUnit(
      String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields =
        currentState.fields.copyWith(exitFeePercentagePerUnit: value);
    // calculator.exitFeePercentagePerUnit = dValue.toDouble();

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
