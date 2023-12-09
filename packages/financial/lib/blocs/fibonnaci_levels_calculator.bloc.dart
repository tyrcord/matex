import 'dart:typed_data';

import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:flutter/widgets.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

const _kDefaultFibonnaciLevelsBlocResults =
    MatexFibonnaciLevelsCalculatorBlocResults();

final _kDefaultFibonnaciLevelsBlocState =
    MatexFibonnaciLevelsCalculatorBlocState(
  fields: MatexFibonnaciLevelsCalculatorBlocFields(),
  results: _kDefaultFibonnaciLevelsBlocResults,
);

class MatexFibonnaciLevelsCalculatorBloc extends MatexCalculatorBloc<
    MatexFibonnaciLevelsCalculator,
    FastCalculatorBlocEvent,
    MatexFibonnaciLevelsCalculatorBlocState,
    MatexFibonnaciLevelsCalculatorDocument,
    MatexFibonnaciLevelsCalculatorBlocResults> {
  MatexFibonnaciLevelsCalculatorBloc({
    MatexFibonnaciLevelsCalculatorBlocState? initialState,
    MatexFibonnaciLevelsCalculatorDataProvider? dataProvider,
    super.debouceComputeEvents = true,
    super.showExportPdfDialog,
    super.delegate,
  }) : super(
          initialState: initialState ?? _kDefaultFibonnaciLevelsBlocState,
          dataProvider:
              dataProvider ?? MatexFibonnaciLevelsCalculatorDataProvider(),
          debugLabel: 'MatexFibonnaciLevelsCalculatorBloc',
        ) {
    calculator = MatexFibonnaciLevelsCalculator();
  }

  @override
  Future<MatexFibonnaciLevelsCalculatorBlocResults> compute() async {
    final results = calculator.value();

    return MatexFibonnaciLevelsCalculatorBlocResults(
      extensionLevels: results.extensionLevels,
      retracementLevels: results.retracementLevels,
    );
  }

  @override
  Future<MatexFibonnaciLevelsCalculatorDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      if (key == MatexFibonnaciLevelsCalculatorBlocKey.lowPrice) {
        return document.copyWith(lowPrice: value);
      } else if (key == MatexFibonnaciLevelsCalculatorBlocKey.highPrice) {
        return document.copyWith(highPrice: value);
      } else if (key == MatexFibonnaciLevelsCalculatorBlocKey.trend) {
        return document.copyWith(trend: value);
      }
    } else if (value is MatexTrend) {
      return document.copyWith(trend: value.name);
    }

    return null;
  }

  @override
  Future<MatexFibonnaciLevelsCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is String?) {
      if (key == MatexFibonnaciLevelsCalculatorBlocKey.lowPrice) {
        return patchLowPrice(value);
      } else if (key == MatexFibonnaciLevelsCalculatorBlocKey.highPrice) {
        return patchHighPrice(value);
      } else if (key == MatexFibonnaciLevelsCalculatorBlocKey.trend) {
        return patchTrend(value);
      }
    } else if (value is MatexTrend) {
      return patchTrend(value.name);
    }

    return currentState;
  }

  @override
  Future<void> resetCalculator(
    MatexFibonnaciLevelsCalculatorDocument document,
  ) async {
    calculator.setState(MatexFibonnaciLevelsCalculatorState(
      lowPrice: parseStringToDouble(document.lowPrice),
      highPrice: parseStringToDouble(document.highPrice),
      trend: MatexTrendX.fromName(document.trend),
    ));
  }

  @override
  Future<MatexFibonnaciLevelsCalculatorBlocState> resetCalculatorBlocState(
    MatexFibonnaciLevelsCalculatorDocument document,
  ) async {
    return _kDefaultFibonnaciLevelsBlocState.copyWith(
      results: await retrieveDefaultResult(),
      fields: MatexFibonnaciLevelsCalculatorBlocFields(
        lowPrice: document.lowPrice,
        highPrice: document.highPrice,
        trend: document.trend,
      ),
    );
  }

  @override
  Future<MatexFibonnaciLevelsCalculatorDocument>
      retrieveDefaultCalculatorDocument() async {
    return MatexFibonnaciLevelsCalculatorDocument();
  }

  @override
  Future<MatexFibonnaciLevelsCalculatorBlocResults>
      retrieveDefaultResult() async {
    return _kDefaultFibonnaciLevelsBlocResults;
  }

  MatexFibonnaciLevelsCalculatorBlocState patchLowPrice(String? value) {
    late MatexFibonnaciLevelsCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetLowPrice: true,
      );

      calculator.lowPrice = 0;
    } else {
      final dValue = toDecimal(value) ?? dZero;
      fields = currentState.fields.copyWith(lowPrice: value);
      calculator.lowPrice = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexFibonnaciLevelsCalculatorBlocState patchHighPrice(String? value) {
    late MatexFibonnaciLevelsCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetHighPrice: true,
      );

      calculator.highPrice = 0;
    } else {
      final dValue = toDecimal(value) ?? dZero;
      fields = currentState.fields.copyWith(highPrice: value);
      calculator.highPrice = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexFibonnaciLevelsCalculatorBlocState patchTrend(String? value) {
    late MatexFibonnaciLevelsCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetMethod: true,
      );

      calculator.trend = MatexTrend.up;
    } else {
      fields = currentState.fields.copyWith(trend: value);
      calculator.trend = MatexTrendX.fromName(value);
    }

    return currentState.copyWith(fields: fields);
  }

  @override
  String getReportFilename() => 'fibonnaci_levels_report';

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexFibonnaciLevelsCalculatorPdfGenerator();
    final fields = currentState.fields;
    final results = await compute();

    // ignore: use_build_context_synchronously
    return pdfGenerator.generate(context, fields, results);
  }
}
