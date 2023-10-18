import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:matex_core/core.dart';
import 'package:matex_dart/matex_dart.dart' show MatexPosition;
import 'package:matex_financial/financial.dart';
import 'package:t_helpers/helpers.dart';
import 'package:fastyle_forms/fastyle_forms.dart';
import 'package:lingua_finance/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lingua_finance_stock/generated/locale_keys.g.dart';
import 'package:lingua_core/generated/locale_keys.g.dart';

final _kDefaultStockPositionSizeBlocState =
    MatexStockPositionSizeCalculatorBlocState(
  fields: MatexStockPositionSizeCalculatorBlocFields(),
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
    super.showExportPdfDialog,
    super.debouceComputeEvents,
  }) : super(
          initialState: initialState ?? _kDefaultStockPositionSizeBlocState,
          dataProvider:
              dataProvider ?? MatexStockPositionSizeCalculatorDataProvider(),
          debugLabel: 'MatexStockPositionSizeCalculatorBloc',
        ) {
    calculator = MatexStockPositionSizeCalculator();

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorRiskRewardRatio.name,
      MatexStockPositionSizeCalculatorBlocKey.riskReward,
    );

    listenOnDefaultValueChanges(
      MatexCalculatorDefaultValueKeys.matexCalculatorRiskPercent.name,
      MatexStockPositionSizeCalculatorBlocKey.riskPercent,
    );
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
      takeProfitAmountAfterFee: results.takeProfitAmountAfterFee,
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
      formattedTakeProfitAmountAfterFee: localizeCurrency(
        value: results.takeProfitAmountAfterFee,
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
        return document.copyWith(accountSize: value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.entryPrice) {
        return document.copyWith(entryPrice: value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.stopLossPrice) {
        return document.copyWith(stopLossPrice: value);
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.stopLossAmount) {
        return document.copyWith(stopLossAmount: value);
      } else if (key ==
          MatexStockPositionSizeCalculatorBlocKey.slippagePercent) {
        return document.copyWith(slippagePercent: value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.riskPercent) {
        return document.copyWith(riskPercent: value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.riskReward) {
        return document.copyWith(riskReward: value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.entryFees) {
        return document.copyWith(entryFees: value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.exitFees) {
        return document.copyWith(exitFees: value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.riskFieldType) {
        return document.copyWith(riskFieldType: value);
      }
    } else if (value is Enum) {
      value = describeEnum(value);

      if (key == MatexStockPositionSizeCalculatorBlocKey.riskFieldType) {
        return document.copyWith(
          riskFieldType: value.toString(),
          stopLossAmount: '',
          riskPercent: '',
        );
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.position) {
        return document.copyWith(
          position: value.toString(),
          stopLossPrice: '',
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
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.riskReward) {
        return patchRiskReward(value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.entryFees) {
        return patchEntryFees(value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.exitFees) {
        return patchExitFees(value);
      }
    } else if (value is Enum) {
      value = describeEnum(value);

      if (key == MatexStockPositionSizeCalculatorBlocKey.riskFieldType) {
        return patchRiskFieldType(value);
      } else if (key == MatexStockPositionSizeCalculatorBlocKey.position) {
        return patchPosition(value);
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
      isShortPosition: document.position == MatexPosition.short.name,
      stopLossAmount: parseStringToDouble(document.stopLossAmount),
      stopLossPrice: parseStringToDouble(document.stopLossPrice),
      slippagePercent: (slippagePercent / dHundred).toDouble(),
      accountSize: parseStringToDouble(document.accountSize),
      entryPrice: parseStringToDouble(document.entryPrice),
      riskReward: parseStringToDouble(document.riskReward),
      riskPercent: (riskPercent / dHundred).toDouble(),
      entryFees: (entryFees / dHundred).toDouble(),
      exitFees: (exitFees / dHundred).toDouble(),
    ));
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocState> resetCalculatorBlocState(
    MatexStockPositionSizeCalculatorBlocDocument document,
  ) async {
    return _kDefaultStockPositionSizeBlocState.copyWith(
      fields: MatexStockPositionSizeCalculatorBlocFields(
        riskPercent: document.riskPercent,
        riskReward: document.riskReward,
      ),
    );
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocDocument>
      retrieveDefaultCalculatorDocument() async {
    final bloc = FastAppDictBloc.instance;

    return MatexStockPositionSizeCalculatorBlocDocument(
      riskReward: bloc.getValue<String?>(
        MatexCalculatorDefaultValueKeys.matexCalculatorRiskRewardRatio.name,
      ),
      riskPercent: bloc.getValue<String?>(
        MatexCalculatorDefaultValueKeys.matexCalculatorRiskPercent.name,
      ),
    );
  }

  @override
  Future<MatexStockPositionSizeCalculatorBlocResults>
      retrieveDefaultResult() async {
    return MatexStockPositionSizeCalculatorBlocResults(
      formattedShares: localizeNumber(value: 0),
      shares: 0,
    );
  }

  MatexStockPositionSizeCalculatorBlocState patchPosition(String value) {
    final fields = currentState.fields.copyWith(
      position: value,
      stopLossPrice: '',
    );

    calculator
      ..isShortPosition = value == MatexPosition.short.name
      ..stopLossPrice = 0;

    return currentState.copyWith(fields: fields);
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

  MatexStockPositionSizeCalculatorBlocState patchRiskReward(String value) {
    final dValue = toDecimal(value) ?? dZero;
    final fields = currentState.fields.copyWith(riskReward: value);
    calculator.riskReward = dValue.toDouble();

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
      riskFieldType: value,
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
    final appInfoBloc = FastAppInfoBloc();
    final appInfo = appInfoBloc.currentState;

    return reporter.report(
      title: CoreLocaleKeys.core_label_report.tr(),
      disclaimerText:
          FinanceLocaleKeys.finance_disclaimer_intervening_markets.tr(),
      inputs: inputs,
      results: results,
      subtitle: FinanceLocaleKeys.finance_label_position_size.tr(),
      author: CoreLocaleKeys.core_message_pdf_generated_by.tr(namedArgs: {
        'app_name': appInfo.appName,
      }),
      categories: _buildCategoryEntries(context),
      alwaysUse24HourFormat: appSettingsBloc.currentState.alwaysUse24HourFormat,
      languageCode: appSettingsBloc.currentState.languageCode,
      countryCode: appInfo.deviceCountryCode,
    );
  }

  List<FastReportEntry> _buildInputReportEntries(BuildContext context) {
    final fields = currentState.fields;
    final accountBalance = parseFieldValueToDouble(fields.accountSize);
    final stopLossAmount = parseFieldValueToDouble(fields.stopLossAmount);
    final risk = parseFieldValueToDouble(fields.riskPercent);
    final entryPrice = parseFieldValueToDouble(fields.entryPrice);
    final stopLossPrice = parseFieldValueToDouble(fields.stopLossPrice);
    final riskReward = parseFieldValueToDouble(fields.riskReward);
    final entryFees = parseFieldValueToDouble(fields.entryFees);
    final exitFees = parseFieldValueToDouble(fields.exitFees);
    final slippage = parseFieldValueToDouble(fields.slippagePercent);

    return [
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_account_balance.tr(),
        value: localizeCurrency(value: accountBalance),
      ),
      if (fields.riskFieldType == FastAmountSwitchFieldType.amount.name)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_amount_at_risk.tr(),
          value: localizeCurrency(value: stopLossAmount),
        )
      else
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_risk_text.tr(),
          value: '${localizeNumber(value: risk)}%',
        ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_position_text.tr(),
        value: calculator.isShortPosition
            ? FinanceLocaleKeys.finance_label_position_short.tr()
            : FinanceLocaleKeys.finance_label_position_long.tr(),
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_entry_price_at.tr(),
        value: localizeCurrency(value: entryPrice),
      ),
      FastReportEntry(
        name: FinanceLocaleKeys.finance_label_stop_loss_at.tr(),
        value: localizeCurrency(value: stopLossPrice),
      ),
      if (riskReward > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_risk_reward_ratio.tr(),
          value: '${localizeNumber(value: riskReward)}:1',
        ),
      if (entryFees > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_entry_fees_text.tr(),
          value: '${localizeNumber(value: entryFees)}%',
        ),
      if (exitFees > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_exit_fees_text.tr(),
          value: '${localizeNumber(value: exitFees)}%',
        ),
      if (slippage > 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_slippage.tr(),
          value: '${localizeNumber(value: slippage)}%',
        ),
    ];
  }

  List<FastReportEntry> _buildResultReportEntries(BuildContext context) {
    final results = currentState.results;
    final palette = ThemeHelper.getPaletteColors(context);

    return [
      FastReportEntry(
        name: FinanceStockLocaleKeys.stock_label_stock.tr(),
        value: results.formattedShares.toString(),
        color: palette.indigo.mid,
      ),
      if (results.positionAmount != null && results.positionAmount != 0)
        FastReportEntry(
          name: FinanceLocaleKeys.finance_label_position_amount.tr(),
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
      if (_shouldAddTakeProfitCategory(results))
        _buildTakeProfitCategory(results, fields, palette),
      if (_shouldAddStopLossCategory(results))
        _buildStopLossCategory(results, fields, palette),
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
        name: FinanceLocaleKeys.finance_label_involved_capital.tr(),
        value: results.formattedInvolvedCapital!,
      ));
    }

    if (results.riskPercent != null &&
        results.riskPercent != 0 &&
        fields.riskFieldType != FastAmountSwitchFieldType.percent.name) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_risk_in_percentage.tr(),
        value: results.formattedRiskPercent!,
      ));
    }

    if (results.toleratedRisk != null &&
        results.toleratedRisk != 0 &&
        fields.riskFieldType != FastAmountSwitchFieldType.amount.name) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_risk_tolerated.tr(),
        value: results.formattedToleratedRisk!,
        color: results.toleratedRisk == results.effectiveRisk
            ? palette.red.mid
            : null,
      ));
    }

    if (results.effectiveRisk != null &&
        results.effectiveRisk != 0 &&
        results.effectiveRisk != results.toleratedRisk) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_risk_effective.tr(),
        value: results.formattedEffectiveRisk!,
        color: palette.red.mid,
      ));
    }

    return FastReportCategoryEntry(
      name: FinanceLocaleKeys.finance_label_risk_text.tr(),
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
        name: FinanceLocaleKeys.finance_label_entry_price_with_slippage.tr(),
        value: results.formattedEntryPriceWithSlippage!,
      ));
    }

    if (results.entryFeeAmount != null && results.entryFeeAmount != 0) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_entry_fees_amount.tr(),
        value: results.formattedEntryFeeAmount!,
      ));
    }

    return FastReportCategoryEntry(
      name: FinanceLocaleKeys.finance_label_entry_text.tr(),
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
      final slippagePercent = fields.slippagePercent;
      final dSlippagePercent = toDecimal(slippagePercent);

      if (dSlippagePercent != null && dSlippagePercent != dZero) {
        entries.add(FastReportEntry(
          name: FinanceLocaleKeys.finance_label_stop_loss_price_with_slippage
              .tr(),
          value: results.formattedStopLossPriceWithSlippage!,
        ));
      }
    }

    if (results.stopLossPercent != null && results.stopLossPercent != 0) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_stop_loss_in_percentage_text.tr(),
        value: results.formattedStopLossPercent!,
      ));
    }

    if (results.stopLossPercentWithSlippage != null &&
        results.stopLossPercentWithSlippage != 0 &&
        results.stopLossPercent != results.stopLossPercentWithSlippage) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys
            .finance_label_stop_loss_in_percentage_with_slippage
            .tr(),
        value: results.formattedStopLossPercentWithSlippage!,
      ));
    }

    if (results.stopLossFeeAmount != null && results.stopLossFeeAmount != 0) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_amount_fee.tr(),
        value: results.formattedStopLossFeeAmount!,
      ));
    }

    if (results.totalFeesForLossPosition != null &&
        results.totalFeesForLossPosition != 0 &&
        results.totalFeesForLossPosition != results.stopLossFeeAmount) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_total_costs_losing_position.tr(),
        value: results.formattedTotalFeesForLossPosition!,
        color: palette.orange.mid,
      ));
    }

    return FastReportCategoryEntry(
      name: FinanceLocaleKeys.finance_label_stop_loss_text.tr(),
      entries: entries,
    );
  }

  bool _shouldAddTakeProfitCategory(
    MatexStockPositionSizeCalculatorBlocResults results,
  ) {
    final takeProfitPrice = results.takeProfitPrice;
    final takeProfitAmount = results.takeProfitAmount;

    return takeProfitPrice != null &&
        takeProfitAmount != null &&
        takeProfitPrice > 0 &&
        takeProfitAmount > 0;
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
        name: FinanceLocaleKeys.finance_label_take_profit_amount.tr(),
        value: results.formattedTakeProfitAmount!,
        color: results.takeProfitAmount == results.takeProfitAmountAfterFee
            ? palette.green.mid
            : null,
      ));
    }

    if (results.takeProfitPrice != null && results.takeProfitPrice != 0) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_take_profit_price_at.tr(),
        value: results.formattedTakeProfitPrice!,
      ));
    }

    if (results.takeProfitFeeAmount != null &&
        results.takeProfitFeeAmount != 0) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_amount_fee.tr(),
        value: results.formattedTakeProfitFeeAmount!,
      ));
    }

    if (results.takeProfitAmountAfterFee != null &&
        results.takeProfitAmountAfterFee != 0 &&
        results.takeProfitAmount != results.takeProfitAmountAfterFee) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_take_profit_price_after_fee.tr(),
        value: results.formattedTakeProfitAmountAfterFee!,
        color: palette.green.mid,
      ));
    }

    if (results.totalFeesForProfitPosition != null &&
        results.totalFeesForProfitPosition != 0 &&
        results.takeProfitFeeAmount != results.totalFeesForProfitPosition) {
      entries.add(FastReportEntry(
        name: FinanceLocaleKeys.finance_label_total_costs_profit_position.tr(),
        value: results.formattedTotalFeesForProfitPosition!,
        color: palette.orange.mid,
      ));
    }

    return FastReportCategoryEntry(
      name: FinanceLocaleKeys.finance_label_take_profit_text.tr(),
      entries: entries,
    );
  }
}
