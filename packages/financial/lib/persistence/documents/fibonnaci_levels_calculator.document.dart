import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexFibonnaciLevelsCalculatorDocument extends FastCalculatorDocument {
  static final String defaultTrend = MatexTrend.up.name;

  late final String? highPrice;
  late final String? lowPrice;
  late final String trend;

  MatexFibonnaciLevelsCalculatorDocument({
    String? highPrice,
    String? lowPrice,
    String? trend,
  }) {
    this.highPrice = assignValue(highPrice);
    this.lowPrice = assignValue(lowPrice);
    this.trend = assignValue(trend) ?? defaultTrend;
  }

  @override
  MatexFibonnaciLevelsCalculatorDocument clone() => copyWith();

  factory MatexFibonnaciLevelsCalculatorDocument.fromJson(
      Map<String, dynamic> json) {
    return MatexFibonnaciLevelsCalculatorDocument(
      highPrice: json['highPrice'] as String?,
      lowPrice: json['lowPrice'] as String?,
      trend: json['trend'] as String? ?? defaultTrend,
    );
  }

  @override
  MatexFibonnaciLevelsCalculatorDocument copyWith({
    String? highPrice,
    String? lowPrice,
    String? trend,
  }) {
    return MatexFibonnaciLevelsCalculatorDocument(
      highPrice: highPrice ?? this.highPrice,
      lowPrice: lowPrice ?? this.lowPrice,
      trend: trend ?? this.trend,
    );
  }

  @override
  MatexFibonnaciLevelsCalculatorDocument merge(
    covariant MatexFibonnaciLevelsCalculatorDocument model,
  ) {
    return copyWith(
      highPrice: model.highPrice,
      lowPrice: model.lowPrice,
      trend: model.trend,
    );
  }

  // [toFields Method]
  @override
  MatexFibonnaciLevelsCalculatorBlocFields toFields() {
    return MatexFibonnaciLevelsCalculatorBlocFields(
      highPrice: highPrice,
      lowPrice: lowPrice,
      trend: trend,
    );
  }

// [Copy With Defaults Method]
  @override
  MatexFibonnaciLevelsCalculatorDocument copyWithDefaults({
    bool resetHighPrice = false,
    bool resetLowPrice = false,
    bool resetTrend = false,
  }) {
    return MatexFibonnaciLevelsCalculatorDocument(
      highPrice: resetHighPrice ? null : highPrice,
      lowPrice: resetLowPrice ? null : lowPrice,
      trend: resetTrend ? null : trend,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'highPrice': highPrice,
      'lowPrice': lowPrice,
      'trend': trend,
      ...super.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        highPrice,
        lowPrice,
        trend,
      ];
}
