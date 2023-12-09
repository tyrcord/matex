import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexPivotPointsCalculatorDocument extends FastCalculatorDocument {
  static final String defaultMethod = MatexPivotPointsMethods.standard.name;

  late final String? highPrice;
  late final String? lowPrice;
  late final String? closePrice;
  late final String? openPrice;
  late final String method;

  MatexPivotPointsCalculatorDocument({
    String? highPrice,
    String? lowPrice,
    String? closePrice,
    String? openPrice,
    String? method,
  }) {
    this.highPrice = assignValue(highPrice);
    this.lowPrice = assignValue(lowPrice);
    this.closePrice = assignValue(closePrice);
    this.openPrice = assignValue(openPrice);
    this.method = assignValue(method) ?? defaultMethod;
  }

  @override
  MatexPivotPointsCalculatorDocument clone() => copyWith();

  factory MatexPivotPointsCalculatorDocument.fromJson(
      Map<String, dynamic> json) {
    return MatexPivotPointsCalculatorDocument(
      highPrice: json['highPrice'] as String?,
      lowPrice: json['lowPrice'] as String?,
      closePrice: json['closePrice'] as String?,
      openPrice: json['openPrice'] as String?,
      method: json['method'] as String? ?? defaultMethod,
    );
  }

  @override
  MatexPivotPointsCalculatorDocument copyWith({
    String? highPrice,
    String? lowPrice,
    String? closePrice,
    String? openPrice,
    String? method,
  }) {
    return MatexPivotPointsCalculatorDocument(
      highPrice: highPrice ?? this.highPrice,
      lowPrice: lowPrice ?? this.lowPrice,
      closePrice: closePrice ?? this.closePrice,
      openPrice: openPrice ?? this.openPrice,
      method: method ?? this.method,
    );
  }

  @override
  MatexPivotPointsCalculatorDocument merge(
    covariant MatexPivotPointsCalculatorDocument model,
  ) {
    return copyWith(
      highPrice: model.highPrice,
      lowPrice: model.lowPrice,
      closePrice: model.closePrice,
      openPrice: model.openPrice,
      method: model.method,
    );
  }

  // [toFields Method]
  @override
  MatexPivotPointsCalculatorBlocFields toFields() {
    return MatexPivotPointsCalculatorBlocFields(
      method: MatexPivotPointsMethodsX.fromName(method),
      highPrice: highPrice,
      lowPrice: lowPrice,
      closePrice: closePrice,
      openPrice: openPrice,
    );
  }

  @override
  MatexPivotPointsCalculatorDocument copyWithDefaults({
    bool resetHighPrice = false,
    bool resetLowPrice = false,
    bool resetClosePrice = false,
    bool resetOpenPrice = false,
    bool resetMethod = false,
  }) {
    return MatexPivotPointsCalculatorDocument(
      highPrice: resetHighPrice ? null : highPrice,
      lowPrice: resetLowPrice ? null : lowPrice,
      closePrice: resetClosePrice ? null : closePrice,
      openPrice: resetOpenPrice ? null : openPrice,
      method: resetMethod ? null : method,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'highPrice': highPrice,
      'lowPrice': lowPrice,
      'closePrice': closePrice,
      'openPrice': openPrice,
      'method': method,
      ...super.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        highPrice,
        lowPrice,
        closePrice,
        openPrice,
        method,
      ];
}
