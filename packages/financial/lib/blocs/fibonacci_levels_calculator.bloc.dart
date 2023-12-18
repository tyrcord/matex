import 'dart:typed_data';

import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:flutter/widgets.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

const _kDefaultFibonacciLevelsBlocResults =
    MatexFibonacciLevelsCalculatorBlocResults();

final _kDefaultFibonacciLevelsBlocState =
    MatexFibonacciLevelsCalculatorBlocState(
  fields: MatexFibonacciLevelsCalculatorBlocFields(),
  results: _kDefaultFibonacciLevelsBlocResults,
);

class MatexFibonacciLevelsCalculatorBloc extends MatexCalculatorBloc<
        MatexFibonacciLevelsCalculator,
        FastCalculatorBlocEvent,
        MatexFibonacciLevelsCalculatorBlocState,
        MatexFibonacciLevelsCalculatorDocument,
        MatexFibonacciLevelsCalculatorBlocResults>
    implements FastCalculatorBlocDelegate {
  MatexFibonacciLevelsCalculatorBloc({
    MatexFibonacciLevelsCalculatorBlocState? initialState,
    MatexFibonacciLevelsCalculatorDataProvider? dataProvider,
    super.debouceComputeEvents = true,
    super.showExportPdfDialog,
    super.delegate,
  }) : super(
          initialState: initialState ?? _kDefaultFibonacciLevelsBlocState,
          dataProvider:
              dataProvider ?? MatexFibonacciLevelsCalculatorDataProvider(),
          debugLabel: 'MatexFibonacciLevelsCalculatorBloc',
        ) {
    calculator = MatexFibonacciLevelsCalculator();
  }

  @override
  Future<bool> canAutoRefreshComputations() async => true;

  @override
  Future<MatexFibonacciLevelsCalculatorBlocResults> compute() async {
    final results = calculator.value();

    return MatexFibonacciLevelsCalculatorBlocResults(
      retracementLevels: formatFibonacciLevels(results.retracementLevels),
      extensionLevels: formatFibonacciLevels(results.extensionLevels),
    );
  }

  List<MatexFibonacciLevel> formatFibonacciLevels(
    List<MatexFibonacciLevel> levels,
  ) {
    return levels.map((e) => e.copyWith(delegate: this)).toList();
  }

  @override
  Future<MatexFibonacciLevelsCalculatorDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value == null) {
      if (key == MatexFibonacciLevelsCalculatorBlocKey.lowPrice) {
        return document.copyWithDefaults(resetLowPrice: true);
      } else if (key == MatexFibonacciLevelsCalculatorBlocKey.highPrice) {
        return document.copyWithDefaults(resetHighPrice: true);
      } else if (key == MatexFibonacciLevelsCalculatorBlocKey.trend) {
        return document.copyWithDefaults(resetMethod: true);
      }
    } else if (value is String) {
      if (key == MatexFibonacciLevelsCalculatorBlocKey.lowPrice) {
        return document.copyWith(lowPrice: value);
      } else if (key == MatexFibonacciLevelsCalculatorBlocKey.highPrice) {
        return document.copyWith(highPrice: value);
      } else if (key == MatexFibonacciLevelsCalculatorBlocKey.trend) {
        return document.copyWith(trend: value);
      }
    } else if (value is MatexTrend) {
      return document.copyWith(trend: value.name);
    }

    return null;
  }

  @override
  Future<MatexFibonacciLevelsCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is String?) {
      if (key == MatexFibonacciLevelsCalculatorBlocKey.lowPrice) {
        return patchLowPrice(value);
      } else if (key == MatexFibonacciLevelsCalculatorBlocKey.highPrice) {
        return patchHighPrice(value);
      } else if (key == MatexFibonacciLevelsCalculatorBlocKey.trend) {
        return patchTrend(null);
      }
    } else if (value is MatexTrend) {
      return patchTrend(value);
    }

    return currentState;
  }

  @override
  Future<void> resetCalculator(
    MatexFibonacciLevelsCalculatorDocument document,
  ) async {
    calculator.setState(MatexFibonacciLevelsCalculatorState(
      lowPrice: parseStringToDouble(document.lowPrice),
      highPrice: parseStringToDouble(document.highPrice),
      trend: MatexTrendX.fromName(document.trend),
    ));
  }

  @override
  Future<MatexFibonacciLevelsCalculatorBlocState> resetCalculatorBlocState(
    MatexFibonacciLevelsCalculatorDocument document,
  ) async {
    return _kDefaultFibonacciLevelsBlocState.copyWith(
      results: await retrieveDefaultResult(),
      fields: MatexFibonacciLevelsCalculatorBlocFields(
        trend: MatexTrendX.fromName(document.trend),
        lowPrice: document.lowPrice,
        highPrice: document.highPrice,
      ),
    );
  }

  @override
  Future<MatexFibonacciLevelsCalculatorDocument>
      retrieveDefaultCalculatorDocument() async {
    return MatexFibonacciLevelsCalculatorDocument();
  }

  @override
  Future<MatexFibonacciLevelsCalculatorBlocResults>
      retrieveDefaultResult() async {
    return _kDefaultFibonacciLevelsBlocResults;
  }

  MatexFibonacciLevelsCalculatorBlocState patchLowPrice(String? value) {
    late MatexFibonacciLevelsCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetLowPrice: true,
      );

      calculator.lowPrice = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = currentState.fields.copyWith(lowPrice: value);
      calculator.lowPrice = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexFibonacciLevelsCalculatorBlocState patchHighPrice(String? value) {
    late MatexFibonacciLevelsCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetHighPrice: true,
      );

      calculator.highPrice = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = currentState.fields.copyWith(highPrice: value);
      calculator.highPrice = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexFibonacciLevelsCalculatorBlocState patchTrend(MatexTrend? value) {
    late MatexFibonacciLevelsCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetMethod: true);
      calculator.trend = MatexTrend.up;
    } else {
      fields = currentState.fields.copyWith(trend: value);
      calculator.trend = value;
    }

    return currentState.copyWith(fields: fields);
  }

  @override
  String getReportFilename() => 'fibonacci_levels_report';

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexFibonacciLevelsCalculatorPdfGenerator();
    final fields = currentState.fields;
    final results = await compute();

    // ignore: use_build_context_synchronously
    return pdfGenerator.generate(context, fields, results);
  }
}
