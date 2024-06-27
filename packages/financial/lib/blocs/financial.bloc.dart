// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:lingua_finance/generated/locale_keys.g.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';
import 'package:tlogger/logger.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

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

  TLogger? logger;

  @protected
  String? get userDefaultRiskPercent {
    final bloc = FastAppDictBloc.instance;

    return bloc.getValue<String?>(
      MatexCalculatorDefaultValueKeys.matexCalculatorRiskPercent.name,
    );
  }

  double? get userDefaultLeverage {
    final bloc = FastAppDictBloc.instance;

    return bloc.getValue<double?>(
      MatexCalculatorDefaultValueKeys.matexCalculatorLeverage.name,
    );
  }

  String? get userDefaultRiskType {
    final bloc = FastAppDictBloc.instance;

    return bloc.getValue<String?>(
      MatexCalculatorDefaultValueKeys.matexCalculatorRiskType.name,
    );
  }

  String? get userDefaultStopLossType {
    final bloc = FastAppDictBloc.instance;

    return bloc.getValue<String?>(
      MatexCalculatorDefaultValueKeys.matexCalculatorStopLossType.name,
    );
  }

  String? get userDefaultTakeProfitType {
    final bloc = FastAppDictBloc.instance;

    return bloc.getValue<String?>(
      MatexCalculatorDefaultValueKeys.matexCalculatorTakeProfitType.name,
    );
  }

  @protected
  MatexFinancialInstrument? get userDefaultInstrument {
    final bloc = FastAppDictBloc.instance;
    final json = bloc.getValue<Map<dynamic, dynamic>?>(
      MatexCalculatorDefaultValueKeys.matexCalculatorFinancialInstrument.name,
    );

    if (json != null) return MatexFinancialInstrument.fromJson(json);

    return null;
  }

  MatexFinancialCalculatorBloc({
    required super.dataProvider,
    super.exportAlternativeAction,
    super.debouceComputeEvents = false,
    super.isAutoRefreshEnabled = false,
    super.getExportDialog,
    super.autoRefreshPeriod,
    this.exchangeProvider,
    super.initialState,
    super.debugLabel,
    super.delegate,
    super.getContext,
  });

  Map<String, dynamic> get emptyInstrumentMetadata => const {
        'formattedInstrumentExchangeRate': null,
        'instrumentExchangeRate': null,
        'instrumentMetadata': null,
        'standardLotSize': null,
        'rateUpdatedOn': null,
        'microLotSize': null,
        'miniLotSize': null,
      };

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

    String? counter;

    if (currentState.fields is MatexFinancialInstrumentCalculatorBlocFields) {
      final fields =
          currentState.fields as MatexFinancialInstrumentCalculatorBlocFields;
      counter = fields.counter;
    }

    return {
      ...metadata,
      'standardLotSize': await getUnitsPerStandardLot(),
      'microLotSize': await getUnitsPerMicroLot(),
      'miniLotSize': await getUnitsPerMiniLot(),
      'instrumentMetadata': instrumentMetadata,
      if (counter != null)
        'counterSymbol': getCurrencySymbol(
          localeCode: getUserLocaleCode(),
          currencyCode: counter,
        ),
    };
  }

  @override
  @protected
  @mustCallSuper
  Stream<S> willCompute() async* {
    yield* super.willCompute();

    final metadata = await loadMetadata();

    yield currentState.copyWith(metadata: metadata) as S;
  }

  Future<MatexQuote?> fetchInstrumentExchangeRate(
    MatexFinancialInstrument instrument,
  ) async {
    if (instrument.symbol == null || exchangeProvider == null) {
      logger?.warning('No exchange provider or symbol found');
      return null;
    }

    final symbol = instrument.symbol!;
    MatexQuote? quote;

    try {
      // Note: we don't need to use a retry mechanism here because the
      // exchange provider already implements it.
      quote = await exchangeProvider!.rate(symbol);

      if (quote == null) {
        throw Exception('Exchange provider returned a null quote');
      }
    } catch (error, stackTrace) {
      logger?.error('Unable to retrieve the $symbol exchange rate');
      logger?.error(error.toString(), stackTrace);

      if (context != null) {
        FastNotificationCenter.error(
          context!,
          FinanceLocaleKeys.finance_error_quote_unavailable.tr(
            namedArgs: {'symbol': symbol},
          ),
        );
      }
    }

    return quote;
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
          'formattedInstrumentExchangeRate': superscriptLastCharacter(
            localizeQuote(
              metadata: instrumentMetadata,
              rate: quote.price,
            ),
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

  Future<double> getUnitsPerStandardLot() async {
    final metadata = await getInstrumentMetadata();

    return metadata?.lots?.standard ?? 0;
  }

  Future<double> getUnitsPerMiniLot() async {
    final metadata = await getInstrumentMetadata();

    return metadata?.lots?.mini ?? 0;
  }

  Future<double> getUnitsPerMicroLot() async {
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

      if (multiplier != 0) return positionSize * multiplier;
    }

    return positionSize;
  }

  @protected
  num computePipValueForUnits(num units, num pipValue, num? positionSize) {
    var unitaryPipValue = 0.0;

    if (positionSize != null && positionSize > 0) {
      unitaryPipValue = (pipValue / positionSize);
    }

    return (units * unitaryPipValue);
  }
}
