// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexFibonnaciLevelsCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  static const MatexTrend defaultTrend = MatexTrend.up;

  late final String? highPrice;
  late final String? lowPrice;
  late final MatexTrend trend;

  String get formattedLowPrice {
    final value = parseFieldValueToDouble(lowPrice);

    return localizeNumber(
      maximumFractionDigits: kMatexQuoteMaxFractionDigits,
      value: value,
    );
  }

  String get formattedHighPrice {
    final value = parseFieldValueToDouble(highPrice);

    return localizeNumber(
      maximumFractionDigits: kMatexQuoteMaxFractionDigits,
      value: value,
    );
  }

  String get formattedTrend => trend.localizedName;

  MatexFibonnaciLevelsCalculatorBlocFields({
    FastCalculatorBlocDelegate? delegate,
    MatexTrend? trend,
    String? highPrice,
    String? lowPrice,
  }) {
    this.highPrice = assignValue(highPrice);
    this.lowPrice = assignValue(lowPrice);
    this.trend = trend ?? defaultTrend;
    this.delegate = delegate;
  }

  @override
  MatexFibonnaciLevelsCalculatorBlocFields clone() => copyWith();

  @override
  MatexFibonnaciLevelsCalculatorBlocFields copyWith({
    FastCalculatorBlocDelegate? delegate,
    MatexTrend? trend,
    String? highPrice,
    String? lowPrice,
  }) {
    return MatexFibonnaciLevelsCalculatorBlocFields(
      highPrice: highPrice ?? this.highPrice,
      lowPrice: lowPrice ?? this.lowPrice,
      delegate: delegate ?? this.delegate,
      trend: trend ?? this.trend,
    );
  }

  // [Copy With Defaults Method]
  @override
  MatexFibonnaciLevelsCalculatorBlocFields copyWithDefaults({
    bool resetHighPrice = false,
    bool resetLowPrice = false,
    bool resetMethod = false,
  }) {
    return MatexFibonnaciLevelsCalculatorBlocFields(
      highPrice: resetHighPrice ? null : highPrice,
      lowPrice: resetLowPrice ? null : lowPrice,
      trend: resetMethod ? null : trend,
      delegate: delegate,
    );
  }

  @override
  MatexFibonnaciLevelsCalculatorBlocFields merge(
    covariant MatexFibonnaciLevelsCalculatorBlocFields model,
  ) {
    return copyWith(
      highPrice: model.highPrice,
      lowPrice: model.lowPrice,
      delegate: model.delegate,
      trend: model.trend,
    );
  }

  @override
  List<Object?> get props => [highPrice, lowPrice, trend];
}
