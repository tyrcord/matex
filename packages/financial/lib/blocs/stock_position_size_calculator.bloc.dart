import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';
import 'package:fastyle_forms/fastyle_forms.dart';

final _kDefaultStockPositionSizeBlocState =
    MatexStockPositionSizeCalculatorBlocState(
  fields: const MatexStockPositionSizeCalculatorBlocFields(),
  results: const MatexStockPositionSizeCalculatorBlocResults(),
);

class MatexStockPositionSizeCalculatorBloc extends MatexCalculatorBloc<
    MatexStockPositionSizeCalculator,
    FastCalculatorBlocEvent,
    MatexStockPositionSizeCalculatorBlocState,
    MatexStockPositionSizeCalculatorBlocDocument,
    MatexStockPositionSizeCalculatorBlocResults> {
  MatexStockPositionSizeCalculatorBloc({
    MatexStockPositionSizeCalculatorBlocState? initialState,
    MatexStockPositionSizeCalculatorDataProvider? dataProvider,
  }) : super(
          initialState: initialState ?? _kDefaultStockPositionSizeBlocState,
          dataProvider:
              dataProvider ?? MatexStockPositionSizeCalculatorDataProvider(),
        ) {
    calculator = MatexStockPositionSizeCalculator();
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocResults> compute() async {
    final results = calculator.value();

    return MatexStockPositionSizeCalculatorBlocResults(
      stopLossPercentWithSlippage: results.stopLossPercentWithSlippage,
      stopLossPriceWithSlippage: results.stopLossPriceWithSlippage,
      entryPriceWithSlippage: results.entryPriceWithSlippage,
      takeProfitFeeAmount: results.takeProfitFeeAmount,
      takeProfitAmount: results.takeProfitAmount,
      takeProfitPrice: results.takeProfitPrice,
      stopLossPercent: results.stopLossPercent,
      involvedCapital: results.involvedCapital,
      entryFeeAmount: results.entryFeeAmount,
      positionAmount: results.positionAmount,
      stopLossFeeAmount: results.stopLossFeeAmount,
      toleratedRisk: results.toleratedRisk,
      effectiveRisk: results.effectiveRisk,
      riskPercent: results.riskPercent,
      totalFeesForLossPosition: results.totalFeesForLossPosition,
      totalFeesForProfitPosition: results.totalFeesForProfitPosition,
      shares: results.shares,
      formattedPositionAmount: localizeCurrency(value: results.positionAmount),
      formattedEntryFeeAmount: localizeCurrency(value: results.entryFeeAmount),
      formattedToleratedRisk: localizeCurrency(value: results.toleratedRisk),
      formattedEffectiveRisk: localizeCurrency(value: results.effectiveRisk),
      formattedRiskPercent: localizePercentage(value: results.riskPercent),
      formattedShares: localizeNumber(value: results.shares ?? 0),
      formattedTotalFeesForProfitPosition: localizeCurrency(
        value: results.totalFeesForProfitPosition,
      ),
      formattedTotalFeesForLossPosition: localizeCurrency(
        value: results.totalFeesForLossPosition,
      ),
      formattedTakeProfitFeeAmount: localizeCurrency(
        value: results.takeProfitFeeAmount,
      ),
      formattedStopLossFeeAmount: localizeCurrency(
        value: results.stopLossFeeAmount,
      ),
      formattedInvolvedCapital: localizePercentage(
        value: results.involvedCapital,
      ),
      formattedStopLossPercent: localizePercentage(
        value: results.stopLossPercent,
      ),
      formattedTakeProfitAmount: localizeCurrency(
        value: results.takeProfitAmount,
      ),
      formattedTakeProfitPrice: localizeCurrency(
        value: results.takeProfitPrice,
      ),
      formattedStopLossPercentWithSlippage: localizePercentage(
        value: results.stopLossPercentWithSlippage,
      ),
      formattedStopLossPriceWithSlippage: localizeCurrency(
        value: results.stopLossPriceWithSlippage,
      ),
      formattedEntryPriceWithSlippage: localizeCurrency(
        value: results.entryPriceWithSlippage,
      ),
    );
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      if (key == MatexStockPositionSizeCalculatorBlocKey.accountSize) {
        return document.copyWith(accountSize: value.toString());
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.entryPrice) {
        return document.copyWith(entryPrice: value.toString());
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.stopLossPrice) {
        return document.copyWith(stopLossPrice: value.toString());
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.stopLossAmount) {
        return document.copyWith(stopLossAmount: value.toString());
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.slippagePercent) {
        return document.copyWith(slippagePercent: value.toString());
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.riskPercent) {
        return document.copyWith(riskPercent: value.toString());
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.rewardRisk) {
        return document.copyWith(rewardRisk: value.toString());
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.entryFees) {
        return document.copyWith(entryFees: value.toString());
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.exitFees) {
        return document.copyWith(exitFees: value.toString());
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.riskFieldType) {
        return document.copyWith(riskFieldType: value.toString());
      }
    } else if (value is Enum) {
      value = describeEnum(value);

      if (key == MatexStockPositionSizeCalculatorBlocKey.riskFieldType) {
        return document.copyWith(
          riskFieldType: value.toString(),
          stopLossAmount: '',
          riskPercent: '',
        );
      }
    }

    return null;
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is String) {
      if (key == MatexStockPositionSizeCalculatorBlocKey.accountSize) {
        return patchAccountSize(value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.entryPrice) {
        return patchEntryPrice(value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.stopLossPrice) {
        return patchStopLossPrice(value);
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.stopLossAmount) {
        return patchStopLossAmount(value);
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.slippagePercent) {
        return patchSlippagePercent(value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.riskPercent) {
        return patchRiskPercent(value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.rewardRisk) {
        return patchRewardRisk(value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.entryFees) {
        return patchEntryFees(value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.exitFees) {
        return patchExitFees(value);
      }
    } else if (value is Enum) {
      value = describeEnum(value);

      if (key == MatexStockPositionSizeCalculatorBlocKey.riskFieldType) {
        return patchRiskFieldType(value);
      }
    }

    return currentState;
  }

  @override
  Future<void> resetCalculator(
    MatexStockPositionSizeCalculatorBlocDocument document,
  ) async {
    final slippagePercent = toDecimal(document.slippagePercent) ?? dZero;
    final riskPercent = toDecimal(document.riskPercent) ?? dZero;
    final entryFees = toDecimal(document.entryFees) ?? dZero;
    final exitFees = toDecimal(document.exitFees) ?? dZero;

    calculator.setState(MatexStockPositionSizeCalculatorState(
      stopLossAmount: parseStringToDouble(document.stopLossAmount),
      stopLossPrice: parseStringToDouble(document.stopLossPrice),
      accountSize: parseStringToDouble(document.accountSize),
      entryPrice: parseStringToDouble(document.entryPrice),
      rewardRisk: parseStringToDouble(document.rewardRisk),
      slippagePercent: (slippagePercent / dHundred).toDouble(),
      riskPercent: (riskPercent / dHundred).toDouble(),
      entryFees: (entryFees / dHundred).toDouble(),
      exitFees: (exitFees / dHundred).toDouble(),
    ));
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocState> resetCalculatorBlocState(
    MatexStockPositionSizeCalculatorBlocDocument document,
  ) async {
    return _kDefaultStockPositionSizeBlocState;
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocDocument>
      retrieveDefaultCalculatorDocument() async {
    return const MatexStockPositionSizeCalculatorBlocDocument();
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocResults>
      retrieveDefaultResult() async {
    return MatexStockPositionSizeCalculatorBlocResults(
      formattedShares: localizeNumber(value: 0),
      shares: 0,
    );
  }

  MatexStockPositionSizeCalculatorBlocState patchAccountSize(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(accountSize: value);
    calculator.accountSize = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchEntryPrice(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(entryPrice: value);
    calculator.entryPrice = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchStopLossPrice(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(stopLossPrice: value);
    calculator.stopLossPrice = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchSlippagePercent(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(slippagePercent: value);
    calculator.slippagePercent = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchRewardRisk(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(rewardRisk: value);
    calculator.rewardRisk = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchEntryFees(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(entryFees: value);
    calculator.entryFees = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchExitFees(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(exitFees: value);
    calculator.exitFees = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchRiskPercent(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(
      riskPercent: value,
      stopLossAmount: '',
    );

    // also reset stop loss amount
    calculator.riskPercent = (dValue / dHundred).toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchStopLossAmount(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(
      stopLossAmount: value,
      riskPercent: '',
    );

    // also reset risk percent
    calculator.stopLossAmount = dValue.toDouble();

    return currentState.copyWith(fields: fields);
  }

  MatexStockPositionSizeCalculatorBlocState patchRiskFieldType(
    String value,
  ) {
    final fields = currentState.fields.copyWith(
      riskFieldType: value.toString(),
      stopLossAmount: '',
      riskPercent: '',
    );

    // also reset stop loss amount
    calculator.riskPercent = 0;

    return currentState.copyWith(fields: fields);
  }

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final inputs = _buildInputReportEntries(context);
    final results = _buildResultReportEntries(context);

    final reporter = FastPdfCalculatorReporter();

    return reporter.report(
      title: 'Stock Position Size Report',
      disclaimerText:
          'Participating in financial markets involves risks that may lead to '
          'financial losses. Please do not make trading or investment '
          'decisions based solely on this information.',
      inputs: inputs,
      results: results,
      author: 'Pdf generated using StockPosQal App',
      categories: _buildCategoryEntries(context),
    );
  }

  List<FastReportEntry> _buildInputReportEntries(BuildContext context) {
    final fields = currentState.fields;

    final accountBalance = double.tryParse(fields.accountSize ?? '') ?? 0;
    final stopLossAmount = double.tryParse(fields.stopLossAmount ?? '') ?? 0;
    final risk = double.tryParse(fields.riskPercent ?? '') ?? 0;
    final entryPrice = double.tryParse(fields.entryPrice ?? '') ?? 0;
    final stopLossPrice = double.tryParse(fields.stopLossPrice ?? '') ?? 0;
    final rewardRisk = double.tryParse(fields.rewardRisk ?? '') ?? 0;
    final entryFees = double.tryParse(fields.entryFees ?? '') ?? 0;
    final exitFees = double.tryParse(fields.exitFees ?? '') ?? 0;
    final slippage = double.tryParse(fields.slippagePercent ?? '') ?? 0;

    return [
      FastReportEntry(
        name: 'Account Balance',
        value: localizeCurrency(value: accountBalance),
      ),
      if (fields.riskFieldType == FastAmountSwitchFieldType.amount.name)
        FastReportEntry(
          name: 'Stop Loss Amount',
          value: localizeCurrency(value: stopLossAmount),
        )
      else
        FastReportEntry(
          name: 'Risk',
          value: '${localizeNumber(value: risk)}%',
        ),
      FastReportEntry(
        name: 'Entry Price',
        value: localizeCurrency(value: entryPrice),
      ),
      FastReportEntry(
        name: 'Stop Loss Price',
        value: localizeCurrency(value: stopLossPrice),
      ),
      FastReportEntry(
        name: 'Reward/Risk Ratio',
        value: '${localizeNumber(value: rewardRisk)}:1',
      ),
      if (fields.entryFees != null && fields.entryFees!.isNotEmpty)
        FastReportEntry(
          name: 'Entry Fees',
          value: '${localizeNumber(value: entryFees)}%',
        ),
      if (fields.exitFees != null && fields.exitFees!.isNotEmpty)
        FastReportEntry(
          name: 'Exit Fees',
          value: '${localizeNumber(value: exitFees)}%',
        ),
      if (fields.slippagePercent != null && fields.slippagePercent!.isNotEmpty)
        FastReportEntry(
          name: 'Slippage',
          value: '${localizeNumber(value: slippage)}%',
        ),
    ];
  }

  List<FastReportEntry> _buildResultReportEntries(BuildContext context) {
    final results = currentState.results;
    final palette = ThemeHelper.getPaletteColors(context);

    return [
      FastReportEntry(
        name: 'Shares',
        value: results.formattedShares.toString(),
        color: palette.indigo.mid,
      ),
      if (results.positionAmount != null && results.positionAmount != 0)
        FastReportEntry(
          name: 'Position Amount',
          value: results.formattedPositionAmount!,
          color: palette.blueGray.mid,
        ),
    ];
  }

  /// Builds a list of [FastReportCategoryEntry] objects based on the current
  /// state and context.
  ///
  /// The function retrieves the necessary data from the [currentState] and
  /// [fields] objects and initializes the [palette] using the
  /// [ThemeHelper.getPaletteColors] method. It constructs a list of
  /// [FastReportCategoryEntry] objects representing different categories in the
  /// report, based on certain conditions and data.
  ///
  /// Returns a list of [FastReportCategoryEntry] objects.
  List<FastReportCategoryEntry> _buildCategoryEntries(BuildContext context) {
    final results = currentState.results;
    final fields = currentState.fields;
    final palette = ThemeHelper.getPaletteColors(context);

    return [
      if (_shouldAddRiskCategory(results))
        _buildRiskCategory(results, fields, palette),
      if (_shouldAddEntryCategory(results, fields))
        _buildEntryCategory(results, fields),
      if (_shouldAddStopLossCategory(results))
        _buildStopLossCategory(results, fields, palette),
      if (_shouldAddTakeProfitCategory(results))
        _buildTakeProfitCategory(results, fields, palette),
    ];
  }

  bool _shouldAddRiskCategory(
    MatexStockPositionSizeCalculatorBlocResults results,
  ) {
    final effectiveRisk = results.effectiveRisk;

    return effectiveRisk != null && effectiveRisk != 0;
  }

  /// Builds the "Risk" category of the report.
  ///
  /// The function takes [results], [fields], and [palette] as parameters and
  /// constructs a [FastReportCategoryEntry] object representing the "Risk"
  /// category. The category contains entries such as "Involved Capital", "Risk
  /// Percent", "Tolerated Risk", and "Effective Risk", based on certain
  /// conditions and values.
  ///
  /// Returns a [FastReportCategoryEntry] object representing the "Risk"
  /// category.
  FastReportCategoryEntry _buildRiskCategory(
    MatexStockPositionSizeCalculatorBlocResults results,
    MatexStockPositionSizeCalculatorBlocFields fields,
    FastPaletteColors palette,
  ) {
    final entries = <FastReportEntry>[];

    if (results.involvedCapital != null && results.involvedCapital != 0) {
      entries.add(FastReportEntry(
        name: 'Involved Capital',
        value: results.formattedInvolvedCapital!,
      ));
    }

    if (results.riskPercent != null &&
        results.riskPercent != 0 &&
        fields.riskFieldType != FastAmountSwitchFieldType.percent.name) {
      entries.add(FastReportEntry(
        name: 'Risk Percent',
        value: results.formattedRiskPercent!,
      ));
    }

    if (results.toleratedRisk != null &&
        results.toleratedRisk != 0 &&
        fields.riskFieldType != FastAmountSwitchFieldType.amount.name) {
      entries.add(FastReportEntry(
        name: 'Tolerated Risk',
        value: results.formattedToleratedRisk!,
      ));
    }

    if (results.effectiveRisk != null &&
        results.effectiveRisk != 0 &&
        results.effectiveRisk != results.toleratedRisk) {
      entries.add(FastReportEntry(
        name: 'Effective Risk',
        value: results.formattedEffectiveRisk!,
        color: palette.red.mid,
      ));
    }

    return FastReportCategoryEntry(
      name: 'Risk',
      entries: entries,
    );
  }

  /// Checks if the "Entry" category should be added to the report.
  ///
  /// The function takes [results] and [fields] as parameters and checks if the
  /// "Entry" category should be added based on certain conditions and values.
  ///
  /// Returns a boolean value indicating whether the "Entry" category should be
  /// added.
  bool _shouldAddEntryCategory(
    MatexStockPositionSizeCalculatorBlocResults results,
    MatexStockPositionSizeCalculatorBlocFields fields,
  ) {
    final entryPrice = results.entryPriceWithSlippage;
    final entryFeeAmount = results.entryFeeAmount;
    final slippagePercent = fields.slippagePercent;
    final dSlippagePercent = toDecimal(slippagePercent);

    return (entryFeeAmount != null && entryFeeAmount > 0) ||
        (entryPrice != null &&
            entryPrice > 0 &&
            dSlippagePercent != null &&
            dSlippagePercent != dZero);
  }

  /// Builds the "Entry" category of the report.
  ///
  /// The function takes [results] and [fields] as parameters and constructs a
  /// [FastReportCategoryEntry] object representing the "Entry" category. The
  /// category contains entries such as "Entry Price with Slippage" and
  /// "Entry Fee Amount", based on certain conditions and values.
  ///
  /// Returns a [FastReportCategoryEntry] object representing the "Entry"
  /// category.
  FastReportCategoryEntry _buildEntryCategory(
    MatexStockPositionSizeCalculatorBlocResults results,
    MatexStockPositionSizeCalculatorBlocFields fields,
  ) {
    final entries = <FastReportEntry>[];

    if (results.entryPriceWithSlippage != null &&
        results.entryPriceWithSlippage != 0 &&
        fields.slippagePercent != null &&
        fields.slippagePercent!.isNotEmpty) {
      entries.add(FastReportEntry(
        name: 'Entry Price with Slippage',
        value: results.formattedEntryPriceWithSlippage!,
      ));
    }

    if (results.entryFeeAmount != null && results.entryFeeAmount != 0) {
      entries.add(FastReportEntry(
        name: 'Entry Fee Amount',
        value: results.formattedEntryFeeAmount!,
      ));
    }

    return FastReportCategoryEntry(
      name: 'Entry',
      entries: entries,
    );
  }

  bool _shouldAddStopLossCategory(
    MatexStockPositionSizeCalculatorBlocResults results,
  ) {
    final stopLossPrice = results.stopLossPriceWithSlippage;

    return stopLossPrice != null && stopLossPrice != 0;
  }

  /// Builds the "Stop Loss" category of the report.
  ///
  /// The function takes [results], [fields], and [palette] as parameters and
  /// constructs a [FastReportCategoryEntry] object representing the "Stop Loss"
  /// category. The category contains entries such as "Stop Loss Price with
  /// Slippage", "Stop Loss Percent", "Stop Loss Percent with Slippage", "Stop
  /// Loss Fee Amount", and "Total Fees for Loss Position", based on certain
  /// conditions and values.
  ///
  /// Returns a [FastReportCategoryEntry] object representing the "Stop Loss"
  /// category.
  FastReportCategoryEntry _buildStopLossCategory(
    MatexStockPositionSizeCalculatorBlocResults results,
    MatexStockPositionSizeCalculatorBlocFields fields,
    FastPaletteColors palette,
  ) {
    final entries = <FastReportEntry>[];

    if (results.stopLossPriceWithSlippage != null &&
        results.stopLossPriceWithSlippage != 0 &&
        fields.slippagePercent != null &&
        fields.slippagePercent!.isNotEmpty) {
      entries.add(FastReportEntry(
        name: 'Stop Loss Price with Slippage',
        value: results.formattedStopLossPriceWithSlippage!,
      ));
    }

    if (results.stopLossPercent != null && results.stopLossPercent != 0) {
      entries.add(FastReportEntry(
        name: 'Stop Loss Percent',
        value: results.formattedStopLossPercent!,
      ));
    }

    if (results.stopLossPercentWithSlippage != null &&
        results.stopLossPercentWithSlippage != 0 &&
        results.stopLossPercent != results.stopLossPercentWithSlippage) {
      entries.add(FastReportEntry(
        name: 'Stop Loss Percent with Slippage',
        value: results.formattedStopLossPercentWithSlippage!,
      ));
    }

    if (results.stopLossFeeAmount != null && results.stopLossFeeAmount != 0) {
      entries.add(FastReportEntry(
        name: 'Stop Loss Fee Amount',
        value: results.formattedStopLossFeeAmount!,
      ));
    }

    if (results.totalFeesForLossPosition != null &&
        results.totalFeesForLossPosition != 0 &&
        results.totalFeesForLossPosition != results.stopLossFeeAmount) {
      entries.add(FastReportEntry(
        name: 'Total Fees for Loss Position',
        value: results.formattedTotalFeesForLossPosition!,
        color: palette.orange.mid,
      ));
    }

    return FastReportCategoryEntry(
      name: 'Stop Loss',
      entries: entries,
    );
  }

  bool _shouldAddTakeProfitCategory(
    MatexStockPositionSizeCalculatorBlocResults results,
  ) {
    final takeProfitPrice = results.takeProfitPrice;

    return takeProfitPrice != null && takeProfitPrice != 0;
  }

  /// Builds the "Take Profit" category of the report.
  ///
  /// The function takes [results], [fields], and [palette] as parameters and
  /// constructs a [FastReportCategoryEntry] object representing the
  /// "Take Profit" category. The category contains entries such as
  /// "Take Profit Amount", "Take Profit Price", "Take Profit Fee Amount", and
  /// "Total Fees for Profit Position", based on certain conditions and values.
  ///
  /// Returns a [FastReportCategoryEntry] object representing the "Take Profit"
  /// category.
  FastReportCategoryEntry _buildTakeProfitCategory(
    MatexStockPositionSizeCalculatorBlocResults results,
    MatexStockPositionSizeCalculatorBlocFields fields,
    FastPaletteColors palette,
  ) {
    final entries = <FastReportEntry>[];

    if (results.takeProfitAmount != null && results.takeProfitAmount != 0) {
      entries.add(FastReportEntry(
        name: 'Take Profit Amount',
        value: results.formattedTakeProfitAmount!,
        color: palette.green.mid,
      ));
    }

    if (results.takeProfitPrice != null && results.takeProfitPrice != 0) {
      entries.add(FastReportEntry(
        name: 'Take Profit Price',
        value: results.formattedTakeProfitPrice!,
      ));
    }

    if (results.takeProfitFeeAmount != null &&
        results.takeProfitFeeAmount != 0) {
      entries.add(FastReportEntry(
        name: 'Take Profit Fee Amount',
        value: results.formattedTakeProfitFeeAmount!,
      ));
    }

    if (results.totalFeesForProfitPosition != null &&
        results.totalFeesForProfitPosition != 0 &&
        results.takeProfitFeeAmount != results.totalFeesForProfitPosition) {
      entries.add(FastReportEntry(
        name: 'Total Fees for Profit Position',
        value: results.formattedTotalFeesForProfitPosition!,
        color: palette.orange.mid,
      ));
    }

    return FastReportCategoryEntry(
      name: 'Take Profit',
      entries: entries,
    );
  }
}
