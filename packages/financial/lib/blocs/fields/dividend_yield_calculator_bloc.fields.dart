import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';
import 'package:matex_financial/financial.dart';

class MatexDividendYieldCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  static const defaultFrequency = MatexFinancialFrequency.annually;

  late final MatexFinancialFrequency paymentFrequency;
  late final String? dividendAmount;
  late final String? sharePrice;

  String get formattedSharePrice {
    final value = parseFieldValueToDouble(sharePrice);

    return localizeCurrency(value: value);
  }

  String get formattedDividendAmount {
    final value = parseFieldValueToDouble(dividendAmount);

    return localizeCurrency(value: value);
  }

  String get formattedPaymentFrequency => paymentFrequency.localizedName;

  MatexDividendYieldCalculatorBlocFields({
    MatexFinancialFrequency? paymentFrequency,
    FastCalculatorBlocDelegate? delegate,
    String? dividendAmount,
    String? sharePrice,
  }) {
    this.paymentFrequency = paymentFrequency ?? defaultFrequency;
    this.dividendAmount = assignValue(dividendAmount);
    this.sharePrice = assignValue(sharePrice);
    this.delegate = delegate;
  }

  @override
  MatexDividendYieldCalculatorBlocFields clone() => copyWith();

  @override
  MatexDividendYieldCalculatorBlocFields copyWith({
    MatexFinancialFrequency? paymentFrequency,
    FastCalculatorBlocDelegate? delegate,
    String? dividendAmount,
    String? sharePrice,
  }) {
    return MatexDividendYieldCalculatorBlocFields(
      paymentFrequency: paymentFrequency ?? this.paymentFrequency,
      dividendAmount: dividendAmount ?? this.dividendAmount,
      sharePrice: sharePrice ?? this.sharePrice,
      delegate: delegate ?? this.delegate,
    );
  }

  @override
  MatexDividendYieldCalculatorBlocFields copyWithDefaults({
    bool resetPaymentFrequency = false,
    bool resetDividendAmount = false,
    bool resetSharePrice = false,
  }) {
    return MatexDividendYieldCalculatorBlocFields(
      paymentFrequency: resetPaymentFrequency ? null : paymentFrequency,
      dividendAmount: resetDividendAmount ? null : dividendAmount,
      sharePrice: resetSharePrice ? null : sharePrice,
      delegate: delegate,
    );
  }

  @override
  MatexDividendYieldCalculatorBlocFields merge(
    covariant MatexDividendYieldCalculatorBlocFields model,
  ) {
    return copyWith(
      paymentFrequency: model.paymentFrequency,
      dividendAmount: model.dividendAmount,
      sharePrice: model.sharePrice,
      delegate: model.delegate,
    );
  }

  @override
  List<Object?> get props => [paymentFrequency, dividendAmount, sharePrice];
}
