// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

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
    super.exportAlternativeAction,
    super.debouceComputeEvents = true,
    super.getExportDialog,
    super.delegate,
    super.getContext,
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
      riskRewardRatio: results.riskReward,
      formattedRiskRewardRatio: localizeNumber(value: results.riskReward),
      totalFeesForLossPosition: results.totalFeesForLossPosition,
      totalFeesForProfitPosition: results.totalFeesForProfitPosition,
      takeProfitAmountAfterFee: results.takeProfitAmountAfterFee,
      shares: results.shares,
      returnOnCapital: results.returnOnCapital,
      formattedReturnOnCapital: localizePercentage(
        value: results.returnOnCapital,
      ),
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
    if (value == null) {
      if (key == MatexStockPositionSizeCalculatorBlocKey.takeProfitPrice) {
        return document.copyWithDefaults(resetTakeProfitPrice: true);
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.takeProfitFieldType) {
        return document.copyWithDefaults(resetTakeProfitFieldType: true);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.accountSize) {
        return document.copyWithDefaults(resetAccountSize: true);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.entryPrice) {
        return document.copyWithDefaults(resetEntryPrice: true);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.stopLossPrice) {
        return document.copyWithDefaults(resetStopLossPrice: true);
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.stopLossAmount) {
        return document.copyWithDefaults(resetStopLossAmount: true);
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.slippagePercent) {
        return document.copyWithDefaults(resetSlippagePercent: true);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.riskPercent) {
        return document.copyWithDefaults(resetRiskPercent: true);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.riskReward) {
        return document.copyWithDefaults(resetRiskReward: true);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.entryFees) {
        return document.copyWithDefaults(resetEntryFees: true);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.exitFees) {
        return document.copyWithDefaults(resetExitFees: true);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.riskFieldType) {
        return document.copyWithDefaults(resetRiskFieldType: true);
      }
    } else if (value is String) {
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
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.takeProfitPrice) {
        return document.copyWith(takeProfitPrice: value);
      }
    } else if (value is Enum) {
      if (key == MatexStockPositionSizeCalculatorBlocKey.riskFieldType) {
        return document.copyWith(
          riskPercent: _getDefaultValueForFieldType(value.name, 'percent'),
          riskFieldType: value.name,
          stopLossAmount: '',
        );
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.position) {
        return document.copyWith(
          position: value.name,
          stopLossPrice: '',
        );
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.takeProfitFieldType) {
        return document.copyWith(
          riskReward: _getDefaultValueForFieldType(value.name, 'riskReward'),
          takeProfitFieldType: value.name,
          takeProfitPrice: '',
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
    if (value is String?) {
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
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.takeProfitPrice) {
        return patchTakeProfitPrice(value);
      }
    } else if (value is MatexPosition &&
        key == MatexStockPositionSizeCalculatorBlocKey.position) {
      return patchPosition(value);
    } else if (value is Enum) {
      if (key == MatexStockPositionSizeCalculatorBlocKey.riskFieldType) {
        return patchRiskFieldType(value.name);
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.takeProfitFieldType) {
        return patchTakeProfitFieldType(value.name);
      }
    }

    return currentState;
  }

  @override
  Future<void> resetCalculator(
    MatexStockPositionSizeCalculatorBlocDocument document,
  ) async {
    final slippagePercent = parseStringToDouble(document.slippagePercent);
    final riskPercent = parseStringToDouble(document.riskPercent);
    final entryFees = parseStringToDouble(document.entryFees);
    final exitFees = parseStringToDouble(document.exitFees);

    calculator.setState(MatexStockPositionSizeCalculatorState(
      isShortPosition: document.position == MatexPosition.short.name,
      stopLossAmount: tryParseStringToDouble(document.stopLossAmount),
      stopLossPrice: tryParseStringToDouble(document.stopLossPrice),
      slippagePercent: (slippagePercent / 100),
      accountSize: tryParseStringToDouble(document.accountSize),
      entryPrice: tryParseStringToDouble(document.entryPrice),
      riskReward: tryParseStringToDouble(document.riskReward),
      riskPercent: (riskPercent / 100),
      entryFees: (entryFees / 100),
      exitFees: (exitFees / 100),
    ));
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocState> resetCalculatorBlocState(
    MatexStockPositionSizeCalculatorBlocDocument document,
  ) async {
    return _kDefaultStockPositionSizeBlocState.copyWith(
      results: await retrieveDefaultResult(),
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

  MatexStockPositionSizeCalculatorBlocState patchPosition(MatexPosition value) {
    final fields = currentState.fields.copyWith(
      position: value,
      stopLossPrice: '',
    );

    calculator
      ..isShortPosition = value == MatexPosition.short
      ..stopLossPrice = 0;

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchAccountSize(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetAccountSize: true);
      calculator.accountSize = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(accountSize: value);
      calculator.accountSize = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchEntryPrice(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetEntryPrice: true);
      calculator.entryPrice = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(entryPrice: value);
      calculator.entryPrice = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchStopLossPrice(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetStopLossPrice: true);
      calculator.stopLossPrice = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(stopLossPrice: value);
      calculator.stopLossPrice = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchSlippagePercent(
    String? value,
  ) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetSlippagePercent: true);
      calculator.slippagePercent = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(slippagePercent: value);
      calculator.slippagePercent = (dValue / 100);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchEntryFees(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetEntryFees: true);

      calculator.entryFees = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(entryFees: value);
      calculator.entryFees = (dValue / 100);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchExitFees(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetExitFees: true);
      calculator.exitFees = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(exitFees: value);
      calculator.exitFees = (dValue / 100);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchRiskPercent(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetRiskPercent: true);
      calculator.riskPercent = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(riskPercent: value, stopLossAmount: '');
      calculator.riskPercent = (dValue / 100);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchStopLossAmount(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetStopLossAmount: true);
      calculator.stopLossAmount = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(stopLossAmount: value, riskPercent: '');
      calculator.stopLossAmount = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchRiskFieldType(
    String value,
  ) {
    final fields = currentState.fields.copyWith(
      riskPercent: _getDefaultValueForFieldType(value, 'percent'),
      riskFieldType: value,
      stopLossAmount: '',
    );

    calculator
      ..stopLossAmount = 0
      ..riskPercent = (parseStringToDouble(fields.riskPercent) / 100);

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchTakeProfitFieldType(
    String value,
  ) {
    final fields = currentState.fields.copyWith(
      riskReward: _getDefaultValueForFieldType(value, 'riskReward'),
      takeProfitFieldType: value,
      takeProfitPrice: '',
    );

    calculator
      ..takeProfitPrice = 0
      ..riskReward = parseStringToDouble(fields.riskReward);

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchTakeProfitPrice(
    String? value,
  ) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetTakeProfitPrice: true);
      calculator.takeProfitPrice = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(takeProfitPrice: value, riskReward: '');
      calculator.takeProfitPrice = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchRiskReward(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetRiskReward: true);
      calculator.riskReward = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = fields.copyWith(riskReward: value, takeProfitPrice: '');
      calculator.riskReward = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  @override
  String getReportFilename() => 'stock_position_size_report';

  String _getDefaultValueForFieldType(String fieldType, String expectedValue) {
    return fieldType == expectedValue
        ? defaultDocument.getDefaultValue(expectedValue) ?? ''
        : '';
  }

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexStockPositionSizeCalculatorPdfGenerator();
    final fields = currentState.fields;
    final results = await compute();

    // ignore: use_build_context_synchronously
    return pdfGenerator.generate(context, fields, results);
  }
}
