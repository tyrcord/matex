import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:flutter/foundation.dart';
import 'package:matex_core/core.dart';
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
  final instrumentPairMetadataService =
      MatexFinancialInstrumentPairMetadataService();

  MatexFinancialCalculatorBloc({
    required super.dataProvider,
    super.debouceComputeEvents = false,
    super.isAutoRefreshEnabled = false,
    super.showExportPdfDialog,
    super.autoRefreshPeriod,
    super.initialState,
    super.debugLabel,
    super.delegate,
  });

  void listenToPrimaryCurrencyCodeChanges() {
    subxList.add(appSettingsBloc.onData
        .where((event) => isInitialized)
        .distinct((previous, next) {
      final previousValue = previous.primaryCurrencyCode;
      final nextValue = next.primaryCurrencyCode;

      return previousValue == nextValue;
    }).listen(handlePrimaryCurrencyCodeChanges));
  }

  void handlePrimaryCurrencyCodeChanges(FastAppSettingsBlocState state) {
    if (isInitialized) {
      addEvent(FastCalculatorBlocEvent.retrieveDefaultValues());

      addEvent(FastCalculatorBlocEvent.patchValue(
        key: MatexFiancialCalculatorBlocKey.accountCurrency,
        value: getUserCurrencyCode(),
      ));
    }
  }

  @override
  Future<bool> isCalculatorStateValid() async {
    if (!isMandatoryFieldValid) return false;

    return calculator.isValid;
  }

  Future<int> getPipPrecision({String? base, String? counter}) async {
    if (base == null || counter == null) {
      return kDefaultPipPipDecimalPlaces;
    }

    final pair = base + counter;
    final tradingPairMetadata =
        await instrumentPairMetadataService.metadata(pair);
    final pipMetadata = tradingPairMetadata?.pip;

    return pipMetadata?.precision ?? kDefaultPipPipDecimalPlaces;
  }

  Future<MatexPairMetadata?> getInstrumentMetadata({
    String? base,
    String? counter,
  }) async {
    if (currentState.fields is MatexFinancialInstrumentCalculatorBlocFields) {
      final fields =
          currentState.fields as MatexFinancialInstrumentCalculatorBlocFields;
      base ??= fields.base;
      counter ??= fields.counter;
    }

    if (base == null || counter == null) return null;

    return instrumentPairMetadataService.metadata(base + counter);
  }

  Future<int> getStandardLotValue() async {
    final metadata = await getInstrumentMetadata();

    return metadata?.lots?.standard ?? 0;
  }

  Future<int> getMiniLotValue() async {
    final metadata = await getInstrumentMetadata();

    return metadata?.lots?.mini ?? 0;
  }

  Future<int> getMicroLotValue() async {
    final metadata = await getInstrumentMetadata();

    return metadata?.lots?.micro ?? 0;
  }

  Future<double> getPositionSizeForLotSize({
    required MatexPositionSizeType lotSize,
    double positionSize = 0,
  }) async {
    final metadata = await getInstrumentMetadata();

    if (metadata != null && metadata.lots != null) {
      final multiplier = metadata.lots![lotSize];

      if (multiplier != 0) {
        return (toDecimal(positionSize)! * toDecimal(multiplier)!).toDouble();
      }
    }

    return positionSize;
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
