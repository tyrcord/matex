import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexDividendYieldCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  static const defaultFrequency = MatexFinancialFrequency.annually;

  late final String? sharePrice;
  late final String? totalDividend;
  late final MatexFinancialFrequency dividendPaymentFrequency;

  String get formattedSharePrice {
    final value = parseFieldValueToDouble(sharePrice);

    return localizeCurrency(value: value);
  }

  String get formattedTotalDividend {
    final value = parseFieldValueToDouble(totalDividend);

    return localizeNumber(value: value);
  }

  MatexDividendYieldCalculatorBlocFields({
    String? sharePrice,
    String? totalDividend,
    MatexFinancialFrequency? dividendPaymentFrequency,
    FastCalculatorBlocDelegate? delegate,
  }) {
    this.sharePrice = assignValue(sharePrice);
    this.totalDividend = assignValue(totalDividend);
    this.dividendPaymentFrequency =
        dividendPaymentFrequency ?? defaultFrequency;
    this.delegate = delegate;
  }

  @override
  MatexDividendYieldCalculatorBlocFields clone() => copyWith();

  @override
  MatexDividendYieldCalculatorBlocFields copyWith({
    String? sharePrice,
    String? totalDividend,
    MatexFinancialFrequency? dividendPaymentFrequency,
    FastCalculatorBlocDelegate? delegate,
  }) {
    return MatexDividendYieldCalculatorBlocFields(
      sharePrice: sharePrice ?? this.sharePrice,
      totalDividend: totalDividend ?? this.totalDividend,
      dividendPaymentFrequency:
          dividendPaymentFrequency ?? this.dividendPaymentFrequency,
      delegate: delegate ?? this.delegate,
    );
  }

  @override
  MatexDividendYieldCalculatorBlocFields copyWithDefaults({
    bool resetSharePrice = false,
    bool resetTotalDividend = false,
    bool resetDividendPaymentFrequency = false,
  }) {
    return MatexDividendYieldCalculatorBlocFields(
      sharePrice: resetSharePrice ? null : sharePrice,
      totalDividend: resetTotalDividend ? null : totalDividend,
      dividendPaymentFrequency: resetDividendPaymentFrequency
          ? defaultFrequency
          : dividendPaymentFrequency,
      delegate: delegate,
    );
  }

  @override
  MatexDividendYieldCalculatorBlocFields merge(
    covariant MatexDividendYieldCalculatorBlocFields model,
  ) {
    return copyWith(
      dividendPaymentFrequency: model.dividendPaymentFrequency,
      totalDividend: model.totalDividend,
      sharePrice: model.sharePrice,
      delegate: model.delegate,
    );
  }

  @override
  List<Object?> get props => [
        sharePrice,
        totalDividend,
        dividendPaymentFrequency,
        delegate,
      ];
}
