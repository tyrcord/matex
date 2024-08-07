// Dart imports:
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

const _kDefaultDividendYieldBlocResults =
    MatexDividendYieldCalculatorBlocResults(
  formattedDividendYield: '0%',
  dividendYield: 0,
);

final _kDefaultDividendYieldBlocState = MatexDividendYieldCalculatorBlocState(
  fields: MatexDividendYieldCalculatorBlocFields(),
  results: _kDefaultDividendYieldBlocResults,
);

class MatexDividendYieldCalculatorBloc extends MatexCalculatorBloc<
    MatexDividendYieldCalculator,
    FastCalculatorBlocEvent,
    MatexDividendYieldCalculatorBlocState,
    MatexDividendYieldCalculatorDocument,
    MatexDividendYieldCalculatorBlocResults> {
  MatexDividendYieldCalculatorBloc({
    MatexDividendYieldCalculatorBlocState? initialState,
    MatexDividendYieldCalculatorDataProvider? dataProvider,
    super.exportAlternativeAction,
    super.debouceComputeEvents = true,
    super.getExportDialog,
    super.delegate,
    super.getContext,
  }) : super(
          initialState: initialState ?? _kDefaultDividendYieldBlocState,
          dataProvider:
              dataProvider ?? MatexDividendYieldCalculatorDataProvider(),
          debugLabel: 'MatexDividendYieldCalculatorBloc',
        ) {
    calculator = MatexDividendYieldCalculator();

    // Note: no need to listen to user account currency changes
    // because the calculator is not requiring full screen.
  }

  @override
  Future<MatexDividendYieldCalculatorBlocResults> compute() async {
    final results = calculator.value();

    return MatexDividendYieldCalculatorBlocResults(
      dividendYield: results.dividendYield,
      formattedDividendYield: localizePercentage(
        value: results.dividendYield,
      ),
      totalDividends: results.totalDividends,
      formattedTotalDividends: localizeCurrency(
        value: results.totalDividends,
      ),
      sharePrice: results.sharePrice,
      formattedSharePrice: localizeCurrency(
        value: results.sharePrice,
      ),
    );
  }

  @override
  Future<MatexDividendYieldCalculatorDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value == null) {
      if (key == MatexDividendYieldCalculatorBlocKey.sharePrice) {
        return document.copyWithDefaults(resetSharePrice: true);
      } else if (key == MatexDividendYieldCalculatorBlocKey.dividendAmount) {
        return document.copyWithDefaults(resetDividendAmount: true);
      } else if (key == MatexDividendYieldCalculatorBlocKey.paymentFrequency) {
        return document.copyWithDefaults(resetPaymentFrequency: true);
      }
    } else if (value is String) {
      if (key == MatexDividendYieldCalculatorBlocKey.sharePrice) {
        return document.copyWith(sharePrice: value);
      } else if (key == MatexDividendYieldCalculatorBlocKey.dividendAmount) {
        return document.copyWith(dividendAmount: value);
      } else if (key == MatexDividendYieldCalculatorBlocKey.paymentFrequency) {
        return document.copyWith(paymentFrequency: value);
      }
    } else if (value is MatexFinancialFrequency) {
      if (key == MatexDividendYieldCalculatorBlocKey.paymentFrequency) {
        return document.copyWith(paymentFrequency: value.name);
      }
    }

    return null;
  }

  @override
  Future<MatexDividendYieldCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is String?) {
      if (key == MatexDividendYieldCalculatorBlocKey.sharePrice) {
        return patchSharePrice(value);
      } else if (key == MatexDividendYieldCalculatorBlocKey.dividendAmount) {
        return patchDividendAmount(value);
      } else if (key == MatexDividendYieldCalculatorBlocKey.paymentFrequency) {
        return patchPaymentFrequency(MatexFinancialFrequencyX.fromName(value));
      }
    } else if (value is MatexFinancialFrequency) {
      if (key == MatexDividendYieldCalculatorBlocKey.paymentFrequency) {
        return patchPaymentFrequency(value);
      }
    }

    return currentState;
  }

  @override
  Future<void> resetCalculator(
    MatexDividendYieldCalculatorDocument document,
  ) async {
    final paymentFrequency = document.paymentFrequency;

    calculator.setState(MatexDividendYieldCalculatorState(
      paymentFrequency: MatexFinancialFrequencyX.fromName(paymentFrequency),
      dividendAmount: tryParseStringToDouble(document.dividendAmount),
      sharePrice: tryParseStringToDouble(document.sharePrice),
    ));
  }

  @override
  Future<MatexDividendYieldCalculatorBlocState> resetCalculatorBlocState(
    MatexDividendYieldCalculatorDocument document,
  ) async {
    final paymentFrequency = document.paymentFrequency;

    return _kDefaultDividendYieldBlocState.copyWith(
      results: await retrieveDefaultResult(),
      fields: MatexDividendYieldCalculatorBlocFields(
        paymentFrequency: MatexFinancialFrequencyX.fromName(paymentFrequency),
        dividendAmount: document.dividendAmount,
        sharePrice: document.sharePrice,
      ),
    );
  }

  @override
  Future<MatexDividendYieldCalculatorDocument>
      retrieveDefaultCalculatorDocument() async {
    return MatexDividendYieldCalculatorDocument();
  }

  @override
  Future<MatexDividendYieldCalculatorBlocResults>
      retrieveDefaultResult() async {
    return _kDefaultDividendYieldBlocResults;
  }

  MatexDividendYieldCalculatorBlocState patchSharePrice(String? value) {
    late MatexDividendYieldCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetSharePrice: true,
      );

      calculator.sharePrice = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(sharePrice: value);
      calculator.sharePrice = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexDividendYieldCalculatorBlocState patchDividendAmount(String? value) {
    late MatexDividendYieldCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetDividendAmount: true,
      );

      calculator.dividendAmount = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(dividendAmount: value);
      calculator.dividendAmount = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexDividendYieldCalculatorBlocState patchPaymentFrequency(
    MatexFinancialFrequency? frequency,
  ) {
    late MatexDividendYieldCalculatorBlocFields fields;

    if (frequency == null) {
      fields = currentState.fields.copyWithDefaults(
        resetPaymentFrequency: true,
      );

      calculator.paymentFrequency =
          MatexDividendYieldCalculatorBlocFields.defaultFrequency;
    } else {
      fields = currentState.fields.copyWith(paymentFrequency: frequency);
      calculator.paymentFrequency = frequency;
    }

    return currentState.copyWith(fields: fields);
  }

  @override
  String getReportFilename() => 'dividend_yield_report';

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexDividendYieldCalculatorPdfGenerator();
    final fields = currentState.fields;
    final results = await compute();

    // ignore: use_build_context_synchronously
    return pdfGenerator.generate(context, fields, results);
  }
}
