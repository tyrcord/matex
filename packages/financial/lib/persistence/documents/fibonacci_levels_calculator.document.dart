import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexFibonacciLevelsCalculatorDocument extends FastCalculatorDocument {
  static final String defaultTrend = MatexTrend.up.name;

  late final String? highPrice;
  late final String? lowPrice;
  late final String trend;

  MatexFibonacciLevelsCalculatorDocument({
    String? highPrice,
    String? lowPrice,
    String? trend,
  }) {
    this.trend = assignValue(trend) ?? defaultTrend;
    this.highPrice = assignValue(highPrice);
    this.lowPrice = assignValue(lowPrice);
  }

  @override
  MatexFibonacciLevelsCalculatorDocument clone() => copyWith();

  factory MatexFibonacciLevelsCalculatorDocument.fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexFibonacciLevelsCalculatorDocument(
      highPrice: json['highPrice'] as String?,
      lowPrice: json['lowPrice'] as String?,
      trend: json['trend'] as String?,
    );
  }

  @override
  MatexFibonacciLevelsCalculatorDocument copyWith({
    String? highPrice,
    String? lowPrice,
    String? trend,
  }) {
    return MatexFibonacciLevelsCalculatorDocument(
      highPrice: highPrice ?? this.highPrice,
      lowPrice: lowPrice ?? this.lowPrice,
      trend: trend ?? this.trend,
    );
  }

  @override
  MatexFibonacciLevelsCalculatorDocument merge(
    covariant MatexFibonacciLevelsCalculatorDocument model,
  ) {
    return copyWith(
      highPrice: model.highPrice,
      lowPrice: model.lowPrice,
      trend: model.trend,
    );
  }

  @override
  MatexFibonacciLevelsCalculatorBlocFields toFields() {
    return MatexFibonacciLevelsCalculatorBlocFields(
      trend: MatexTrendX.fromName(trend),
      highPrice: highPrice,
      lowPrice: lowPrice,
    );
  }

  @override
  MatexFibonacciLevelsCalculatorDocument copyWithDefaults({
    bool resetHighPrice = false,
    bool resetLowPrice = false,
    bool resetMethod = false,
  }) {
    return MatexFibonacciLevelsCalculatorDocument(
      highPrice: resetHighPrice ? null : highPrice,
      lowPrice: resetLowPrice ? null : lowPrice,
      trend: resetMethod ? null : trend,
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
