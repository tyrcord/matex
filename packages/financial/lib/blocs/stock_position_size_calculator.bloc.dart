// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';
import 'package:tenhance/decimal.dart';

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
    if (value == null) {
      if (key == MatexStockPositionSizeCalculatorBlocKey.accountSize) {
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
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.riskFieldType) {
        return document.copyWith(riskFieldType: value);
      }
    } else if (value is Enum) {
      if (key == MatexStockPositionSizeCalculatorBlocKey.riskFieldType) {
        return document.copyWith(
          riskFieldType: value.name,
          stopLossAmount: '',
          riskPercent: '',
        );
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.position) {
        return document.copyWith(
          position: value.name,
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
      }
    } else if (value is MatexPosition &&
        key == MatexStockPositionSizeCalculatorBlocKey.position) {
      return patchPosition(value);
    } else if (value is Enum) {
      if (key == MatexStockPositionSizeCalculatorBlocKey.riskFieldType) {
        return patchRiskFieldType(value.name);
      }
    }

    return currentState;
  }

  @override
  Future<void> resetCalculator(
    MatexStockPositionSizeCalculatorBlocDocument document,
  ) async {
    final slippagePercent = toDecimalOrDefault(document.slippagePercent);
    final riskPercent = toDecimalOrDefault(document.riskPercent);
    final entryFees = toDecimalOrDefault(document.entryFees);
    final exitFees = toDecimalOrDefault(document.exitFees);

    calculator.setState(MatexStockPositionSizeCalculatorState(
      isShortPosition: document.position == MatexPosition.short.name,
      stopLossAmount: tryParseStringToDouble(document.stopLossAmount),
      stopLossPrice: tryParseStringToDouble(document.stopLossPrice),
      slippagePercent: (slippagePercent / dHundred).toSafeDouble(),
      accountSize: tryParseStringToDouble(document.accountSize),
      entryPrice: tryParseStringToDouble(document.entryPrice),
      riskReward: tryParseStringToDouble(document.riskReward),
      riskPercent: (riskPercent / dHundred).toSafeDouble(),
      entryFees: (entryFees / dHundred).toSafeDouble(),
      exitFees: (exitFees / dHundred).toSafeDouble(),
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
      final dValue = toDecimalOrDefault(value);
      fields = fields.copyWith(accountSize: value);
      calculator.accountSize = dValue.toSafeDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchEntryPrice(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetEntryPrice: true);
      calculator.entryPrice = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = fields.copyWith(entryPrice: value);
      calculator.entryPrice = dValue.toSafeDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchStopLossPrice(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetStopLossPrice: true);
      calculator.stopLossPrice = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = fields.copyWith(stopLossPrice: value);
      calculator.stopLossPrice = dValue.toSafeDouble();
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
      final dValue = toDecimalOrDefault(value);
      fields = fields.copyWith(slippagePercent: value);
      calculator.slippagePercent = (dValue / dHundred).toSafeDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchRiskReward(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetRiskReward: true);
      calculator.riskReward = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = fields.copyWith(riskReward: value);
      calculator.riskReward = dValue.toSafeDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchEntryFees(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetEntryFees: true);

      calculator.entryFees = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = fields.copyWith(entryFees: value);
      calculator.entryFees = (dValue / dHundred).toSafeDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchExitFees(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetExitFees: true);
      calculator.exitFees = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = fields.copyWith(exitFees: value);
      calculator.exitFees = (dValue / dHundred).toSafeDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchRiskPercent(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetRiskPercent: true);
      calculator.riskPercent = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = fields.copyWith(riskPercent: value, stopLossAmount: '');
      calculator.riskPercent = (dValue / dHundred).toSafeDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchStopLossAmount(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetStopLossAmount: true);
      calculator.stopLossAmount = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = fields.copyWith(stopLossAmount: value, riskPercent: '');
      calculator.stopLossAmount = dValue.toSafeDouble();
    }

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
  String getReportFilename() => 'stock_position_size_report';

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexStockPositionSizeCalculatorPdfGenerator();
    final fields = currentState.fields;
    final results = await compute();

    // ignore: use_build_context_synchronously
    return pdfGenerator.generate(context, fields, results);
  }
}
