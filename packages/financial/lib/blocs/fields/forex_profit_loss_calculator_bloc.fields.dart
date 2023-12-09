// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexProfitLossCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  static const String defaultPositionSizeFieldType = 'unit';
  final defaultPosition = MatexPosition.long;

  late final String? accountCurrency;
  late final String? base;
  late final String? counter;
  late final String? positionSize;
  late final String? pipDecimalPlaces;
  late final String positionSizeFieldType;
  late final String? lotSize;
  late final String? entryPrice;
  late final String? exitPrice;
  late final MatexPosition? position;

  MatexForexProfitLossCalculatorBlocFields({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? entryPrice,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
    String? lotSize,
    String? exitPrice,
    MatexPosition? position,
  }) {
    this.accountCurrency = assignValue(accountCurrency);
    this.base = assignValue(base);
    this.counter = assignValue(counter);
    this.positionSize = assignValue(positionSize);
    this.entryPrice = assignValue(entryPrice);
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces);
    this.lotSize = assignValue(lotSize);
    this.exitPrice = assignValue(exitPrice);
    this.positionSizeFieldType =
        positionSizeFieldType ?? defaultPositionSizeFieldType;
    this.position = position ?? defaultPosition;
  }

  @override
  MatexForexProfitLossCalculatorBlocFields clone() => copyWith();

  @override
  MatexForexProfitLossCalculatorBlocFields copyWith({
    String? accountCurrency,
    String? base,
    String? counter,
    String? positionSize,
    String? entryPrice,
    String? pipDecimalPlaces,
    String? positionSizeFieldType,
    String? lotSize,
    String? exitPrice,
    MatexPosition? position,
  }) {
    return MatexForexProfitLossCalculatorBlocFields(
      accountCurrency: accountCurrency ?? this.accountCurrency,
      base: base ?? this.base,
      counter: counter ?? this.counter,
      positionSize: positionSize ?? this.positionSize,
      entryPrice: entryPrice ?? this.entryPrice,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      lotSize: lotSize ?? this.lotSize,
      positionSizeFieldType:
          positionSizeFieldType ?? this.positionSizeFieldType,
      exitPrice: exitPrice ?? this.exitPrice,
      position: position ?? this.position,
    );
  }

  @override
  MatexForexProfitLossCalculatorBlocFields copyWithDefaults({
    bool accountCurrency = false,
    bool base = false,
    bool counter = false,
    bool positionSize = false,
    bool entryPrice = false,
    bool pipDecimalPlaces = false,
    bool positionSizeFieldType = false,
    bool lotSize = false,
    bool resetExitPrice = false,
    bool resetPosition = false,
  }) {
    return MatexForexProfitLossCalculatorBlocFields(
      accountCurrency: accountCurrency ? null : this.accountCurrency,
      base: base ? null : this.base,
      counter: counter ? null : this.counter,
      positionSize: positionSize ? null : this.positionSize,
      entryPrice: entryPrice ? null : this.entryPrice,
      pipDecimalPlaces: pipDecimalPlaces ? null : this.pipDecimalPlaces,
      lotSize: lotSize ? null : this.lotSize,
      positionSizeFieldType:
          positionSizeFieldType ? null : this.positionSizeFieldType,
      exitPrice: resetExitPrice ? null : exitPrice,
      position: resetPosition ? null : position,
    );
  }

  @override
  MatexForexProfitLossCalculatorBlocFields merge(
    covariant MatexForexProfitLossCalculatorBlocFields model,
  ) {
    return copyWith(
      accountCurrency: model.accountCurrency,
      base: model.base,
      counter: model.counter,
      positionSize: model.positionSize,
      entryPrice: model.entryPrice,
      pipDecimalPlaces: model.pipDecimalPlaces,
      positionSizeFieldType: model.positionSizeFieldType,
      lotSize: model.lotSize,
      exitPrice: model.exitPrice,
      position: model.position,
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
        exitPrice,
        position,
      ];
}
