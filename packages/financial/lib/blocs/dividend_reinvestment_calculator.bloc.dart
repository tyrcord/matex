// Dart imports:
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

final _kDefaultDividendPayoutRatioBlocState =
    MatexDividendReinvestmentCalculatorBlocState(
  results: const MatexDividendReinvestmentCalculatorBlocResults(),
  fields: MatexDividendReinvestmentCalculatorBlocFields(),
);

class MatexDividendReinvestmentCalculatorBloc extends MatexCalculatorBloc<
    MatexDividendReinvestmentCalculator,
    FastCalculatorBlocEvent,
    MatexDividendReinvestmentCalculatorBlocState,
    MatexDividendReinvestmentCalculatorDocument,
    MatexDividendReinvestmentCalculatorBlocResults> {
  MatexDividendReinvestmentCalculatorBloc({
    MatexDividendReinvestmentCalculatorBlocState? initialState,
    MatexDividendReinvestmentCalculatorDataProvider? dataProvider,
    super.exportAlternativeAction,
    super.debouceComputeEvents = true,
    super.getExportDialog,
    super.delegate,
    super.getContext,
  }) : super(
          initialState: initialState ?? _kDefaultDividendPayoutRatioBlocState,
          dataProvider:
              dataProvider ?? MatexDividendReinvestmentCalculatorDataProvider(),
          debugLabel: 'MatexDividendReinvestmentCalculatorBloc',
        ) {
    calculator = MatexDividendReinvestmentCalculator();

    // Note: no need to listen to user account currency changes
    // because the calculator is not requiring full screen.
  }

  @override
  Future<MatexDividendReinvestmentCalculatorBlocResults> compute() async {
    final results = calculator.value();
    final endingBalance = results.endingBalance;

    return MatexDividendReinvestmentCalculatorBlocResults(
      grossDividendPaid: results.grossDividendPaid,
      formattedGrossDividendPaid: localizeCurrency(
        value: results.grossDividendPaid,
      ),
      endingBalance: endingBalance,
      formattedEndingBalance: localizeCurrency(
        value: endingBalance,
      ),
      totalReturn: results.totalReturn,
      formattedTotalReturn: localizePercentage(
        value: results.totalReturn,
      ),
      netDividendPaid: results.netDividendPaid,
      formattedNetDividendPaid: localizeCurrency(
        value: results.netDividendPaid,
      ),
      netDividendIncome: results.netDividendIncome,
      formattedNetDividendIncome: localizeCurrency(
        value: results.netDividendIncome,
      ),
      sharesOwned: results.numberOfShares,
      formattedSharesOwned: localizeNumber(
        value: results.numberOfShares,
      ),
      sharePrice: results.sharePrice,
      formattedSharePrice: localizeCurrency(
        value: results.sharePrice,
      ),
      totalAdditionalContribution: results.totalContribution,
      formattedTotalAdditionalContribution: localizeCurrency(
        value: results.totalContribution,
      ),
      totalTaxAmount: results.totalTaxAmount,
      formattedTotalTaxAmount: localizeCurrency(
        value: results.totalTaxAmount,
      ),
      startingBalance: results.startingBalance,
      formattedStartingBalance: localizeCurrency(
        value: results.startingBalance,
      ),
    );
  }

  @override
  Future<MatexDividendReinvestmentCalculatorDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value == null) {
      switch (key) {
        case MatexDividendReinvestmentCalculatorBlocKey.sharePrice:
          return document.copyWithDefaults(resetSharePrice: true);
        case MatexDividendReinvestmentCalculatorBlocKey.numberOfShares:
          return document.copyWithDefaults(resetNumberOfShares: true);
        case MatexDividendReinvestmentCalculatorBlocKey.paymentFrequency:
          return document.copyWithDefaults(resetPaymentFrequency: true);
        case MatexDividendReinvestmentCalculatorBlocKey.dividendYield:
          return document.copyWithDefaults(resetDividendYield: true);
        case MatexDividendReinvestmentCalculatorBlocKey.yearsToGrow:
          return document.copyWithDefaults(resetYearsToGrow: true);
        case MatexDividendReinvestmentCalculatorBlocKey.annualContribution:
          return document.copyWithDefaults(resetAnnualContribution: true);
        case MatexDividendReinvestmentCalculatorBlocKey
              .annualSharePriceIncrease:
          return document.copyWithDefaults(
            resetAnnualSharePriceIncrease: true,
          );
        case MatexDividendReinvestmentCalculatorBlocKey.annualDividendIncrease:
          return document.copyWithDefaults(resetAnnualDividendIncrease: true);
        case MatexDividendReinvestmentCalculatorBlocKey.taxRate:
          return document.copyWithDefaults(resetTaxRate: true);
      }
    } else if (value is String) {
      switch (key) {
        case MatexDividendReinvestmentCalculatorBlocKey.sharePrice:
          return document.copyWith(sharePrice: value);
        case MatexDividendReinvestmentCalculatorBlocKey.numberOfShares:
          return document.copyWith(numberOfShares: value);
        case MatexDividendReinvestmentCalculatorBlocKey.paymentFrequency:
          return document.copyWith(paymentFrequency: value);
        case MatexDividendReinvestmentCalculatorBlocKey.dividendYield:
          return document.copyWith(dividendYield: value);
        case MatexDividendReinvestmentCalculatorBlocKey.yearsToGrow:
          return document.copyWith(yearsToGrow: value);
        case MatexDividendReinvestmentCalculatorBlocKey.annualContribution:
          return document.copyWith(annualContribution: value);
        case MatexDividendReinvestmentCalculatorBlocKey
              .annualSharePriceIncrease:
          return document.copyWith(annualSharePriceIncrease: value);
        case MatexDividendReinvestmentCalculatorBlocKey.annualDividendIncrease:
          return document.copyWith(annualDividendIncrease: value);
        case MatexDividendReinvestmentCalculatorBlocKey.taxRate:
          return document.copyWith(taxRate: value);
      }
    } else if (value is MatexFinancialFrequency) {
      if (key == MatexDividendReinvestmentCalculatorBlocKey.paymentFrequency) {
        return document.copyWith(paymentFrequency: value.name);
      }
    } else if (value is bool) {
      if (key == MatexDividendReinvestmentCalculatorBlocKey.drip) {
        return document.copyWith(drip: value);
      }
    }

    return null;
  }

  @override
  Future<MatexDividendReinvestmentCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is String?) {
      switch (key) {
        case MatexDividendReinvestmentCalculatorBlocKey.sharePrice:
          return patchSharePrice(value);
        case MatexDividendReinvestmentCalculatorBlocKey.numberOfShares:
          return patchNumberOfShares(value);
        case MatexDividendReinvestmentCalculatorBlocKey.paymentFrequency:
          return patchPaymentFrequency(value);
        case MatexDividendReinvestmentCalculatorBlocKey.dividendYield:
          return patchDividendYield(value);
        case MatexDividendReinvestmentCalculatorBlocKey.yearsToGrow:
          return patchYearsToGrow(value);
        case MatexDividendReinvestmentCalculatorBlocKey.annualContribution:
          return patchAnnualContribution(value);
        case MatexDividendReinvestmentCalculatorBlocKey
              .annualSharePriceIncrease:
          return patchAnnualSharePriceIncrease(value);
        case MatexDividendReinvestmentCalculatorBlocKey.annualDividendIncrease:
          return patchAnnualDividendIncrease(value);
        case MatexDividendReinvestmentCalculatorBlocKey.taxRate:
          return patchTaxRate(value);
      }
    } else if (value is MatexFinancialFrequency) {
      if (key == MatexDividendReinvestmentCalculatorBlocKey.paymentFrequency) {
        return patchPaymentFrequency(value);
      }
    } else if (value is bool) {
      if (key == MatexDividendReinvestmentCalculatorBlocKey.drip) {
        return patchDrip(value);
      }
    }

    return currentState;
  }

  @override
  Future<void> resetCalculator(
    MatexDividendReinvestmentCalculatorDocument document,
  ) async {
    final dDividendYield = parseStringToDouble(document.dividendYield);
    final dTaxRate = parseStringToDouble(document.taxRate);
    final dAnnualDividendIncrease =
        parseStringToDouble(document.annualDividendIncrease);
    final dAnnualSharePriceIncrease =
        parseStringToDouble(document.annualSharePriceIncrease);

    final frequency = MatexFinancialFrequencyX.fromName(
      document.paymentFrequency,
    );

    calculator.setState(MatexDividendReinvestmentCalculatorState(
      sharePrice: tryParseStringToDouble(document.sharePrice),
      numberOfShares: tryParseStringToDouble(document.numberOfShares),
      dividendPaymentFrequency: frequency,
      dividendYield: (dDividendYield / 100),
      yearsToGrow: tryParseStringToInt(document.yearsToGrow),
      annualContribution: tryParseStringToDouble(document.annualContribution),
      annualSharePriceIncrease: (dAnnualSharePriceIncrease / 100),
      annualDividendIncrease: (dAnnualDividendIncrease / 100),
      taxRate: (dTaxRate / 100),
      drip: document.drip,
    ));
  }

  @override
  Future<MatexDividendReinvestmentCalculatorBlocState> resetCalculatorBlocState(
    MatexDividendReinvestmentCalculatorDocument document,
  ) async {
    final frequency = MatexFinancialFrequencyX.fromName(
      document.paymentFrequency,
    );

    return _kDefaultDividendPayoutRatioBlocState.copyWith(
      results: await retrieveDefaultResult(),
      fields: MatexDividendReinvestmentCalculatorBlocFields(
        sharePrice: document.sharePrice,
        numberOfShares: document.numberOfShares,
        paymentFrequency: frequency,
        dividendYield: document.dividendYield,
        yearsToGrow: document.yearsToGrow,
        annualContribution: document.annualContribution,
        annualSharePriceIncrease: document.annualSharePriceIncrease,
        annualDividendIncrease: document.annualDividendIncrease,
        taxRate: document.taxRate,
        drip: document.drip,
      ),
    );
  }

  @override
  Future<MatexDividendReinvestmentCalculatorDocument>
      retrieveDefaultCalculatorDocument() async {
    return MatexDividendReinvestmentCalculatorDocument();
  }

  @override
  Future<MatexDividendReinvestmentCalculatorBlocResults>
      retrieveDefaultResult() async {
    return MatexDividendReinvestmentCalculatorBlocResults(
      formattedEndingBalance: localizeCurrency(value: 0),
      endingBalance: 0,
    );
  }

  MatexDividendReinvestmentCalculatorBlocState patchSharePrice(String? value) {
    late MatexDividendReinvestmentCalculatorBlocFields fields;

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

  MatexDividendReinvestmentCalculatorBlocState patchNumberOfShares(
    String? value,
  ) {
    late MatexDividendReinvestmentCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetNumberOfShares: true,
      );

      calculator.numberOfShares = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(numberOfShares: value);
      calculator.numberOfShares = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexDividendReinvestmentCalculatorBlocState patchPaymentFrequency(
    dynamic value,
  ) {
    late MatexDividendReinvestmentCalculatorBlocFields fields;

    if (value is String) {
      final frequency = MatexFinancialFrequencyX.fromName(value);
      fields = currentState.fields.copyWith(paymentFrequency: frequency);
      calculator.dividendPaymentFrequency = frequency!;
    } else if (value is MatexFinancialFrequency) {
      fields = currentState.fields.copyWith(paymentFrequency: value);
      calculator.dividendPaymentFrequency = value;
    } else {
      fields = currentState.fields.copyWithDefaults(
        resetPaymentFrequency: true,
      );

      calculator.dividendPaymentFrequency =
          MatexDividendReinvestmentCalculatorBlocFields.defaultFrequency;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexDividendReinvestmentCalculatorBlocState patchDividendYield(
    String? value,
  ) {
    late MatexDividendReinvestmentCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetDividendYield: true,
      );

      calculator.dividendYield = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(dividendYield: value);
      calculator.dividendYield = (dValue / 100);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexDividendReinvestmentCalculatorBlocState patchYearsToGrow(
    String? value,
  ) {
    late MatexDividendReinvestmentCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetYearsToGrow: true,
      );

      calculator.yearsToGrow = 0;
    } else {
      final dValue = parseStringToInt(value);
      fields = currentState.fields.copyWith(yearsToGrow: value);
      calculator.yearsToGrow = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexDividendReinvestmentCalculatorBlocState patchAnnualContribution(
    String? value,
  ) {
    late MatexDividendReinvestmentCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetAnnualContribution: true,
      );

      calculator.annualContribution = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(annualContribution: value);
      calculator.annualContribution = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexDividendReinvestmentCalculatorBlocState patchAnnualSharePriceIncrease(
    String? value,
  ) {
    late MatexDividendReinvestmentCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetAnnualSharePriceIncrease: true,
      );

      calculator.annualSharePriceIncrease = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(annualSharePriceIncrease: value);
      calculator.annualSharePriceIncrease = (dValue / 100);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexDividendReinvestmentCalculatorBlocState patchAnnualDividendIncrease(
    String? value,
  ) {
    late MatexDividendReinvestmentCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetAnnualDividendIncrease: true,
      );

      calculator.annualDividendIncrease = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(annualDividendIncrease: value);
      calculator.annualDividendIncrease = (dValue / 100);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexDividendReinvestmentCalculatorBlocState patchTaxRate(
    String? value,
  ) {
    late MatexDividendReinvestmentCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetTaxRate: true);

      calculator.taxRate = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(taxRate: value);
      calculator.taxRate = (dValue / 100);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexDividendReinvestmentCalculatorBlocState patchDrip(bool? value) {
    late MatexDividendReinvestmentCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetDrip: true);
      calculator.drip = true;
    } else {
      fields = currentState.fields.copyWith(drip: value);
      calculator.drip = value;
    }

    return currentState.copyWith(fields: fields);
  }

  @override
  String getReportFilename() => 'dividend_reinvestment_calculator_report';

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexDividendReinvestmentCalculatorPdfGenerator();
    final fields = currentState.fields;
    final results = await compute();

    // ignore: use_build_context_synchronously
    return pdfGenerator.generate(context, fields, results);
  }
}
