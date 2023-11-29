// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

final _kDefaultProfitAndLossBlocState = MatexProfitAndLossCalculatorBlocState(
  fields: MatexProfitAndLossCalculatorBlocFields(),
  results: const MatexProfitAndLossCalculatorBlocResults(),
);

class MatexProfitAndLossCalculatorBloc extends MatexCalculatorBloc<
    MatexProfitAndLossCalculator,
    FastCalculatorBlocEvent,
    MatexProfitAndLossCalculatorBlocState,
    MatexProfitAndLossCalculatorDocument,
    MatexProfitAndLossCalculatorBlocResults> {
  MatexProfitAndLossCalculatorBloc({
    MatexProfitAndLossCalculatorBlocState? initialState,
    MatexProfitAndLossCalculatorDataProvider? dataProvider,
    super.debouceComputeEvents = true,
    super.showExportPdfDialog,
    super.delegate,
  }) : super(
          initialState: initialState ?? _kDefaultProfitAndLossBlocState,
          dataProvider:
              dataProvider ?? MatexProfitAndLossCalculatorDataProvider(),
          debugLabel: 'MatexProfitAndLossCalculatorBloc',
        ) {
    calculator = MatexProfitAndLossCalculator();

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorTaxRate.name,
      MatexProfitAndLossCalculatorBlocKey.taxRate,
    );
  }

  @override
  Future<MatexProfitAndLossCalculatorBlocResults> compute() async {
    if (await isCalculatorStateValid()) {
      final results = calculator.value();

      return MatexProfitAndLossCalculatorBlocResults(
        formattedBreakEvenUnits: localizeNumber(value: results.breakEvenUnits),
        formattedGrossProfit: localizeCurrency(value: results.grossProfit),
        formattedNetProfit: localizeCurrency(value: results.netProfit),
        formattedTaxAmount: localizeCurrency(value: results.taxAmount),
        formattedRevenue: localizeCurrency(value: results.revenue),
        formattedReturnOnInvestment: localizePercentage(
          value: results.returnOnInvestment,
        ),
        formattedSellingExpenses: localizeCurrency(
          value: results.sellingExpenses,
        ),
        formattedOperatingProfit: localizeCurrency(
          value: results.operatingProfit,
        ),
        formattedCostOfGoodsSold: localizeCurrency(
          value: results.costOfGoodsSold,
        ),
        formattedCostOfInvestment: localizeCurrency(
          value: results.costOfInvestment,
        ),
        formattedGrossProfitMargin: localizePercentage(
          value: results.grossProfitMargin,
        ),
        formattedNetProfitMargin: localizePercentage(
          value: results.netProfitMargin,
        ),
        returnOnInvestment: results.returnOnInvestment,
        grossProfitMargin: results.grossProfitMargin,
        costOfInvestment: results.costOfInvestment,
        netProfitMargin: results.netProfitMargin,
        costOfGoodsSold: results.costOfGoodsSold,
        operatingProfit: results.operatingProfit,
        sellingExpenses: results.sellingExpenses,
        breakEvenUnits: results.breakEvenUnits,
        grossProfit: results.grossProfit,
        taxAmount: results.taxAmount,
        netProfit: results.netProfit,
        revenue: results.revenue,
      );
    }

    return retrieveDefaultResult();
  }

  @override
  Future<MatexProfitAndLossCalculatorDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      if (key == MatexProfitAndLossCalculatorBlocKey.expectedSaleUnits) {
        return document.copyWith(expectedSaleUnits: value);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.buyingPrice) {
        return document.copyWith(buyingPrice: value);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.sellingPrice) {
        return document.copyWith(sellingPrice: value);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.operatingExpenses) {
        return document.copyWith(operatingExpenses: value);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.buyingExpensePerUnitRate) {
        return document.copyWith(buyingExpensePerUnitRate: value);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.buyingExpensePerUnitAmount) {
        return document.copyWith(buyingExpensePerUnitAmount: value);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.sellingExpensePerUnitRate) {
        return document.copyWith(sellingExpensePerUnitRate: value);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.sellingExpensePerUnitAmount) {
        return document.copyWith(sellingExpensePerUnitAmount: value);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.taxRate) {
        return document.copyWith(taxRate: value);
      }
    } else if (value is Enum) {
      if (key == MatexProfitAndLossCalculatorBlocKey.buyingCostsPerUnitType) {
        return document.copyWith(
          buyingCostsPerUnitType: value.name,
          buyingExpensePerUnitAmount: '',
          buyingExpensePerUnitRate: '',
        );
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.sellingCostsPerUnitType) {
        return document.copyWith(
          sellingCostsPerUnitType: value.name,
          sellingExpensePerUnitAmount: '',
          sellingExpensePerUnitRate: '',
        );
      }
    }

    return null;
  }

  @override
  Future<MatexProfitAndLossCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      if (key == MatexProfitAndLossCalculatorBlocKey.expectedSaleUnits) {
        return patchExpectedSaleUnits(value);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.buyingPrice) {
        return patchBuyingPrice(value);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.sellingPrice) {
        return patchSellingPrice(value);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.operatingExpenses) {
        return patchOperatingExpenses(value);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.buyingExpensePerUnitAmount) {
        return patchBuyingExpensePerUnitAmount(value);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.buyingExpensePerUnitRate) {
        return patchBuyingExpensePerUnitRate(value);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.sellingExpensePerUnitAmount) {
        return patchSellingExpensePerUnitAmount(value);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.sellingExpensePerUnitRate) {
        return patchSellingExpensePerUnitRate(value);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.taxRate) {
        return patchTaxRate(value);
      }
    } else if (value is Enum) {
      if (key == MatexProfitAndLossCalculatorBlocKey.buyingCostsPerUnitType) {
        return patchBuyingCostsPerUnitType(value.name);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.sellingCostsPerUnitType) {
        return patchSellingCostsPerUnitType(value.name);
      }
    }

    return currentState;
  }

  @override
  Future<MatexProfitAndLossCalculatorDocument?> resetCalculatorDocument(
    String key,
  ) async {
    switch (key) {
      case MatexProfitAndLossCalculatorBlocKey.operatingExpenses:
        return document.copyWithDefaults(operatingExpenses: true);

      case MatexProfitAndLossCalculatorBlocKey.expectedSaleUnits:
        return document.copyWithDefaults(expectedSaleUnits: true);
    }

    return null;
  }

  @override
  Future<MatexProfitAndLossCalculatorBlocState?> resetCalculatorState(
    String key,
  ) async {
    switch (key) {
      case MatexProfitAndLossCalculatorBlocKey.operatingExpenses:
        return patchOperatingExpenses(null);

      case MatexProfitAndLossCalculatorBlocKey.expectedSaleUnits:
        return patchExpectedSaleUnits(null);
    }

    return null;
  }

  @override
  Future<void> resetCalculator(
    MatexProfitAndLossCalculatorDocument document,
  ) async {
    final taxRate = toDecimal(document.taxRate) ?? dZero;
    final sellingExpensePerUnitRate = toDecimal(
          document.sellingExpensePerUnitRate,
        ) ??
        dZero;
    final buyingExpensePerUnitRate = toDecimal(
          document.buyingExpensePerUnitRate,
        ) ??
        dZero;

    calculator.setState(MatexProfitAndLossCalculatorState(
      expectedSaleUnits: parseStringToDouble(document.expectedSaleUnits),
      operatingExpenses: parseStringToDouble(document.operatingExpenses),
      sellingPrice: parseStringToDouble(document.sellingPrice),
      buyingPrice: parseStringToDouble(document.buyingPrice),
      taxRate: (taxRate / dHundred).toDouble(),
      buyingExpensePerUnitAmount: parseStringToDouble(
        document.buyingExpensePerUnitAmount,
      ),
      sellingExpensePerUnitAmount: parseStringToDouble(
        document.sellingExpensePerUnitAmount,
      ),
      buyingExpensePerUnitRate:
          (buyingExpensePerUnitRate / dHundred).toDouble(),
      sellingExpensePerUnitRate:
          (sellingExpensePerUnitRate / dHundred).toDouble(),
    ));
  }

  @override
  Future<MatexProfitAndLossCalculatorBlocState> resetCalculatorBlocState(
    MatexProfitAndLossCalculatorDocument document,
  ) async {
    return _kDefaultProfitAndLossBlocState.copyWith(
      results: await retrieveDefaultResult(),
      fields: MatexProfitAndLossCalculatorBlocFields(
        taxRate: document.taxRate,
      ),
    );
  }

  @override
  Future<MatexProfitAndLossCalculatorDocument>
      retrieveDefaultCalculatorDocument() async {
    final bloc = FastAppDictBloc.instance;

    return MatexProfitAndLossCalculatorDocument(
      taxRate: bloc.getValue<String?>(
        MatexCalculatorDefaultValueKeys.matexCalculatorTaxRate.name,
      ),
    );
  }

  @override
  Future<MatexProfitAndLossCalculatorBlocResults>
      retrieveDefaultResult() async {
    return MatexProfitAndLossCalculatorBlocResults(
      formattedReturnOnInvestment: localizePercentage(value: 0),
      formattedNetProfit: localizeCurrency(value: 0),
      returnOnInvestment: 0,
      netProfit: 0,
    );
  }

  MatexProfitAndLossCalculatorBlocState patchExpectedSaleUnits(String? value) {
    if (value == null) {
      final fields = currentState.fields.copyWithDefaults(
        expectedSaleUnits: true,
      );
      calculator.expectedSaleUnits = 0;

      return currentState.copyWith(fields: fields);
    }

    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(expectedSaleUnits: value);
    calculator.expectedSaleUnits = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchBuyingPrice(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(buyingPrice: value);
    calculator.buyingPrice = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchSellingPrice(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(sellingPrice: value);
    calculator.sellingPrice = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchBuyingExpensePerUnitAmount(
    String value,
  ) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(
      buyingExpensePerUnitAmount: value,
    );
    calculator.buyingExpensePerUnitAmount = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchBuyingExpensePerUnitRate(
    String value,
  ) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(
      buyingExpensePerUnitRate: value,
    );
    calculator.buyingExpensePerUnitRate = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchSellingExpensePerUnitAmount(
    String value,
  ) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(
      sellingExpensePerUnitAmount: value,
    );
    calculator.sellingExpensePerUnitAmount = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchSellingExpensePerUnitRate(
    String value,
  ) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(
      sellingExpensePerUnitRate: value,
    );
    calculator.sellingExpensePerUnitRate = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchOperatingExpenses(String? value) {
    if (value == null) {
      final fields = currentState.fields.copyWithDefaults(
        operatingExpenses: true,
      );
      calculator.operatingExpenses = 0;

      return currentState.copyWith(fields: fields);
    }

    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(operatingExpenses: value);
    calculator.operatingExpenses = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchTaxRate(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(taxRate: value);
    calculator.taxRate = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchBuyingCostsPerUnitType(
    String value,
  ) {
    final fields = currentState.fields.copyWith(
      buyingCostsPerUnitType: value,
      buyingExpensePerUnitAmount: '',
      buyingExpensePerUnitRate: '',
    );

    calculator
      ..buyingExpensePerUnitAmount = 0
      ..buyingExpensePerUnitRate = 0;

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchSellingCostsPerUnitType(
    String value,
  ) {
    final fields = currentState.fields.copyWith(
      sellingCostsPerUnitType: value,
      sellingExpensePerUnitAmount: '',
      sellingExpensePerUnitRate: '',
    );

    calculator
      ..sellingExpensePerUnitAmount = 0
      ..sellingExpensePerUnitRate = 0;

    return currentState.copyWith(fields: fields);
  }

  @override
  String getReportFilename() => 'profit_and_loss_report';

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexProfitAndLossCalculatorPdfGenerator();
    final fields = currentState.fields;
    final results = await compute();

    // ignore: use_build_context_synchronously
    return pdfGenerator.generate(context, fields, results);
  }
}
