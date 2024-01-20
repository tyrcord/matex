// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexPivotPointsCalculatorDocument extends FastCalculatorDocument {
  late final String? closePrice;
  late final String? highPrice;
  late final String? openPrice;
  late final String? lowPrice;
  late final String? method;

  /// The version of the document.
  @override
  int get version => 1;

  MatexPivotPointsCalculatorDocument({
    String? closePrice,
    String? highPrice,
    String? openPrice,
    String? lowPrice,
    String? method,
  }) {
    this.closePrice = assignValue(closePrice);
    this.highPrice = assignValue(highPrice);
    this.openPrice = assignValue(openPrice);
    this.lowPrice = assignValue(lowPrice);
    this.method = assignValue(method);
  }

  @override
  MatexPivotPointsCalculatorDocument clone() => copyWith();

  factory MatexPivotPointsCalculatorDocument.fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexPivotPointsCalculatorDocument(
      closePrice: json['closePrice'] as String?,
      openPrice: json['openPrice'] as String?,
      highPrice: json['highPrice'] as String?,
      lowPrice: json['lowPrice'] as String?,
      method: json['method'] as String?,
    );
  }

  @override
  MatexPivotPointsCalculatorDocument copyWith({
    String? closePrice,
    String? highPrice,
    String? openPrice,
    String? lowPrice,
    String? method,
  }) {
    return MatexPivotPointsCalculatorDocument(
      closePrice: closePrice ?? this.closePrice,
      openPrice: openPrice ?? this.openPrice,
      highPrice: highPrice ?? this.highPrice,
      lowPrice: lowPrice ?? this.lowPrice,
      method: method ?? this.method,
    );
  }

  @override
  MatexPivotPointsCalculatorDocument copyWithDefaults({
    bool resetClosePrice = false,
    bool resetHighPrice = false,
    bool resetOpenPrice = false,
    bool resetLowPrice = false,
    bool resetMethod = false,
  }) {
    return MatexPivotPointsCalculatorDocument(
      closePrice: resetClosePrice ? null : closePrice,
      highPrice: resetHighPrice ? null : highPrice,
      openPrice: resetOpenPrice ? null : openPrice,
      lowPrice: resetLowPrice ? null : lowPrice,
      method: resetMethod ? null : method,
    );
  }

  @override
  MatexPivotPointsCalculatorDocument merge(
    covariant MatexPivotPointsCalculatorDocument model,
  ) {
    return copyWith(
      closePrice: model.closePrice,
      highPrice: model.highPrice,
      openPrice: model.openPrice,
      lowPrice: model.lowPrice,
      method: model.method,
    );
  }

  // [toFields Method]
  @override
  MatexPivotPointsCalculatorBlocFields toFields() {
    return MatexPivotPointsCalculatorBlocFields(
      method: MatexPivotPointsMethodsX.fromName(method),
      closePrice: closePrice,
      highPrice: highPrice,
      openPrice: openPrice,
      lowPrice: lowPrice,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'closePrice': closePrice,
      'highPrice': highPrice,
      'openPrice': openPrice,
      'lowPrice': lowPrice,
      'method': method,
      ...super.toJson(),
    };
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
