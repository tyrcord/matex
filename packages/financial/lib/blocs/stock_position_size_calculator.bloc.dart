import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:matex_core/core.dart';
import 'package:matex_dart/matex_dart.dart' show MatexPosition;
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

final _kDefaultStockPositionSizeBlocState =
    MatexStockPositionSizeCalculatorBlocState(
  fields: MatexStockPositionSizeCalculatorBlocFields(),
  results: const MatexStockPositionSizeCalculatorBlocResults(),
);

class MatexStockPositionSizeCalculatorBloc extends MatexCalculatorBloc<
    MatexStockPositionSizeCalculator,
    FastCalculatorBlocEvent,
    MatexStockPositionSizeCalculatorBlocState,
    MatexStockPositionSizeCalculatorBlocDocument,
    MatexStockPositionSizeCalculatorBlocResults> {
  MatexStockPositionSizeCalculatorBloc({
    MatexStockPositionSizeCalculatorBlocState? initialState,
    MatexStockPositionSizeCalculatorDataProvider? dataProvider,
    super.showExportPdfDialog,
    super.debouceComputeEvents,
  }) : super(
          initialState: initialState ?? _kDefaultStockPositionSizeBlocState,
          dataProvider:
              dataProvider ?? MatexStockPositionSizeCalculatorDataProvider(),
          debugLabel: 'MatexStockPositionSizeCalculatorBloc',
        ) {
    calculator = MatexStockPositionSizeCalculator();

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorRiskRewardRatio.name,
      MatexStockPositionSizeCalculatorBlocKey.riskReward,
    );

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorRiskPercent.name,
      MatexStockPositionSizeCalculatorBlocKey.riskPercent,
    );
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocResults> compute() async {
    final results = calculator.value();

    return MatexStockPositionSizeCalculatorBlocResults(
      stopLossPercentWithSlippage: results.stopLossPercentWithSlippage,
      stopLossPriceWithSlippage: results.stopLossPriceWithSlippage,
      entryPriceWithSlippage: results.entryPriceWithSlippage,
      takeProfitFeeAmount: results.takeProfitFeeAmount,
      takeProfitAmount: results.takeProfitAmount,
      takeProfitPrice: results.takeProfitPrice,
      stopLossPercent: results.stopLossPercent,
      involvedCapital: results.involvedCapital,
      entryFeeAmount: results.entryFeeAmount,
      positionAmount: results.positionAmount,
      stopLossFeeAmount: results.stopLossFeeAmount,
      toleratedRisk: results.toleratedRisk,
      effectiveRisk: results.effectiveRisk,
      riskPercent: results.riskPercent,
      totalFeesForLossPosition: results.totalFeesForLossPosition,
      totalFeesForProfitPosition: results.totalFeesForProfitPosition,
      takeProfitAmountAfterFee: results.takeProfitAmountAfterFee,
      shares: results.shares,
      formattedPositionAmount: localizeCurrency(value: results.positionAmount),
      formattedEntryFeeAmount: localizeCurrency(value: results.entryFeeAmount),
      formattedToleratedRisk: localizeCurrency(value: results.toleratedRisk),
      formattedEffectiveRisk: localizeCurrency(value: results.effectiveRisk),
      formattedRiskPercent: localizePercentage(value: results.riskPercent),
      formattedShares: localizeNumber(value: results.shares ?? 0),
      formattedTotalFeesForProfitPosition: localizeCurrency(
        value: results.totalFeesForProfitPosition,
      ),
      formattedTotalFeesForLossPosition: localizeCurrency(
        value: results.totalFeesForLossPosition,
      ),
      formattedTakeProfitFeeAmount: localizeCurrency(
        value: results.takeProfitFeeAmount,
      ),
      formattedStopLossFeeAmount: localizeCurrency(
        value: results.stopLossFeeAmount,
      ),
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
      formattedTakeProfitAmountAfterFee: localizeCurrency(
        value: results.takeProfitAmountAfterFee,
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
        return document.copyWith(accountSize: value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.entryPrice) {
        return document.copyWith(entryPrice: value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.stopLossPrice) {
        return document.copyWith(stopLossPrice: value);
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.stopLossAmount) {
        return document.copyWith(stopLossAmount: value);
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.slippagePercent) {
        return document.copyWith(slippagePercent: value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.riskPercent) {
        return document.copyWith(riskPercent: value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.riskReward) {
        return document.copyWith(riskReward: value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.entryFees) {
        return document.copyWith(entryFees: value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.exitFees) {
        return document.copyWith(exitFees: value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.riskFieldType) {
        return document.copyWith(riskFieldType: value);
      }
    } else if (value is Enum) {
      value = describeEnum(value);

      if (key == MatexStockPositionSizeCalculatorBlocKey.riskFieldType) {
        return document.copyWith(
          riskFieldType: value.toString(),
          stopLossAmount: '',
          riskPercent: '',
        );
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.position) {
        return document.copyWith(
          position: value.toString(),
          stopLossPrice: '',
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
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.riskReward) {
        return patchRiskReward(value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.entryFees) {
        return patchEntryFees(value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.exitFees) {
        return patchExitFees(value);
      }
    } else if (value is Enum) {
      value = describeEnum(value);

      if (key == MatexStockPositionSizeCalculatorBlocKey.riskFieldType) {
        return patchRiskFieldType(value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.position) {
        return patchPosition(value);
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
      isShortPosition: document.position == MatexPosition.short.name,
      stopLossAmount: parseStringToDouble(document.stopLossAmount),
      stopLossPrice: parseStringToDouble(document.stopLossPrice),
      slippagePercent: (slippagePercent / dHundred).toDouble(),
      accountSize: parseStringToDouble(document.accountSize),
      entryPrice: parseStringToDouble(document.entryPrice),
      riskReward: parseStringToDouble(document.riskReward),
      riskPercent: (riskPercent / dHundred).toDouble(),
      entryFees: (entryFees / dHundred).toDouble(),
      exitFees: (exitFees / dHundred).toDouble(),
    ));
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocState> resetCalculatorBlocState(
    MatexStockPositionSizeCalculatorBlocDocument document,
  ) async {
    return _kDefaultStockPositionSizeBlocState.copyWith(
      fields: MatexStockPositionSizeCalculatorBlocFields(
        riskPercent: document.riskPercent,
        riskReward: document.riskReward,
      ),
    );
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocDocument>
      retrieveDefaultCalculatorDocument() async {
    final bloc = FastAppDictBloc.instance;

    return MatexStockPositionSizeCalculatorBlocDocument(
      riskReward: bloc.getValue<String?>(
        MatexCalculatorDefaultValueKeys.matexCalculatorRiskRewardRatio.name,
      ),
      riskPercent: bloc.getValue<String?>(
        MatexCalculatorDefaultValueKeys.matexCalculatorRiskPercent.name,
      ),
    );
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocResults>
      retrieveDefaultResult() async {
    return MatexStockPositionSizeCalculatorBlocResults(
      formattedShares: localizeNumber(value: 0),
      shares: 0,
    );
  }

  MatexStockPositionSizeCalculatorBlocState patchPosition(String value) {
    final fields = currentState.fields.copyWith(
      position: value,
      stopLossPrice: '',
    );

    calculator
      ..isShortPosition = value == MatexPosition.short.name
      ..stopLossPrice = 0;

    return currentState.copyWith(fields: fields);
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

  MatexStockPositionSizeCalculatorBlocState patchRiskReward(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(riskReward: value);
    calculator.riskReward = dValue.toDouble();

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
      riskFieldType: value,
      stopLossAmount: '',
      riskPercent: '',
    );

    // also reset stop loss amount
    calculator.riskPercent = 0;

    return currentState.copyWith(fields: fields);
  }

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = StockPositionSizePdfGenerator();
    final fields = currentState.fields;
    final results = await compute();

    // ignore: use_build_context_synchronously
    return pdfGenerator.generate(context, fields, results);
  }
}
