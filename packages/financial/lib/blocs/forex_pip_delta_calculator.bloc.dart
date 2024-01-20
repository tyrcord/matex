// Dart imports:
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';
import 'package:tenhance/decimal.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

// Initialize default state for the Pip Value Calculator
final _kDefaultPipValueBlocState = MatexForexPipDeltaCalculatorBlocState(
  fields: MatexForexPipDeltaCalculatorBlocFields(),
  results: const MatexForexPipDeltaCalculatorBlocResults(),
);

class MatexForexPipDeltaCalculatorBloc extends MatexFinancialCalculatorBloc<
        MatexForexPipDeltaCalculator,
        FastCalculatorBlocEvent,
        MatexForexPipDeltaCalculatorBlocState,
        MatexForexPipDeltaCalculatorDocument,
        MatexForexPipDeltaCalculatorBlocResults>
    with MatexFinancialCalculatorFormatterMixin {
  MatexForexPipDeltaCalculatorBloc({
    MatexForexPipDeltaCalculatorBlocState? initialState,
    MatexForexPipDeltaCalculatorDataProvider? dataProvider,
    super.debouceComputeEvents = true,
    super.getExportDialog,
    super.delegate,
    super.getContext,
  }) : super(
          initialState: initialState ?? _kDefaultPipValueBlocState,
          dataProvider:
              dataProvider ?? MatexForexPipDeltaCalculatorDataProvider(),
          debugLabel: 'MatexForexPipDeltaCalculatorBloc',
        ) {
    calculator = MatexForexPipDeltaCalculator();

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorFinancialInstrument.name,
      MatexForexPipDeltaCalculatorBlocKey.instrument,
    );
  }

  @override
  Future<MatexForexPipDeltaCalculatorBlocResults> compute() async {
    if (await isCalculatorStateValid()) {
      final results = calculator.value();
      final numberOfPips = results.numberOfPips;

      return MatexForexPipDeltaCalculatorBlocResults(
        formattedNumberOfPips: localizeNumber(
          maximumFractionDigits: 1,
          value: numberOfPips,
        ),
        numberOfPips: numberOfPips,
      );
    }

    return retrieveDefaultResult();
  }

  @override
  Future<MatexForexPipDeltaCalculatorDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value is Map<dynamic, dynamic> &&
        key == MatexForexPipDeltaCalculatorBlocKey.instrument) {
      value = MatexFinancialInstrument.fromJson(value);
    }

    if (value == null) {
      switch (key) {
        case MatexForexPipDeltaCalculatorBlocKey.priceA:
          return document.copyWithDefaults(resetPriceA: true);

        case MatexForexPipDeltaCalculatorBlocKey.priceB:
          return document.copyWithDefaults(resetPriceB: true);

        case MatexForexPipDeltaCalculatorBlocKey.instrument:
          return document.copyWithDefaults(
            resetPipDecimalPlaces: true,
            resetCounter: true,
            resetBase: true,
          );

        case MatexForexPipDeltaCalculatorBlocKey.pipDecimalPlaces:
          return document.copyWithDefaults(resetPipDecimalPlaces: true);
      }
    } else if (value is String) {
      switch (key) {
        case MatexForexPipDeltaCalculatorBlocKey.priceA:
          return document.copyWith(priceA: value);

        case MatexForexPipDeltaCalculatorBlocKey.priceB:
          return document.copyWith(priceB: value);

        case MatexForexPipDeltaCalculatorBlocKey.pipDecimalPlaces:
          return document.copyWith(pipDecimalPlaces: value);
      }
    } else if (value is MatexFinancialInstrument) {
      if (key == MatexForexPipDeltaCalculatorBlocKey.instrument) {
        final pipDecimalPlaces = await getPipPrecision(
          counter: value.counter,
          base: value.base,
        );

        return document.copyWith(
          pipDecimalPlaces: pipDecimalPlaces.toString(),
          counter: value.counter,
          base: value.base,
        );
      }
    }

    return null;
  }

  @override
  Future<MatexForexPipDeltaCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is Map<dynamic, dynamic> &&
        key == MatexForexPipDeltaCalculatorBlocKey.instrument) {
      value = MatexFinancialInstrument.fromJson(value);
    }

    if (value is String?) {
      switch (key) {
        case MatexForexPipDeltaCalculatorBlocKey.priceA:
          return patchPriceA(value);

        case MatexForexPipDeltaCalculatorBlocKey.priceB:
          return patchPriceB(value);

        case MatexForexPipDeltaCalculatorBlocKey.pipDecimalPlaces:
          return patchPipDecimalPlaces(value);

        case MatexForexPipDeltaCalculatorBlocKey.instrument:
          return patchInstrument(null);
      }
    } else if (value is MatexFinancialInstrument) {
      if (key == MatexForexPipDeltaCalculatorBlocKey.instrument) {
        return patchInstrument(value);
      }
    }

    return null;
  }

  @override
  Future<void> resetCalculator(
    MatexForexPipDeltaCalculatorDocument document,
  ) async {
    calculator.setState(MatexForexPipDeltaCalculatorState(
      pipDecimalPlaces: parseStringToInt(document.pipDecimalPlaces),
      priceA: parseStringToDouble(document.priceA),
      priceB: parseStringToDouble(document.priceB),
    ));
  }

  @override
  Future<MatexForexPipDeltaCalculatorBlocState> resetCalculatorBlocState(
    MatexForexPipDeltaCalculatorDocument document,
  ) async {
    final pipDecimalPlaces = await getPipPrecision(
      counter: document.counter,
      base: document.base,
    );

    return _kDefaultPipValueBlocState.copyWith(
      results: await retrieveDefaultResult(),
      fields: MatexForexPipDeltaCalculatorBlocFields(
        pipDecimalPlaces: pipDecimalPlaces.toString(),
        counter: document.counter,
        priceA: document.priceA,
        priceB: document.priceB,
        base: document.base,
      ),
    );
  }

  @override
  Future<MatexForexPipDeltaCalculatorDocument>
      retrieveDefaultCalculatorDocument() async {
    final bloc = FastAppDictBloc.instance;
    final json = bloc.getValue<Map<dynamic, dynamic>?>(
      MatexCalculatorDefaultValueKeys.matexCalculatorFinancialInstrument.name,
    );

    debugLog(
      'retrieveDefaultCalculatorDocument: $json',
      debugLabel: debugLabel,
    );

    int pipDecimalPlaces = kMatexDefaultPipDecimalPlaces;
    MatexFinancialInstrument? instrument;

    if (json != null) {
      instrument = MatexFinancialInstrument.fromJson(json);
      pipDecimalPlaces = await getPipPrecision(
        counter: instrument.counter,
        base: instrument.base,
      );
    }

    return MatexForexPipDeltaCalculatorDocument(
      pipDecimalPlaces: pipDecimalPlaces.toString(),
      counter: instrument?.counter,
      base: instrument?.base,
    );
  }

  @override
  Future<MatexForexPipDeltaCalculatorBlocResults>
      retrieveDefaultResult() async {
    return MatexForexPipDeltaCalculatorBlocResults(
      formattedNumberOfPips: localizeNumber(value: 0),
      numberOfPips: 0,
    );
  }

  MatexForexPipDeltaCalculatorBlocState patchPriceA(String? value) {
    final dValue = toDecimalOrDefault(value);
    var fields = currentState.fields;

    fields = value == null
        ? fields.copyWithDefaults(resetPriceA: true)
        : fields.copyWith(priceA: value);

    calculator.priceA = dValue.toSafeDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexForexPipDeltaCalculatorBlocState patchPriceB(String? value) {
    final dValue = toDecimalOrDefault(value);
    var fields = currentState.fields;

    fields = value == null
        ? fields.copyWithDefaults(resetPriceB: true)
        : fields.copyWith(priceB: value);

    calculator.priceB = dValue.toSafeDouble();

    return currentState.copyWith(fields: fields);
  }

  Future<MatexForexPipDeltaCalculatorBlocState> patchInstrument(
    MatexFinancialInstrument? instrument,
  ) async {
    late final MatexForexPipDeltaCalculatorBlocFields fields;

    if (instrument == null) {
      fields = currentState.fields.copyWithDefaults(
        resetPipDecimalPlaces: true,
        resetCounter: true,
        resetBase: true,
      );

      calculator.pipDecimalPlaces = kMatexDefaultPipDecimalPlaces;
    } else {
      final pipDecimalPlaces = await getPipPrecision(
        counter: instrument.counter,
        base: instrument.base,
      );

      fields = currentState.fields.copyWith(
        pipDecimalPlaces: pipDecimalPlaces.toString(),
        counter: instrument.counter,
        base: instrument.base,
      );

      calculator.pipDecimalPlaces = pipDecimalPlaces;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexPipDeltaCalculatorBlocState patchPipDecimalPlaces(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetPipDecimalPlaces: true);
      calculator.pipDecimalPlaces = kMatexDefaultPipDecimalPlaces;
    } else {
      fields = currentState.fields.copyWith(pipDecimalPlaces: value);
      final dValue = toDecimalOrDefault(value);
      calculator.pipDecimalPlaces = dValue.toSafeDouble().toInt();
    }

    return currentState.copyWith(fields: fields);
  }

  @override
  String getReportFilename() => 'forex_pip_delta_calculator_report';

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexForexPipDeltaCalculatorPdfGenerator();
    final fields = currentState.fields;
    final results = await compute();
    final metadata = currentState.metadata;

    // ignore: use_build_context_synchronously
    return pdfGenerator.generate(context, fields, results, metadata);
  }
}
