// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexForexStopLossTakeProfitCalculatorBlocFields
    extends MatexFinancialInstrumentCalculatorBlocFields
    with MatexCalculatorFormatterMixin, MatexFinancialCalculatorFormatterMixin {
  static const defaultPositionSizeFieldType = MatexPositionSizeType.unit;
  static MatexPosition defaultPosition = MatexPosition.long;
  static const String defaultTakeProfitFieldType = 'price';
  static const String defaultStopLossFieldType = 'price';

  late final MatexPositionSizeType positionSizeFieldType;
  late final String takeProfitFieldType;
  late final String? pipDecimalPlaces;
  late final String stopLossFieldType;
  late final String? takeProfitAmount;
  late final String? accountCurrency;
  late final String? takeProfitPrice;
  late final String? takeProfitPips;
  late final String? stopLossAmount;
  late final MatexPosition position;
  late final String? stopLossPrice;
  late final String? stopLossPips;
  late final String? positionSize;
  late final String? entryPrice;
  late final String? lotSize;

  String get formattedPositionSize {
    final value = parseFieldValueToDouble(positionSize);

    return localizeNumber(value: value);
  }

  String get formattedFinancialInstrument {
    if (base == null || counter == null) return '';

    return financialInstrument?.formattedSymbol ?? '';
  }

  MatexFinancialInstrument? get financialInstrument {
    if (base == null || counter == null) return null;

    return MatexFinancialInstrument(base: base!, counter: counter!);
  }

  MatexForexStopLossTakeProfitCalculatorBlocFields({
    MatexPositionSizeType? positionSizeFieldType,
    FastCalculatorBlocDelegate? delegate,
    String? takeProfitFieldType,
    String? stopLossFieldType,
    String? pipDecimalPlaces,
    String? takeProfitAmount,
    String? accountCurrency,
    String? takeProfitPrice,
    MatexPosition? position,
    String? stopLossAmount,
    String? takeProfitPips,
    String? stopLossPrice,
    String? stopLossPips,
    String? positionSize,
    String? entryPrice,
    String? lotSize,
    String? counter,
    String? base,
  }) {
    this.stopLossFieldType = stopLossFieldType ?? defaultStopLossFieldType;
    this.takeProfitAmount = assignValue(takeProfitAmount);
    this.accountCurrency = assignValue(accountCurrency);
    this.takeProfitPrice = assignValue(takeProfitPrice);
    this.stopLossAmount = assignValue(stopLossAmount);
    this.takeProfitPips = assignValue(takeProfitPips);
    this.stopLossPrice = assignValue(stopLossPrice);
    this.stopLossPips = assignValue(stopLossPips);
    this.positionSize = assignValue(positionSize);
    this.position = position ?? defaultPosition;
    this.entryPrice = assignValue(entryPrice);
    this.lotSize = assignValue(lotSize);
    this.counter = assignValue(counter);
    this.base = assignValue(base);
    this.delegate = delegate;
    this.positionSizeFieldType =
        positionSizeFieldType ?? defaultPositionSizeFieldType;
    this.takeProfitFieldType =
        takeProfitFieldType ?? defaultTakeProfitFieldType;
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces) ??
        kMatexDefaultPipDecimalPlaces.toString();
  }

  @override
  MatexForexStopLossTakeProfitCalculatorBlocFields clone() => copyWith();

  @override
  MatexForexStopLossTakeProfitCalculatorBlocFields copyWith({
    MatexPositionSizeType? positionSizeFieldType,
    FastCalculatorBlocDelegate? delegate,
    String? takeProfitFieldType,
    String? stopLossFieldType,
    String? pipDecimalPlaces,
    String? takeProfitAmount,
    MatexPosition? position,
    String? takeProfitPrice,
    String? accountCurrency,
    String? takeProfitPips,
    String? stopLossAmount,
    String? stopLossPrice,
    String? positionSize,
    String? stopLossPips,
    String? entryPrice,
    String? lotSize,
    String? counter,
    String? base,
  }) {
    return MatexForexStopLossTakeProfitCalculatorBlocFields(
      takeProfitFieldType: takeProfitFieldType ?? this.takeProfitFieldType,
      stopLossFieldType: stopLossFieldType ?? this.stopLossFieldType,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      takeProfitAmount: takeProfitAmount ?? this.takeProfitAmount,
      accountCurrency: accountCurrency ?? this.accountCurrency,
      takeProfitPrice: takeProfitPrice ?? this.takeProfitPrice,
      takeProfitPips: takeProfitPips ?? this.takeProfitPips,
      stopLossAmount: stopLossAmount ?? this.stopLossAmount,
      stopLossPrice: stopLossPrice ?? this.stopLossPrice,
      stopLossPips: stopLossPips ?? this.stopLossPips,
      positionSize: positionSize ?? this.positionSize,
      entryPrice: entryPrice ?? this.entryPrice,
      position: position ?? this.position,
      delegate: delegate ?? this.delegate,
      counter: counter ?? this.counter,
      lotSize: lotSize ?? this.lotSize,
      base: base ?? this.base,
      positionSizeFieldType:
          positionSizeFieldType ?? this.positionSizeFieldType,
    );
  }

  @override
  MatexForexStopLossTakeProfitCalculatorBlocFields copyWithDefaults({
    bool resetPositionSizeFieldType = false,
    bool resettakeProfitFieldType = false,
    bool resetStopLossFieldType = false,
    bool resetTakeProfitAmount = false,
    bool resetPipDecimalPlaces = false,
    bool resetAccountCurrency = false,
    bool resetTakeProfitPrice = false,
    bool resetTakeProfitPips = false,
    bool resetStopLossAmount = false,
    bool resetStopLossPrice = false,
    bool resetStopLossPips = false,
    bool resetPositionSize = false,
    bool resetEntryPrice = false,
    bool resetPosition = false,
    bool resetLotSize = false,
    bool resetCounter = false,
    bool resetBase = false,
  }) {
    return MatexForexStopLossTakeProfitCalculatorBlocFields(
      stopLossFieldType: resetStopLossFieldType ? null : stopLossFieldType,
      pipDecimalPlaces: resetPipDecimalPlaces ? null : pipDecimalPlaces,
      takeProfitAmount: resetTakeProfitAmount ? null : takeProfitAmount,
      accountCurrency: resetAccountCurrency ? null : accountCurrency,
      takeProfitPrice: resetTakeProfitPrice ? null : takeProfitPrice,
      takeProfitPips: resetTakeProfitPips ? null : takeProfitPips,
      stopLossAmount: resetStopLossAmount ? null : stopLossAmount,
      stopLossPrice: resetStopLossPrice ? null : stopLossPrice,
      stopLossPips: resetStopLossPips ? null : stopLossPips,
      positionSize: resetPositionSize ? null : positionSize,
      entryPrice: resetEntryPrice ? null : entryPrice,
      position: resetPosition ? null : position,
      lotSize: resetLotSize ? null : lotSize,
      counter: resetCounter ? null : counter,
      base: resetBase ? null : base,
      delegate: delegate,
      positionSizeFieldType:
          resetPositionSizeFieldType ? null : positionSizeFieldType,
      takeProfitFieldType:
          resettakeProfitFieldType ? null : takeProfitFieldType,
    );
  }

  @override
  MatexForexStopLossTakeProfitCalculatorBlocFields merge(
    covariant MatexForexStopLossTakeProfitCalculatorBlocFields model,
  ) {
    return copyWith(
      positionSizeFieldType: model.positionSizeFieldType,
      takeProfitFieldType: model.takeProfitFieldType,
      stopLossFieldType: model.stopLossFieldType,
      pipDecimalPlaces: model.pipDecimalPlaces,
      takeProfitAmount: model.takeProfitAmount,
      takeProfitPrice: model.takeProfitPrice,
      accountCurrency: model.accountCurrency,
      stopLossAmount: model.stopLossAmount,
      takeProfitPips: model.takeProfitPips,
      stopLossPrice: model.stopLossPrice,
      stopLossPips: model.stopLossPips,
      positionSize: model.positionSize,
      entryPrice: model.entryPrice,
      position: model.position,
      delegate: model.delegate,
      counter: model.counter,
      lotSize: model.lotSize,
      base: model.base,
    );
  }

  @override
  List<Object?> get props => [
        positionSizeFieldType,
        takeProfitFieldType,
        stopLossFieldType,
        pipDecimalPlaces,
        takeProfitAmount,
        accountCurrency,
        takeProfitPrice,
        stopLossAmount,
        takeProfitPips,
        stopLossPrice,
        stopLossPips,
        positionSize,
        entryPrice,
        position,
        lotSize,
        counter,
        base,
      ];
}
