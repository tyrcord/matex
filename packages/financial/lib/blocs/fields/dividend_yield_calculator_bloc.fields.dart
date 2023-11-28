import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexDividendYieldCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  static const defaultFrequency = MatexFinancialFrequency.annually;

  late final String? sharePrice;
  late final String? totalDividends;
  late final MatexFinancialFrequency paymentFrequency;

  String get formattedSharePrice {
    final value = parseFieldValueToDouble(sharePrice);

    return localizeCurrency(value: value);
  }

  String get formattedTotalDividend {
    final value = parseFieldValueToDouble(totalDividends);

    return localizeNumber(value: value);
  }

  MatexDividendYieldCalculatorBlocFields({
    String? sharePrice,
    String? totalDividends,
    MatexFinancialFrequency? paymentFrequency,
    FastCalculatorBlocDelegate? delegate,
  }) {
    this.sharePrice = assignValue(sharePrice);
    this.totalDividends = assignValue(totalDividends);
    this.paymentFrequency = paymentFrequency ?? defaultFrequency;
    this.delegate = delegate;
  }

  @override
  MatexDividendYieldCalculatorBlocFields clone() => copyWith();

  @override
  MatexDividendYieldCalculatorBlocFields copyWith({
    String? sharePrice,
    String? totalDividends,
    MatexFinancialFrequency? paymentFrequency,
    FastCalculatorBlocDelegate? delegate,
  }) {
    return MatexDividendYieldCalculatorBlocFields(
      sharePrice: sharePrice ?? this.sharePrice,
      totalDividends: totalDividends ?? this.totalDividends,
      paymentFrequency: paymentFrequency ?? this.paymentFrequency,
      delegate: delegate ?? this.delegate,
    );
  }

  @override
  MatexDividendYieldCalculatorBlocFields copyWithDefaults({
    bool resetSharePrice = false,
    bool resetTotalDividend = false,
    bool resetPaymentFrequency = false,
  }) {
    return MatexDividendYieldCalculatorBlocFields(
      sharePrice: resetSharePrice ? null : sharePrice,
      totalDividends: resetTotalDividend ? null : totalDividends,
      paymentFrequency:
          resetPaymentFrequency ? defaultFrequency : paymentFrequency,
      delegate: delegate,
    );
  }

  @override
  MatexDividendYieldCalculatorBlocFields merge(
    covariant MatexDividendYieldCalculatorBlocFields model,
  ) {
    return copyWith(
      paymentFrequency: model.paymentFrequency,
      totalDividends: model.totalDividends,
      sharePrice: model.sharePrice,
      delegate: model.delegate,
    );
  }

  @override
  List<Object?> get props => [
        sharePrice,
        totalDividends,
        paymentFrequency,
        delegate,
      ];
}
