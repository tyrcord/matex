// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexDividendYieldCalculatorState extends MatexCalculatorState {
  static const defaultFrequency = MatexFinancialFrequency.annually;

  final MatexFinancialFrequency paymentFrequency;
  final double? dividendAmount;
  final double? sharePrice;

  const MatexDividendYieldCalculatorState({
    MatexFinancialFrequency? paymentFrequency,
    this.dividendAmount,
    this.sharePrice,
  }) : paymentFrequency = paymentFrequency ?? defaultFrequency;

  @override
  MatexDividendYieldCalculatorState clone() => copyWith();

  @override
  MatexDividendYieldCalculatorState copyWith({
    double? sharePrice,
    double? dividendAmount,
    MatexFinancialFrequency? paymentFrequency,
  }) {
    return MatexDividendYieldCalculatorState(
      paymentFrequency: paymentFrequency ?? this.paymentFrequency,
      dividendAmount: dividendAmount ?? this.dividendAmount,
      sharePrice: sharePrice ?? this.sharePrice,
    );
  }

  @override
  MatexDividendYieldCalculatorState copyWithDefaults({
    bool resetPaymentFrequency = false,
    bool resetDividendAmount = false,
    bool resetSharePrice = false,
  }) {
    return MatexDividendYieldCalculatorState(
      sharePrice: resetSharePrice ? null : sharePrice,
      dividendAmount: resetDividendAmount ? null : dividendAmount,
      paymentFrequency:
          resetPaymentFrequency ? defaultFrequency : paymentFrequency,
    );
  }

  @override
  MatexDividendYieldCalculatorState merge(
    covariant MatexDividendYieldCalculatorState model,
  ) {
    return copyWith(
      paymentFrequency: model.paymentFrequency,
      dividendAmount: model.dividendAmount,
      sharePrice: model.sharePrice,
    );
  }

  @override
  List<Object?> get props => [
        paymentFrequency,
        dividendAmount,
        sharePrice,
      ];
}
