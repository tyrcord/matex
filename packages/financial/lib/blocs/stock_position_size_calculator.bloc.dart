import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:flutter/foundation.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

const _kDefaultStockPositionSizeBlocState =
    MatexStockPositionSizeCalculatorBlocState(
  fields: MatexStockPositionSizeCalculatorBlocFields(),
  results: MatexStockPositionSizeCalculatorBlocResults(),
);

class MatexStockPositionSizeCalculatorBloc extends MatexCalculatorBloc<
    MatexStockPositionSizeCalculator,
    FastCalculatorBlocEvent,
    MatexStockPositionSizeCalculatorBlocState,
    MatexStockPositionSizeCalculatorBlocDocument,
    MatexStockPositionSizeCalculatorBlocResults> {
  MatexStockPositionSizeCalculatorBloc({
    super.initialState = _kDefaultStockPositionSizeBlocState,
    MatexStockPositionSizeCalculatorDataProvider? dataProvider,
  }) : super(
            dataProvider: dataProvider ??
                MatexStockPositionSizeCalculatorDataProvider()) {
    calculator = MatexStockPositionSizeCalculator();
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocResults> compute() async {
    final results = calculator.value();

    return MatexStockPositionSizeCalculatorBlocResults(
      shares: results.shares,
      positionAmount: results.positionAmount,
      involvedCapital: results.involvedCapital,
      takeProfitAmount: results.takeProfitAmount,
      takeProfitPrice: results.takeProfitPrice,
      toleratedRisk: results.toleratedRisk,
      effectiveRisk: results.effectiveRisk,
      stopLossPercent: results.stopLossPercent,
      riskPercent: results.riskPercent,
      stopLossPercentWithSlippage: results.stopLossPercentWithSlippage,
      stopLossPriceWithSlippage: results.stopLossPriceWithSlippage,
      entryPriceWithSlippage: results.entryPriceWithSlippage,
      formattedShares: localizeNumber(value: results.shares),
      formattedPositionAmount: localizeCurrency(value: results.positionAmount),
      formattedToleratedRisk: localizeCurrency(value: results.toleratedRisk),
      formattedEffectiveRisk: localizeCurrency(value: results.effectiveRisk),
      formattedRiskPercent: localizePercentage(value: results.riskPercent),
      formattedInvolvedCapital: localizePercentage(
        value: results.involvedCapital,
      ),
      formattedStopLossPercent: localizePercentage(
        value: results.stopLossPercent,
      ),
      formattedTakeProfitAmount: localizeCurrency(
        value: results.takeProfitAmount,
      ),
      formattedTakeProfitPrice: localizeCurrency(
        value: results.takeProfitPrice,
      ),
      formattedStopLossPercentWithSlippage: localizePercentage(
        value: results.stopLossPercentWithSlippage,
      ),
      formattedStopLossPriceWithSlippage: localizeCurrency(
        value: results.stopLossPriceWithSlippage,
      ),
      formattedEntryPriceWithSlippage: localizeCurrency(
        value: results.entryPriceWithSlippage,
      ),
    );
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      if (key == MatexStockPositionSizeCalculatorBlocKey.accountSize) {
        return document.copyWith(accountSize: value.toString());
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.entryPrice) {
        return document.copyWith(entryPrice: value.toString());
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.stopLossPrice) {
        return document.copyWith(stopLossPrice: value.toString());
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.stopLossAmount) {
        return document.copyWith(stopLossAmount: value.toString());
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.slippagePercent) {
        return document.copyWith(slippagePercent: value.toString());
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.riskPercent) {
        return document.copyWith(riskPercent: value.toString());
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.rewardRisk) {
        return document.copyWith(rewardRisk: value.toString());
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.entryFees) {
        return document.copyWith(entryFees: value.toString());
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.exitFees) {
        return document.copyWith(exitFees: value.toString());
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.riskFieldType) {
        return document.copyWith(riskFieldType: value.toString());
      }
    } else if (value is Enum) {
      value = describeEnum(value);

      if (key == MatexStockPositionSizeCalculatorBlocKey.riskFieldType) {
        return document.copyWith(
          riskFieldType: value.toString(),
          stopLossAmount: '',
          riskPercent: '',
        );
      }
    }

    return null;
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      if (key == MatexStockPositionSizeCalculatorBlocKey.accountSize) {
        return patchAccountSize(value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.entryPrice) {
        return patchEntryPrice(value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.stopLossPrice) {
        return patchStopLossPrice(value);
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.stopLossAmount) {
        return patchStopLossAmount(value);
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.slippagePercent) {
        return patchSlippagePercent(value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.riskPercent) {
        return patchRiskPercent(value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.rewardRisk) {
        return patchRewardRisk(value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.entryFees) {
        return patchEntryFees(value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.exitFees) {
        return patchExitFees(value);
      }
    } else if (value is Enum) {
      value = describeEnum(value);

      if (key == MatexStockPositionSizeCalculatorBlocKey.riskFieldType) {
        return patchRiskFieldType(value);
      }
    }

    return currentState;
  }

  @override
  Future<void> resetCalculator(
    MatexStockPositionSizeCalculatorBlocDocument document,
  ) async {
    final slippagePercent = toDecimal(document.slippagePercent) ?? dZero;
    final riskPercent = toDecimal(document.riskPercent) ?? dZero;
    final entryFees = toDecimal(document.entryFees) ?? dZero;
    final exitFees = toDecimal(document.exitFees) ?? dZero;

    calculator.setState(MatexStockPositionSizeCalculatorState(
      stopLossAmount: parseStringToDouble(document.stopLossAmount),
      stopLossPrice: parseStringToDouble(document.stopLossPrice),
      accountSize: parseStringToDouble(document.accountSize),
      entryPrice: parseStringToDouble(document.entryPrice),
      rewardRisk: parseStringToDouble(document.rewardRisk),
      slippagePercent: (slippagePercent / dHundred).toDouble(),
      riskPercent: (riskPercent / dHundred).toDouble(),
      entryFees: (entryFees / dHundred).toDouble(),
      exitFees: (exitFees / dHundred).toDouble(),
    ));
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocState> resetCalculatorBlocState(
    MatexStockPositionSizeCalculatorBlocDocument document,
  ) async {
    return _kDefaultStockPositionSizeBlocState;
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocDocument>
      retrieveDefaultCalculatorDocument() async {
    return const MatexStockPositionSizeCalculatorBlocDocument();
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocResults>
      retrieveDefaultResult() async {
    return const MatexStockPositionSizeCalculatorBlocResults();
  }

  MatexStockPositionSizeCalculatorBlocState patchAccountSize(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(accountSize: value);
    calculator.accountSize = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchEntryPrice(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(entryPrice: value);
    calculator.entryPrice = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchStopLossPrice(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(stopLossPrice: value);
    calculator.stopLossPrice = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchSlippagePercent(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(slippagePercent: value);
    calculator.slippagePercent = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchRewardRisk(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(rewardRisk: value);
    calculator.rewardRisk = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchEntryFees(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(entryFees: value);
    calculator.entryFees = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchExitFees(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(exitFees: value);
    calculator.exitFees = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchRiskPercent(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(
      riskPercent: value,
      stopLossAmount: '',
    );

    // also reset stop loss amount
    calculator.riskPercent = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchStopLossAmount(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(
      stopLossAmount: value,
      riskPercent: '',
    );

    // also reset risk percent
    calculator.stopLossAmount = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchRiskFieldType(
    String value,
  ) {
    final fields = currentState.fields.copyWith(
      riskFieldType: value.toString(),
      stopLossAmount: '',
      riskPercent: '',
    );

    // also reset stop loss amount
    calculator.riskPercent = 0;

    return currentState.copyWith(fields: fields);
  }
}
