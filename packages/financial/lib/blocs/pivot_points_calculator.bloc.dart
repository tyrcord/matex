// Dart imports:
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

const _kDefaultPivotPointsBlocResults = MatexPivotPointsCalculatorBlocResults();

final _kDefaultPivotPointsBlocState = MatexPivotPointsCalculatorBlocState(
  fields: MatexPivotPointsCalculatorBlocFields(),
  results: _kDefaultPivotPointsBlocResults,
);

class MatexPivotPointsCalculatorBloc extends MatexCalculatorBloc<
    MatexPivotPointsCalculator,
    FastCalculatorBlocEvent,
    MatexPivotPointsCalculatorBlocState,
    MatexPivotPointsCalculatorDocument,
    MatexPivotPointsCalculatorBlocResults> {
  MatexPivotPointsCalculatorBloc({
    MatexPivotPointsCalculatorBlocState? initialState,
    MatexPivotPointsCalculatorDataProvider? dataProvider,
    super.debouceComputeEvents = true,
    super.getExportDialog,
    super.delegate,
    super.getContext,
  }) : super(
          initialState: initialState ?? _kDefaultPivotPointsBlocState,
          dataProvider:
              dataProvider ?? MatexPivotPointsCalculatorDataProvider(),
          debugLabel: 'MatexPivotPointsCalculatorBloc',
        ) {
    calculator = MatexPivotPointsCalculator();

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexPivotPointsMethod.name,
      MatexPivotPointsCalculatorBlocKey.method,
    );
  }

  static const defaultPrecision = 5;

  @override
  Future<MatexPivotPointsCalculatorBlocResults> compute() async {
    final results = calculator.value();

    return MatexPivotPointsCalculatorBlocResults(
      formattedPivotPoint: _localizeQuote(results.pivotPoint),
      formattedResistances: _localizeQuotes(results.resistances),
      formattedSupports: _localizeQuotes(results.supports),
      resistances: results.resistances,
      supports: results.supports,
      pivotPoint: results.pivotPoint,
    );
  }

  List<String> _localizeQuotes(List<double> values) {
    return values.map(_localizeQuote).toList();
  }

  String _localizeQuote(double? value) {
    return localizeNumber(
      minimumFractionDigits: defaultPrecision,
      value: value,
    );
  }

  @override
  Future<MatexPivotPointsCalculatorDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value == null) {
      if (key == MatexPivotPointsCalculatorBlocKey.lowPrice) {
        return document.copyWithDefaults(resetLowPrice: true);
      } else if (key == MatexPivotPointsCalculatorBlocKey.highPrice) {
        return document.copyWithDefaults(resetHighPrice: true);
      } else if (key == MatexPivotPointsCalculatorBlocKey.method) {
        return document.copyWithDefaults(resetMethod: true);
      } else if (key == MatexPivotPointsCalculatorBlocKey.openPrice) {
        return document.copyWithDefaults(resetOpenPrice: true);
      } else if (key == MatexPivotPointsCalculatorBlocKey.closePrice) {
        return document.copyWithDefaults(resetClosePrice: true);
      }
    } else if (value is String) {
      if (key == MatexPivotPointsCalculatorBlocKey.lowPrice) {
        return document.copyWith(lowPrice: value);
      } else if (key == MatexPivotPointsCalculatorBlocKey.highPrice) {
        return document.copyWith(highPrice: value);
      } else if (key == MatexPivotPointsCalculatorBlocKey.method) {
        return document.copyWith(method: value);
      } else if (key == MatexPivotPointsCalculatorBlocKey.openPrice) {
        return document.copyWith(openPrice: value);
      } else if (key == MatexPivotPointsCalculatorBlocKey.closePrice) {
        return document.copyWith(closePrice: value);
      }
    } else if (value is MatexPivotPointsMethods) {
      if (key == MatexPivotPointsCalculatorBlocKey.method) {
        return document.copyWith(method: value.name);
      }
    }

    return null;
  }

  @override
  Future<MatexPivotPointsCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is String?) {
      if (key == MatexPivotPointsCalculatorBlocKey.lowPrice) {
        return patchLowPrice(value);
      } else if (key == MatexPivotPointsCalculatorBlocKey.highPrice) {
        return patchHighPrice(value);
      } else if (key == MatexPivotPointsCalculatorBlocKey.method) {
        return patchMethod(value);
      } else if (key == MatexPivotPointsCalculatorBlocKey.openPrice) {
        return patchOpenPrice(value);
      } else if (key == MatexPivotPointsCalculatorBlocKey.closePrice) {
        return patchClosePrice(value);
      }
    } else if (value is MatexPivotPointsMethods) {
      if (key == MatexPivotPointsCalculatorBlocKey.method) {
        return patchMethod(value.name);
      }
    }

    return currentState;
  }

  @override
  Future<void> resetCalculator(
    MatexPivotPointsCalculatorDocument document,
  ) async {
    calculator.setState(MatexPivotPointsCalculatorState(
      method: MatexPivotPointsMethodsX.fromName(document.method),
      highPrice: tryParseStringToDouble(document.highPrice),
      lowPrice: tryParseStringToDouble(document.lowPrice),
      closePrice: tryParseStringToDouble(document.closePrice),
      openPrice: tryParseStringToDouble(document.openPrice),
    ));
  }

  @override
  Future<MatexPivotPointsCalculatorBlocState> resetCalculatorBlocState(
    MatexPivotPointsCalculatorDocument document,
  ) async {
    return _kDefaultPivotPointsBlocState.copyWith(
      results: await retrieveDefaultResult(),
      fields: MatexPivotPointsCalculatorBlocFields(
        method: MatexPivotPointsMethodsX.fromName(document.method),
        highPrice: document.highPrice,
        lowPrice: document.lowPrice,
        closePrice: document.closePrice,
        openPrice: document.openPrice,
      ),
    );
  }

  @override
  Future<MatexPivotPointsCalculatorDocument>
      retrieveDefaultCalculatorDocument() async {
    final bloc = FastAppDictBloc.instance;

    final method = bloc.getValue<String?>(
      MatexCalculatorDefaultValueKeys.matexPivotPointsMethod.name,
    );

    if (MatexPivotPointsMethodsX.hasName(method)) {
      return MatexPivotPointsCalculatorDocument(method: method);
    }

    return MatexPivotPointsCalculatorDocument();
  }

  @override
  Future<MatexPivotPointsCalculatorBlocResults> retrieveDefaultResult() async {
    return _kDefaultPivotPointsBlocResults;
  }

  MatexPivotPointsCalculatorBlocState patchLowPrice(String? value) {
    late MatexPivotPointsCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetLowPrice: true,
      );

      calculator.lowPrice = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(lowPrice: value);
      calculator.lowPrice = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexPivotPointsCalculatorBlocState patchHighPrice(String? value) {
    late MatexPivotPointsCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetHighPrice: true,
      );

      calculator.highPrice = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(highPrice: value);
      calculator.highPrice = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexPivotPointsCalculatorBlocState patchOpenPrice(String? value) {
    late MatexPivotPointsCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetOpenPrice: true,
      );

      calculator.openPrice = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(openPrice: value);
      calculator.openPrice = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexPivotPointsCalculatorBlocState patchClosePrice(String? value) {
    late MatexPivotPointsCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetClosePrice: true,
      );

      calculator.closePrice = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(closePrice: value);
      calculator.closePrice = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexPivotPointsCalculatorBlocState patchMethod(
    String? value,
  ) {
    late MatexPivotPointsCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetMethod: true,
      );

      calculator.method = MatexPivotPointsMethods.standard;
    } else {
      final method = MatexPivotPointsMethodsX.fromName(value);
      fields = currentState.fields.copyWith(method: method);
      calculator.method = method!;
    }

    return currentState.copyWith(fields: fields);
  }

  @override
  String getReportFilename() => 'pivot_points_report';

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexPivotPointsCalculatorPdfGenerator();
    final fields = currentState.fields;
    final results = await compute();

    // ignore: use_build_context_synchronously
    return pdfGenerator.generate(context, fields, results);
  }
}
