import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexPivotPointsCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  static const defaultMethod = MatexPivotPointsMethods.standard;

  late final String? highPrice;
  late final String? lowPrice;
  late final String? closePrice;
  late final String? openPrice;
  late final MatexPivotPointsMethods method;

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

  String get formattedClosePrice {
    final value = parseFieldValueToDouble(closePrice);

    return localizeNumber(
      maximumFractionDigits: kMatexQuoteMaxFractionDigits,
      value: value,
    );
  }

  String get formattedOpenPrice {
    final value = parseFieldValueToDouble(openPrice);

    return localizeNumber(
      maximumFractionDigits: kMatexQuoteMaxFractionDigits,
      value: value,
    );
  }

  String get formattedMethod => method.localizedName;

  MatexPivotPointsCalculatorBlocFields({
    String? highPrice,
    String? lowPrice,
    String? closePrice,
    String? openPrice,
    MatexPivotPointsMethods? method,
    FastCalculatorBlocDelegate? delegate,
  }) {
    this.highPrice = assignValue(highPrice);
    this.lowPrice = assignValue(lowPrice);
    this.closePrice = assignValue(closePrice);
    this.openPrice = assignValue(openPrice);
    this.method = method ?? defaultMethod;
    this.delegate = delegate;
  }

  @override
  MatexPivotPointsCalculatorBlocFields clone() => copyWith();

  @override
  MatexPivotPointsCalculatorBlocFields copyWith({
    String? highPrice,
    String? lowPrice,
    String? closePrice,
    String? openPrice,
    MatexPivotPointsMethods? method,
  }) {
    return MatexPivotPointsCalculatorBlocFields(
      highPrice: highPrice ?? this.highPrice,
      lowPrice: lowPrice ?? this.lowPrice,
      closePrice: closePrice ?? this.closePrice,
      openPrice: openPrice ?? this.openPrice,
      method: method ?? this.method,
      delegate: delegate,
    );
  }

  @override
  MatexPivotPointsCalculatorBlocFields copyWithDefaults({
    bool resetHighPrice = false,
    bool resetLowPrice = false,
    bool resetClosePrice = false,
    bool resetOpenPrice = false,
    bool resetMethod = false,
  }) {
    return MatexPivotPointsCalculatorBlocFields(
      highPrice: resetHighPrice ? null : highPrice,
      lowPrice: resetLowPrice ? null : lowPrice,
      closePrice: resetClosePrice ? null : closePrice,
      openPrice: resetOpenPrice ? null : openPrice,
      method: resetMethod ? defaultMethod : method,
      delegate: delegate,
    );
  }

  @override
  MatexPivotPointsCalculatorBlocFields merge(
    covariant MatexPivotPointsCalculatorBlocFields model,
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
