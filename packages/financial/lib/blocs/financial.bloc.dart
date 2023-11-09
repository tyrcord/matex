import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:flutter/foundation.dart';
import 'package:matex_core/core.dart';
import 'package:matex_dart/matex_dart.dart'
    show MatexPairPipMetadata, MatexPairMetadata, MatexPairMetadataProvider;
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';

abstract class MatexFinancialCalculatorBloc<
        C extends MatexCalculator,
        E extends FastCalculatorBlocEvent,
        S extends FastCalculatorBlocState,
        D extends FastCalculatorDocument,
        R extends FastCalculatorResults>
    extends MatexCalculatorBloc<C, E, S, D, R> {
  @protected
  final instrumentsProvider = MatexPairMetadataProvider();

  int get defaultPipDecimalPlaces {
    return MatexPairPipMetadata.defaultMetatada().precision;
  }

  MatexFinancialCalculatorBloc({
    required super.dataProvider,
    super.showExportPdfDialog,
    super.debouceComputeEvents,
    super.initialState,
    super.debugLabel,
    super.delegate,
  });

  Future<bool> isMandatoryFieldValid() async => true;

  @override
  Future<bool> isCalculatorStateValid() async {
    if (!await isMandatoryFieldValid()) return false;

    return calculator.isValid;
  }

  Future<int> getPipPrecision({
    String? baseCurrency,
    String? counterCurrency,
  }) async {
    if (baseCurrency == null || counterCurrency == null) {
      return defaultPipDecimalPlaces;
    }

    final pair = baseCurrency + counterCurrency;
    final tradingPairMetadata = await instrumentsProvider.metadata(pair);
    final pipMetadata = tradingPairMetadata?.pip;

    return pipMetadata?.precision ?? defaultPipDecimalPlaces;
  }

  Future<MatexPairMetadata?> getInstrumentMetadata({
    String? baseCurrency,
    String? counterCode,
  }) async {
    if (currentState.fields is MatexFinancialInstrumentCalculatorBlocFields) {
      final fields =
          currentState.fields as MatexFinancialInstrumentCalculatorBlocFields;
      baseCurrency ??= fields.baseCurrency;
      counterCode ??= fields.counterCurrency;
    }

    if (baseCurrency == null || counterCode == null) return null;

    return instrumentsProvider.metadata(baseCurrency + counterCode);
  }

  Future<int> getStandardLotValue() async {
    final baseMetadata = await getInstrumentMetadata();

    return baseMetadata?.lots!.standard ?? 0;
  }

  Future<int> getMiniLotValue() async {
    final baseMetadata = await getInstrumentMetadata();

    return baseMetadata?.lots!.mini ?? 0;
  }

  Future<int> getMicroLotValue() async {
    final baseMetadata = await getInstrumentMetadata();

    return baseMetadata?.lots!.micro ?? 0;
  }

  @protected
  num computePipValueForLotSize(num lotSize, num pipValue, num? positionSize) {
    double unitaryPipValue = 0.0;

    if (positionSize != null && positionSize > 0) {
      final dPipValue = toDecimal(pipValue) ?? dZero;
      final dPositionSize = toDecimal(positionSize)!;

      unitaryPipValue =
          decimalFromRational(dPipValue / dPositionSize).toDouble();
    }

    return lotSize * unitaryPipValue;
  }
}
