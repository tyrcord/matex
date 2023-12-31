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
import 'package:tenhance/decimal.dart';

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
    if (value == null) {
      if (key == MatexProfitAndLossCalculatorBlocKey.expectedSaleUnits) {
        return document.copyWithDefaults(resetExpectedSaleUnits: true);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.buyingPrice) {
        return document.copyWithDefaults(resetBuyingPrice: true);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.sellingPrice) {
        return document.copyWithDefaults(resetSellingPrice: true);
      } else if (key == MatexProfitAndLossCalculatorBlocKey.operatingExpenses) {
        return document.copyWithDefaults(resetOperatingExpenses: true);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.buyingExpensePerUnitRate) {
        return document.copyWithDefaults(resetBuyingExpensePerUnitRate: true);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.buyingExpensePerUnitAmount) {
        return document.copyWithDefaults(resetBuyingExpensePerUnitAmount: true);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.sellingExpensePerUnitRate) {
        return document.copyWithDefaults(resetSellingExpensePerUnitRate: true);
      } else if (key ==
          MatexProfitAndLossCalculatorBlocKey.sellingExpensePerUnitAmount) {
        return document.copyWithDefaults(
          resetSellingExpensePerUnitAmount: true,
        );
      } else if (key == MatexProfitAndLossCalculatorBlocKey.taxRate) {
        return document.copyWithDefaults(resetTaxRate: true);
      }
    } else if (value is String) {
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
    if (value is String?) {
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
  Future<void> resetCalculator(
    MatexProfitAndLossCalculatorDocument document,
  ) async {
    final taxRate = toDecimalOrDefault(document.taxRate);
    final sellingExpensePerUnitRate = toDecimalOrDefault(
      document.sellingExpensePerUnitRate,
    );
    final buyingExpensePerUnitRate = toDecimalOrDefault(
      document.buyingExpensePerUnitRate,
    );

    calculator.setState(MatexProfitAndLossCalculatorState(
      expectedSaleUnits: parseStringToDouble(document.expectedSaleUnits),
      operatingExpenses: parseStringToDouble(document.operatingExpenses),
      sellingPrice: parseStringToDouble(document.sellingPrice),
      buyingPrice: parseStringToDouble(document.buyingPrice),
      taxRate: (taxRate / dHundred).toSafeDouble(),
      buyingExpensePerUnitAmount: parseStringToDouble(
        document.buyingExpensePerUnitAmount,
      ),
      sellingExpensePerUnitAmount: parseStringToDouble(
        document.sellingExpensePerUnitAmount,
      ),
      buyingExpensePerUnitRate:
          (buyingExpensePerUnitRate / dHundred).toSafeDouble(),
      sellingExpensePerUnitRate:
          (sellingExpensePerUnitRate / dHundred).toSafeDouble(),
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
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetExpectedSaleUnits: true);
      calculator.expectedSaleUnits = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = fields.copyWith(expectedSaleUnits: value);
      calculator.expectedSaleUnits = dValue.toSafeDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchBuyingPrice(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetBuyingPrice: true);
      calculator.buyingPrice = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = fields.copyWith(buyingPrice: value);
      calculator.buyingPrice = dValue.toSafeDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchSellingPrice(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetSellingPrice: true);
      calculator.sellingPrice = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = fields.copyWith(sellingPrice: value);
      calculator.sellingPrice = dValue.toSafeDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchBuyingExpensePerUnitAmount(
    String? value,
  ) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetBuyingExpensePerUnitAmount: true);
      calculator.buyingExpensePerUnitAmount = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = fields = fields.copyWith(buyingExpensePerUnitAmount: value);
      calculator.buyingExpensePerUnitAmount = dValue.toSafeDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchBuyingExpensePerUnitRate(
    String? value,
  ) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetBuyingExpensePerUnitRate: true);
      calculator.buyingExpensePerUnitRate = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = fields = fields.copyWith(buyingExpensePerUnitRate: value);
      calculator.buyingExpensePerUnitRate = (dValue / dHundred).toSafeDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchSellingExpensePerUnitAmount(
    String? value,
  ) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetSellingExpensePerUnitAmount: true);
      calculator.sellingExpensePerUnitAmount = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = fields.copyWith(sellingExpensePerUnitAmount: value);
      calculator.sellingExpensePerUnitAmount = dValue.toSafeDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchSellingExpensePerUnitRate(
    String? value,
  ) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetSellingExpensePerUnitRate: true);
      calculator.sellingExpensePerUnitRate = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = fields = fields.copyWith(sellingExpensePerUnitRate: value);
      calculator.sellingExpensePerUnitRate = (dValue / dHundred).toSafeDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchOperatingExpenses(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetOperatingExpenses: true);
      calculator.operatingExpenses = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = fields.copyWith(operatingExpenses: value);
      calculator.operatingExpenses = dValue.toSafeDouble();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexProfitAndLossCalculatorBlocState patchTaxRate(String? value) {
    var fields = currentState.fields;

    if (value == null) {
      fields = fields.copyWithDefaults(resetTaxRate: true);
      calculator.taxRate = 0;
    } else {
      final dValue = toDecimalOrDefault(value);
      fields = fields = fields.copyWith(taxRate: value);
      calculator.taxRate = (dValue / dHundred).toSafeDouble();
    }

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
