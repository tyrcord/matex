// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexStopLossTakeProfitCalculatorDocument
    extends FastCalculatorDocument {
  static const String defaultPositionSizeFieldType = 'unit';
  static const String defaultTakeProfitFieldType = 'price';
  static final defaultPosition = MatexPosition.long.name;
  static const String defaultStopLossFieldType = 'price';

  late final String positionSizeFieldType;
  late final String takeProfitFieldType;
  late final String? pipDecimalPlaces;
  late final String stopLossFieldType;
  late final String? takeProfitAmount;
  late final String? accountCurrency;
  late final String? takeProfitPrice;
  late final String? takeProfitPips;
  late final String? stopLossAmount;
  late final String? stopLossPrice;
  late final String? stopLossPips;
  late final String? positionSize;
  late final String? entryPrice;
  late final String? lotSize;
  late final String position;
  late final String? counter;
  late final String? base;

  MatexForexStopLossTakeProfitCalculatorDocument({
    String? positionSizeFieldType,
    String? takeProfitFieldType,
    String? stopLossFieldType,
    String? pipDecimalPlaces,
    String? takeProfitAmount,
    String? accountCurrency,
    String? takeProfitPrice,
    String? stopLossAmount,
    String? takeProfitPips,
    String? stopLossPrice,
    String? stopLossPips,
    String? positionSize,
    String? entryPrice,
    String? position,
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
    this.positionSizeFieldType =
        positionSizeFieldType ?? defaultPositionSizeFieldType;
    this.takeProfitFieldType =
        takeProfitFieldType ?? defaultTakeProfitFieldType;
    this.pipDecimalPlaces =
        assignValue(pipDecimalPlaces) ?? kDefaultPipPipDecimalPlaces.toString();
  }

  @override
  MatexForexStopLossTakeProfitCalculatorDocument clone() => copyWith();

  @override
  MatexForexStopLossTakeProfitCalculatorDocument copyWith({
    String? positionSizeFieldType,
    String? takeProfitFieldType,
    String? stopLossFieldType,
    String? pipDecimalPlaces,
    String? takeProfitAmount,
    String? accountCurrency,
    String? takeProfitPrice,
    String? stopLossAmount,
    String? takeProfitPips,
    String? stopLossPrice,
    String? stopLossPips,
    String? positionSize,
    String? entryPrice,
    String? position,
    String? lotSize,
    String? counter,
    String? base,
  }) {
    return MatexForexStopLossTakeProfitCalculatorDocument(
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
      counter: counter ?? this.counter,
      lotSize: lotSize ?? this.lotSize,
      base: base ?? this.base,
      positionSizeFieldType:
          positionSizeFieldType ?? this.positionSizeFieldType,
    );
  }

  @override
  MatexForexStopLossTakeProfitCalculatorDocument copyWithDefaults({
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
    return MatexForexStopLossTakeProfitCalculatorDocument(
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
      positionSizeFieldType:
          resetPositionSizeFieldType ? null : positionSizeFieldType,
      takeProfitFieldType:
          resettakeProfitFieldType ? null : takeProfitFieldType,
    );
  }

  @override
  MatexForexStopLossTakeProfitCalculatorDocument merge(
    covariant MatexForexStopLossTakeProfitCalculatorDocument model,
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
      counter: model.counter,
      lotSize: model.lotSize,
      base: model.base,
    );
  }

  @override
  MatexForexStopLossTakeProfitCalculatorBlocFields toFields() {
    return MatexForexStopLossTakeProfitCalculatorBlocFields(
      position: MatexPositionX.fromName(position),
      takeProfitFieldType: takeProfitFieldType,
      stopLossFieldType: stopLossFieldType,
      takeProfitAmount: takeProfitAmount,
      pipDecimalPlaces: pipDecimalPlaces,
      takeProfitPrice: takeProfitPrice,
      accountCurrency: accountCurrency,
      takeProfitPips: takeProfitPips,
      stopLossAmount: stopLossAmount,
      stopLossPrice: stopLossPrice,
      stopLossPips: stopLossPips,
      positionSize: positionSize,
      entryPrice: entryPrice,
      counter: counter,
      lotSize: lotSize,
      base: base,
      positionSizeFieldType:
          MatexPositionSizeTypeX.fromName(positionSizeFieldType),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'positionSizeFieldType': positionSizeFieldType,
      'takeProfitFieldType': takeProfitFieldType,
      'stopLossFieldType': stopLossFieldType,
      'takeProfitAmount': takeProfitAmount,
      'pipDecimalPlaces': pipDecimalPlaces,
      'takeProfitPrice': takeProfitPrice,
      'accountCurrency': accountCurrency,
      'stopLossAmount': stopLossAmount,
      'takeProfitPips': takeProfitPips,
      'stopLossPrice': stopLossPrice,
      'stopLossPips': stopLossPips,
      'positionSize': positionSize,
      'entryPrice': entryPrice,
      'position': position,
      'lotSize': lotSize,
      'counter': counter,
      'base': base,
      ...super.toJson(),
    };
  }

  static MatexForexStopLossTakeProfitCalculatorDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexForexStopLossTakeProfitCalculatorDocument(
      positionSizeFieldType: json['positionSizeFieldType'] as String?,
      takeProfitFieldType: json['takeProfitFieldType'] as String?,
      stopLossFieldType: json['stopLossFieldType'] as String?,
      pipDecimalPlaces: json['pipDecimalPlaces'] as String?,
      takeProfitAmount: json['takeProfitAmount'] as String?,
      takeProfitPrice: json['takeProfitPrice'] as String?,
      accountCurrency: json['accountCurrency'] as String?,
      stopLossAmount: json['stopLossAmount'] as String?,
      takeProfitPips: json['takeProfitPips'] as String?,
      stopLossPrice: json['stopLossPrice'] as String?,
      positionSize: json['positionSize'] as String?,
      stopLossPips: json['stopLossPips'] as String?,
      entryPrice: json['entryPrice'] as String?,
      position: json['position'] as String?,
      lotSize: json['lotSize'] as String?,
      counter: json['counter'] as String?,
      base: json['base'] as String?,
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
