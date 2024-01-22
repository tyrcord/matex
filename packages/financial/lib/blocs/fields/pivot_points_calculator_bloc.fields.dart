// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexPivotPointsCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  static const defaultMethod = MatexPivotPointsMethods.standard;

  late final MatexPivotPointsMethods method;
  late final String? closePrice;
  late final String? highPrice;
  late final String? openPrice;
  late final String? lowPrice;

  String get formattedLowPrice {
    final value = parseStringToDouble(lowPrice);

    return localizeNumber(
      maximumFractionDigits: kMatexQuoteMaxFractionDigits,
      value: value,
    );
  }

  String get formattedHighPrice {
    final value = parseStringToDouble(highPrice);

    return localizeNumber(
      maximumFractionDigits: kMatexQuoteMaxFractionDigits,
      value: value,
    );
  }

  String get formattedClosePrice {
    final value = parseStringToDouble(closePrice);

    return localizeNumber(
      maximumFractionDigits: kMatexQuoteMaxFractionDigits,
      value: value,
    );
  }

  String get formattedOpenPrice {
    final value = parseStringToDouble(openPrice);

    return localizeNumber(
      maximumFractionDigits: kMatexQuoteMaxFractionDigits,
      value: value,
    );
  }

  String get formattedMethod => method.localizedName;

  MatexPivotPointsCalculatorBlocFields({
    FastCalculatorBlocDelegate? delegate,
    MatexPivotPointsMethods? method,
    String? closePrice,
    String? highPrice,
    String? openPrice,
    String? lowPrice,
  }) {
    this.closePrice = assignValue(closePrice);
    this.highPrice = assignValue(highPrice);
    this.openPrice = assignValue(openPrice);
    this.lowPrice = assignValue(lowPrice);
    this.method = method ?? defaultMethod;
    this.delegate = delegate;
  }

  @override
  MatexPivotPointsCalculatorBlocFields clone() => copyWith();

  @override
  MatexPivotPointsCalculatorBlocFields copyWith({
    FastCalculatorBlocDelegate? delegate,
    MatexPivotPointsMethods? method,
    String? closePrice,
    String? highPrice,
    String? openPrice,
    String? lowPrice,
  }) {
    return MatexPivotPointsCalculatorBlocFields(
      closePrice: closePrice ?? this.closePrice,
      openPrice: openPrice ?? this.openPrice,
      highPrice: highPrice ?? this.highPrice,
      lowPrice: lowPrice ?? this.lowPrice,
      delegate: delegate ?? this.delegate,
      method: method ?? this.method,
    );
  }

  @override
  MatexPivotPointsCalculatorBlocFields copyWithDefaults({
    bool resetClosePrice = false,
    bool resetHighPrice = false,
    bool resetOpenPrice = false,
    bool resetLowPrice = false,
    bool resetMethod = false,
  }) {
    return MatexPivotPointsCalculatorBlocFields(
      closePrice: resetClosePrice ? null : closePrice,
      highPrice: resetHighPrice ? null : highPrice,
      openPrice: resetOpenPrice ? null : openPrice,
      lowPrice: resetLowPrice ? null : lowPrice,
      method: resetMethod ? null : method,
      delegate: delegate,
    );
  }

  @override
  MatexPivotPointsCalculatorBlocFields merge(
    covariant MatexPivotPointsCalculatorBlocFields model,
  ) {
    return copyWith(
      closePrice: model.closePrice,
      highPrice: model.highPrice,
      openPrice: model.openPrice,
      lowPrice: model.lowPrice,
      delegate: model.delegate,
      method: model.method,
    );
  }

  @override
  List<Object?> get props => [
        closePrice,
        highPrice,
        openPrice,
        lowPrice,
        method,
      ];
}
