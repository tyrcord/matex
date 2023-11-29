// Package imports:
import 'dart:typed_data';

import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:flutter/material.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';
import 'package:lingua_finance_dividend/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

const _kDefaultDividendPayoutRatioBlocResults =
    MatexDividendPayoutRatioCalculatorBlocResults(
  formattedDividendPayoutRatio: '0%',
  dividendPayoutRatio: 0,
);

final _kDefaultDividendPayoutRatioBlocState =
    MatexDividendPayoutRatioCalculatorBlocState(
  fields: MatexDividendPayoutRatioCalculatorBlocFields(),
  results: _kDefaultDividendPayoutRatioBlocResults,
);

class MatexDividendPayoutRatioCalculatorBloc extends MatexCalculatorBloc<
    MatexDividendPayoutRatioCalculator,
    FastCalculatorBlocEvent,
    MatexDividendPayoutRatioCalculatorBlocState,
    MatexDividendPayoutRatioCalculatorDocument,
    MatexDividendPayoutRatioCalculatorBlocResults> {
  MatexDividendPayoutRatioCalculatorBloc({
    MatexDividendPayoutRatioCalculatorBlocState? initialState,
    MatexDividendPayoutRatioCalculatorDataProvider? dataProvider,
    super.debouceComputeEvents = true,
    super.showExportPdfDialog,
    super.delegate,
  }) : super(
          initialState: initialState ?? _kDefaultDividendPayoutRatioBlocState,
          dataProvider:
              dataProvider ?? MatexDividendPayoutRatioCalculatorDataProvider(),
          debugLabel: 'MatexDividendPayoutRatioCalculatorBloc',
        ) {
    calculator = MatexDividendPayoutRatioCalculator();
  }

  @override
  Future<MatexDividendPayoutRatioCalculatorBlocResults> compute() async {
    final results = calculator.value();
    final dividendPayoutRatio = results.dividendPayoutRatio;

    return MatexDividendPayoutRatioCalculatorBlocResults(
      dividendPayoutLevel: determineDividendPayoutLevel(dividendPayoutRatio),
      dividendPayoutRatio: dividendPayoutRatio,
      formattedDividendPayoutRatio: localizePercentage(
        value: dividendPayoutRatio,
      ),
    );
  }

  String? determineDividendPayoutLevel(double? dividendPayoutRatio) {
    if (dividendPayoutRatio == null) return null;

    if (dividendPayoutRatio > 0 && dividendPayoutRatio <= 0.1) {
      return FinanceDividendLocaleKeys.dividend_label_low_dividend.tr();
    } else if (dividendPayoutRatio > 0.1 && dividendPayoutRatio <= 0.6) {
      return FinanceDividendLocaleKeys.dividend_label_normal_dividend.tr();
    } else if (dividendPayoutRatio > 0.6 && dividendPayoutRatio <= 0.9) {
      return FinanceDividendLocaleKeys.dividend_label_high_dividend.tr();
    }

    return FinanceDividendLocaleKeys.dividend_label_unsustainable_high_dividend
        .tr();
  }

  @override
  Future<MatexDividendPayoutRatioCalculatorDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      if (key == MatexDividendPayoutRatioCalculatorBlocKey.totalDividends) {
        return document.copyWith(totalDividends: value);
      } else if (key == MatexDividendPayoutRatioCalculatorBlocKey.netIncome) {
        return document.copyWith(netIncome: value);
      }
    }

    return null;
  }

  @override
  Future<MatexDividendPayoutRatioCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      if (key == MatexDividendPayoutRatioCalculatorBlocKey.totalDividends) {
        return patchTotalDividends(value);
      } else if (key == MatexDividendPayoutRatioCalculatorBlocKey.netIncome) {
        return patchNetIncome(value);
      }
    }

    return currentState;
  }

  @override
  Future<void> resetCalculator(
    MatexDividendPayoutRatioCalculatorDocument document,
  ) async {
    calculator.setState(MatexDividendPayoutRatioCalculatorState(
      totalDividends: parseStringToDouble(document.totalDividends),
      netIncome: parseStringToDouble(document.netIncome),
    ));
  }

  @override
  Future<MatexDividendPayoutRatioCalculatorBlocState> resetCalculatorBlocState(
    MatexDividendPayoutRatioCalculatorDocument document,
  ) async {
    return _kDefaultDividendPayoutRatioBlocState.copyWith(
      results: await retrieveDefaultResult(),
      fields: MatexDividendPayoutRatioCalculatorBlocFields(
        totalDividends: document.totalDividends,
        netIncome: document.netIncome,
      ),
    );
  }

  @override
  Future<MatexDividendPayoutRatioCalculatorDocument>
      retrieveDefaultCalculatorDocument() async {
    return MatexDividendPayoutRatioCalculatorDocument();
  }

  @override
  Future<MatexDividendPayoutRatioCalculatorBlocResults>
      retrieveDefaultResult() async {
    return _kDefaultDividendPayoutRatioBlocResults;
  }

  MatexDividendPayoutRatioCalculatorBlocState patchTotalDividends(
      String? value) {
    late MatexDividendPayoutRatioCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetTotalDividends: true,
      );

      calculator.totalDividends = 0;
    } else {
      final dValue = toDecimal(value) ?? dZero;
      fields = currentState.fields.copyWith(totalDividends: value);
      calculator.totalDividends = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexDividendPayoutRatioCalculatorBlocState patchNetIncome(String? value) {
    late MatexDividendPayoutRatioCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetNetIncome: true,
      );

      calculator.netIncome = 0;
    } else {
      final dValue = toDecimal(value) ?? dZero;
      fields = currentState.fields.copyWith(netIncome: value);
      calculator.netIncome = dValue.toDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  @override
  String getReportFilename() => 'dividend_payout_ratio_report';

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexDividendPayoutRatioCalculatorPdfGenerator();
    final fields = currentState.fields;
    final results = await compute();

    // ignore: use_build_context_synchronously
    return pdfGenerator.generate(context, fields, results);
  }
}