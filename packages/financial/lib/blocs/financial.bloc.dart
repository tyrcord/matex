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
    extends MatexCalculatorBloc<C, E, S, D, R>
    with MatexFinancialCalculatorFormatterMixin {
  @protected
  final instrumentPairMetadataService =
      MatexFinancialInstrumentPairMetadataService();

  final MatexFinancialInstrumentExchangeService? exchangeProvider;

  MatexFinancialCalculatorBloc({
    required super.dataProvider,
    super.debouceComputeEvents = false,
    super.isAutoRefreshEnabled = false,
    super.showExportPdfDialog,
    super.autoRefreshPeriod,
    this.exchangeProvider,
    super.initialState,
    super.debugLabel,
    super.delegate,
  });

  @override
  @mustCallSuper
  void close() {
    if (!isClosed && canClose()) {
      exchangeProvider?.dispose();
      super.close();
    }
  }

  /// Loads the metadata
  @override
  @mustCallSuper
  Future<Map<String, dynamic>> loadMetadata() async {
    final metadata = await super.loadMetadata();

    if (!hasInstrumentValid) return metadata;

    final instrumentMetadata = await getInstrumentMetadata();

    return {
      ...metadata,
      'standardLotSize': await getUnitsPerStandardLot(),
      'microLotSize': await getUnitsPerMiniLot(),
      'miniLotSize': await getUnitsPerMicroLot(),
      'instrumentMetadata': instrumentMetadata,
    };
  }

  // TODO: catch errors
  Future<MatexQuote?> fetchInstrumentExchangeRate(
    MatexFinancialInstrument instrument,
  ) async {
    if (instrument.symbol == null || exchangeProvider == null) return null;

    // Note: we don't need to use a retry mechanism here because the
    // exchange provider already implements it.
    return exchangeProvider!.rate(instrument.symbol!);
  }

  Stream<S> patchInstrumentExchangeRate(
    MatexFinancialInstrument instrument,
  ) async* {
    if (hasInstrumentValid) {
      var metadata = mergeMetadata({'isFetchingInstrumentExchangeRate': true});

      yield currentState.copyWith(metadata: metadata) as S;

      final quote = await fetchInstrumentExchangeRate(instrument);
      Map<String, dynamic>? partialMetadata;

      if (quote != null) {
        final instrumentMetadata = await getInstrumentMetadata();

        partialMetadata = {
          'formattedInstrumentExchangeRate': localizeQuote(
            metadata: instrumentMetadata,
            rate: quote.price,
          ),
          'rateUpdatedOn': await localizeTimestampInMilliseconds(
            quote.timestamp,
          ),
          'instrumentExchangeRate': quote.price,
        };
      }

      metadata = mergeMetadata({
        ...?partialMetadata,
        'isFetchingInstrumentExchangeRate': false,
      });

      yield currentState.copyWith(metadata: metadata) as S;
    }
  }

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
    if (!hasInstrumentValid) return false;

    return calculator.isValid;
  }

  Future<int> getPipPrecision({String? base, String? counter}) async {
    if (base == null || counter == null) return kMatexDefaultPipDecimalPlaces;

    final symbol = base + counter;
    final tradingPairMetadata =
        await instrumentPairMetadataService.metadata(symbol);
    final pipMetadata = tradingPairMetadata?.pip;

    return pipMetadata?.precision ?? kMatexDefaultPipDecimalPlaces;
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

  bool get hasInstrumentValid {
    if (currentState.fields is MatexFinancialInstrumentCalculatorBlocFields) {
      final fields =
          currentState.fields as MatexFinancialInstrumentCalculatorBlocFields;

      return fields.base != null && fields.counter != null;
    }

    return false;
  }

  Future<int> getUnitsPerStandardLot() async {
    final metadata = await getInstrumentMetadata();

    return metadata?.lots?.standard ?? 0;
  }

  Future<int> getUnitsPerMiniLot() async {
    final metadata = await getInstrumentMetadata();

    return metadata?.lots?.mini ?? 0;
  }

  Future<int> getUnitsPerMicroLot() async {
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
  num computePipValueForUnits(num units, num pipValue, num? positionSize) {
    final dUnits = toDecimalOrDefault(units);
    var unitaryPipValue = dZero;

    if (positionSize != null && positionSize > 0) {
      final dPositionSize = toDecimalOrDefault(positionSize);
      final dPipValue = toDecimalOrDefault(pipValue);
      unitaryPipValue = decimalFromRational(dPipValue / dPositionSize);
    }

    return (dUnits * unitaryPipValue).toDouble();
  }
}
