import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';

class MatexDividendPayoutRatioCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  late final String? netIncome;
  late final String? totalDividends;

  String get formattedNetIncome {
    final value = parseFieldValueToDouble(netIncome);

    return localizeCurrency(value: value);
  }

  String get formattedTotalDividends {
    final value = parseFieldValueToDouble(totalDividends);

    return localizeNumber(value: value);
  }

  MatexDividendPayoutRatioCalculatorBlocFields({
    String? netIncome,
    String? totalDividends,
    FastCalculatorBlocDelegate? delegate,
  }) {
    this.netIncome = assignValue(netIncome);
    this.totalDividends = assignValue(totalDividends);
    this.delegate = delegate;
  }

  @override
  MatexDividendPayoutRatioCalculatorBlocFields clone() => copyWith();

  @override
  MatexDividendPayoutRatioCalculatorBlocFields copyWith({
    String? netIncome,
    String? totalDividends,
    FastCalculatorBlocDelegate? delegate,
  }) {
    return MatexDividendPayoutRatioCalculatorBlocFields(
      netIncome: netIncome ?? this.netIncome,
      totalDividends: totalDividends ?? this.totalDividends,
      delegate: delegate,
    );
  }

  @override
  MatexDividendPayoutRatioCalculatorBlocFields copyWithDefaults({
    bool resetNetIncome = false,
    bool resetTotalDividends = false,
  }) {
    return MatexDividendPayoutRatioCalculatorBlocFields(
      netIncome: resetNetIncome ? null : netIncome,
      totalDividends: resetTotalDividends ? null : totalDividends,
      delegate: delegate,
    );
  }

  @override
  MatexDividendPayoutRatioCalculatorBlocFields merge(
    covariant MatexDividendPayoutRatioCalculatorBlocFields model,
  ) {
    return copyWith(
      netIncome: model.netIncome,
      totalDividends: model.totalDividends,
      delegate: model.delegate,
    );
  }

  @override
  List<Object?> get props => [
        netIncome,
        totalDividends,
        delegate,
      ];
}
