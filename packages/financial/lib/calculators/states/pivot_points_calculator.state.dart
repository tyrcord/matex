import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexPivotPointsCalculatorState extends MatexCalculatorState {
  static const defaultMethod = MatexPivotPointsMethods.standard;

  final double? highPrice;
  final double? lowPrice;
  final double? closePrice;
  final double? openPrice;
  final MatexPivotPointsMethods method;

  const MatexPivotPointsCalculatorState({
    this.highPrice,
    this.lowPrice,
    this.closePrice,
    this.openPrice,
    MatexPivotPointsMethods? method,
  }) : method = method ?? defaultMethod;

  @override
  MatexPivotPointsCalculatorState clone() => copyWith();

  @override
  MatexPivotPointsCalculatorState copyWith({
    double? highPrice,
    double? lowPrice,
    double? closePrice,
    double? openPrice,
    MatexPivotPointsMethods? method,
  }) {
    return MatexPivotPointsCalculatorState(
      highPrice: highPrice ?? this.highPrice,
      lowPrice: lowPrice ?? this.lowPrice,
      closePrice: closePrice ?? this.closePrice,
      openPrice: openPrice ?? this.openPrice,
      method: method ?? this.method,
    );
  }

  @override
  MatexPivotPointsCalculatorState copyWithDefaults({
    bool resetHighPrice = false,
    bool resetLowPrice = false,
    bool resetClosePrice = false,
    bool resetOpenPrice = false,
    bool resetMethod = false,
  }) {
    return MatexPivotPointsCalculatorState(
      highPrice: resetHighPrice ? null : highPrice,
      lowPrice: resetLowPrice ? null : lowPrice,
      closePrice: resetClosePrice ? null : closePrice,
      openPrice: resetOpenPrice ? null : openPrice,
      method: resetMethod ? defaultMethod : method,
    );
  }

  @override
  MatexPivotPointsCalculatorState merge(
    covariant MatexPivotPointsCalculatorState model,
  ) {
    return copyWith(
      highPrice: model.highPrice,
      lowPrice: model.lowPrice,
      closePrice: model.closePrice,
      openPrice: model.openPrice,
      method: model.method,
    );
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
