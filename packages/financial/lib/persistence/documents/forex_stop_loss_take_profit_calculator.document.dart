// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexStopLossTakeProfitCalculatorDocument
    extends FastCalculatorDocument {
  static const String defaultPositionSizeFieldType = 'unit';
  static const String defaultStopLossFieldType = 'price';
  static const String defaultTakeProfitFieldType = 'price';

  static String defaultPosition = MatexPosition.long.name;

  late final String? accountCurrency;
  late final String? base;
  late final String? counter;
  late final String? positionSize;
  late final String? entryPrice;
  late final String? pipDecimalPlaces;
  late final String positionSizeFieldType;
  late final String? lotSize;
  late final String? stopLossPrice;
  late final String? stopLossPips;
  late final String? stopLossAmount;
  late final String? takeProfitPrice;
  late final String? takeProfitPips;
  late final String? takeProfitAmount;
  late final String position;
  late final String stopLossFieldType;
  late final String takeProfitFieldType;

  MatexForexStopLossTakeProfitCalculatorDocument({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? entryPrice,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
    String? lotSize,
    String? stopLossPrice,
    String? stopLossPips,
    String? stopLossAmount,
    String? takeProfitPrice,
    String? takeProfitPips,
    String? takeProfitAmount,
    String? position,
    String? stopLossFieldType,
    String? takeProfitFieldType,
  }) {
    this.accountCurrency = assignValue(accountCurrency);
    this.base = assignValue(base);
    this.counter = assignValue(counter);
    this.positionSize = assignValue(positionSize);
    this.entryPrice = assignValue(entryPrice);
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces);
    this.lotSize = assignValue(lotSize);
    this.stopLossPrice = assignValue(stopLossPrice);
    this.stopLossPips = assignValue(stopLossPips);
    this.stopLossAmount = assignValue(stopLossAmount);
    this.takeProfitPrice = assignValue(takeProfitPrice);
    this.takeProfitPips = assignValue(takeProfitPips);
    this.takeProfitAmount = assignValue(takeProfitAmount);
    this.position = position ?? defaultPosition;
    this.stopLossFieldType = stopLossFieldType ?? defaultStopLossFieldType;
    this.positionSizeFieldType =
        positionSizeFieldType ?? defaultPositionSizeFieldType;
    this.takeProfitFieldType =
        takeProfitFieldType ?? defaultTakeProfitFieldType;
  }

  @override
  MatexForexStopLossTakeProfitCalculatorDocument clone() => copyWith();

  @override
  MatexForexStopLossTakeProfitCalculatorDocument copyWith({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? entryPrice,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
    String? lotSize,
    String? stopLossPrice,
    String? stopLossPips,
    String? stopLossAmount,
    String? takeProfitPrice,
    String? takeProfitPips,
    String? takeProfitAmount,
    String? position,
    String? stopLossFieldType,
    String? takeProfitFieldType,
  }) {
    return MatexForexStopLossTakeProfitCalculatorDocument(
      accountCurrency: accountCurrency ?? this.accountCurrency,
      base: base ?? this.base,
      counter: counter ?? this.counter,
      positionSize: positionSize ?? this.positionSize,
      entryPrice: entryPrice ?? this.entryPrice,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      lotSize: lotSize ?? this.lotSize,
      positionSizeFieldType:
          positionSizeFieldType ?? this.positionSizeFieldType,
      stopLossPrice: stopLossPrice ?? this.stopLossPrice,
      stopLossPips: stopLossPips ?? this.stopLossPips,
      stopLossAmount: stopLossAmount ?? this.stopLossAmount,
      takeProfitPrice: takeProfitPrice ?? this.takeProfitPrice,
      takeProfitPips: takeProfitPips ?? this.takeProfitPips,
      takeProfitAmount: takeProfitAmount ?? this.takeProfitAmount,
      position: position ?? this.position,
      stopLossFieldType: stopLossFieldType ?? this.stopLossFieldType,
      takeProfitFieldType: takeProfitFieldType ?? this.takeProfitFieldType,
    );
  }

  @override
  MatexForexStopLossTakeProfitCalculatorDocument copyWithDefaults({
    bool resetAccountCurrency = false,
    bool resetBase = false,
    bool resetCounter = false,
    bool resetPositionSize = false,
    bool resetEntryPrice = false,
    bool resetPipDecimalPlaces = false,
    bool resetPositionSizeFieldType = false,
    bool resetLotSize = false,
    bool resetStopLossPrice = false,
    bool resetStopLossPips = false,
    bool resetStopLossAmount = false,
    bool resetTakeProfitPrice = false,
    bool resetTakeProfitPips = false,
    bool resetTakeProfitAmount = false,
    bool resetPosition = false,
    bool resetstopLossFieldType = false,
    bool resettakeProfitFieldType = false,
  }) {
    return MatexForexStopLossTakeProfitCalculatorDocument(
      accountCurrency: resetAccountCurrency ? null : accountCurrency,
      base: resetBase ? null : base,
      counter: resetCounter ? null : counter,
      positionSize: resetPositionSize ? null : positionSize,
      entryPrice: resetEntryPrice ? null : entryPrice,
      pipDecimalPlaces: resetPipDecimalPlaces ? null : pipDecimalPlaces,
      lotSize: resetLotSize ? null : lotSize,
      positionSizeFieldType:
          resetPositionSizeFieldType ? null : positionSizeFieldType,
      stopLossPrice: resetStopLossPrice ? null : stopLossPrice,
      stopLossPips: resetStopLossPips ? null : stopLossPips,
      stopLossAmount: resetStopLossAmount ? null : stopLossAmount,
      takeProfitPrice: resetTakeProfitPrice ? null : takeProfitPrice,
      takeProfitPips: resetTakeProfitPips ? null : takeProfitPips,
      takeProfitAmount: resetTakeProfitAmount ? null : takeProfitAmount,
      position: resetPosition ? null : position,
      stopLossFieldType: resetstopLossFieldType ? null : stopLossFieldType,
      takeProfitFieldType:
          resettakeProfitFieldType ? null : takeProfitFieldType,
    );
  }

  @override
  MatexForexStopLossTakeProfitCalculatorDocument merge(
    covariant MatexForexStopLossTakeProfitCalculatorDocument model,
  ) {
    return copyWith(
      accountCurrency: model.accountCurrency,
      base: model.base,
      counter: model.counter,
      positionSize: model.positionSize,
      entryPrice: model.entryPrice,
      pipDecimalPlaces: model.pipDecimalPlaces,
      lotSize: model.lotSize,
      positionSizeFieldType: model.positionSizeFieldType,
      stopLossPrice: model.stopLossPrice,
      stopLossPips: model.stopLossPips,
      stopLossAmount: model.stopLossAmount,
      takeProfitPrice: model.takeProfitPrice,
      takeProfitPips: model.takeProfitPips,
      takeProfitAmount: model.takeProfitAmount,
      position: model.position,
      stopLossFieldType: model.stopLossFieldType,
      takeProfitFieldType: model.takeProfitFieldType,
    );
  }

  @override
  MatexForexStopLossTakeProfitCalculatorBlocFields toFields() {
    return MatexForexStopLossTakeProfitCalculatorBlocFields(
      accountCurrency: accountCurrency,
      base: base,
      counter: counter,
      positionSize: positionSize,
      entryPrice: entryPrice,
      pipDecimalPlaces: pipDecimalPlaces,
      lotSize: lotSize,
      stopLossPrice: stopLossPrice,
      stopLossPips: stopLossPips,
      stopLossAmount: stopLossAmount,
      takeProfitPrice: takeProfitPrice,
      takeProfitPips: takeProfitPips,
      takeProfitAmount: takeProfitAmount,
      position: MatexPositionX.fromName(position),
      stopLossFieldType: stopLossFieldType,
      takeProfitFieldType: takeProfitFieldType,
      positionSizeFieldType:
          MatexPositionSizeTypeX.fromName(positionSizeFieldType),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'accountCurrency': accountCurrency,
      'base': base,
      'counter': counter,
      'positionSize': positionSize,
      'entryPrice': entryPrice,
      'pipDecimalPlaces': pipDecimalPlaces,
      'positionSizeFieldType': positionSizeFieldType,
      'lotSize': lotSize,
      'stopLossPrice': stopLossPrice,
      'stopLossPips': stopLossPips,
      'stopLossAmount': stopLossAmount,
      'takeProfitPrice': takeProfitPrice,
      'takeProfitPips': takeProfitPips,
      'takeProfitAmount': takeProfitAmount,
      'position': position,
      'stopLossFieldType': stopLossFieldType,
      'takeProfitFieldType': takeProfitFieldType,
      ...super.toJson(),
    };
  }

  static MatexForexStopLossTakeProfitCalculatorDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexForexStopLossTakeProfitCalculatorDocument(
      accountCurrency: json['accountCurrency'] as String?,
      base: json['base'] as String?,
      counter: json['counter'] as String?,
      positionSize: json['positionSize'] as String?,
      entryPrice: json['entryPrice'] as String?,
      pipDecimalPlaces: json['pipDecimalPlaces'] as String?,
      positionSizeFieldType: json['positionSizeFieldType'] as String?,
      lotSize: json['lotSize'] as String?,
      stopLossPrice: json['stopLossPrice'] as String?,
      stopLossPips: json['stopLossPips'] as String?,
      stopLossAmount: json['stopLossAmount'] as String?,
      takeProfitPrice: json['takeProfitPrice'] as String?,
      takeProfitPips: json['takeProfitPips'] as String?,
      takeProfitAmount: json['takeProfitAmount'] as String?,
      position: json['position'] as String?,
      stopLossFieldType: json['stopLossFieldType'] as String?,
      takeProfitFieldType: json['takeProfitFieldType'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        accountCurrency,
        base,
        counter,
        positionSize,
        entryPrice,
        pipDecimalPlaces,
        positionSizeFieldType,
        lotSize,
        stopLossPrice,
        stopLossPips,
        stopLossAmount,
        takeProfitPrice,
        takeProfitPips,
        takeProfitAmount,
        position,
        stopLossFieldType,
        takeProfitFieldType,
      ];
}
