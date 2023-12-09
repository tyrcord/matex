// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexFibonnaciLevelsCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  static final String defaultTrend = MatexTrend.up.name;

  late final String? highPrice;
  late final String? lowPrice;
  late final String trend;

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

  String get formattedTrend {
    final value = MatexTrendX.fromName(trend);

    return value.localizedName;
  }

  MatexFibonnaciLevelsCalculatorBlocFields({
    String? highPrice,
    String? lowPrice,
    String? trend,
    FastCalculatorBlocDelegate? delegate,
  }) {
    this.highPrice = assignValue(highPrice);
    this.lowPrice = assignValue(lowPrice);
    this.trend = assignValue(trend) ?? defaultTrend;
    this.delegate = delegate;
  }

  @override
  MatexFibonnaciLevelsCalculatorBlocFields clone() => copyWith();

  @override
  MatexFibonnaciLevelsCalculatorBlocFields copyWith({
    String? highPrice,
    String? lowPrice,
    String? trend,
  }) {
    return MatexFibonnaciLevelsCalculatorBlocFields(
      highPrice: highPrice ?? this.highPrice,
      lowPrice: lowPrice ?? this.lowPrice,
      trend: trend ?? this.trend,
      delegate: delegate,
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
      trend: model.trend,
    );
  }

  @override
  List<Object?> get props => [
        highPrice,
        lowPrice,
        trend,
      ];
}
