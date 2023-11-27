import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';

class MatexDividendPayoutRatioCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  late final String? netIncome;
  late final String? totalDividend;

  String get formattedNetIncome {
    final value = parseFieldValueToDouble(netIncome);

    return localizeCurrency(value: value);
  }

  String get formattedTotalDividend {
    final value = parseFieldValueToDouble(totalDividend);

    return localizeNumber(value: value);
  }

  MatexDividendPayoutRatioCalculatorBlocFields({
    String? netIncome,
    String? totalDividend,
    FastCalculatorBlocDelegate? delegate,
  }) {
    this.netIncome = assignValue(netIncome);
    this.totalDividend = assignValue(totalDividend);
    this.delegate = delegate;
  }

  @override
  MatexDividendPayoutRatioCalculatorBlocFields clone() => copyWith();

  @override
  MatexDividendPayoutRatioCalculatorBlocFields copyWith({
    String? netIncome,
    String? totalDividend,
    FastCalculatorBlocDelegate? delegate,
  }) {
    return MatexDividendPayoutRatioCalculatorBlocFields(
      netIncome: netIncome ?? this.netIncome,
      totalDividend: totalDividend ?? this.totalDividend,
      delegate: delegate,
    );
  }

  @override
  MatexDividendPayoutRatioCalculatorBlocFields copyWithDefaults({
    bool resetNetIncome = false,
    bool resetTotalDividend = false,
  }) {
    return MatexDividendPayoutRatioCalculatorBlocFields(
      netIncome: resetNetIncome ? null : netIncome,
      totalDividend: resetTotalDividend ? null : totalDividend,
      delegate: delegate,
    );
  }

  @override
  MatexDividendPayoutRatioCalculatorBlocFields merge(
    covariant MatexDividendPayoutRatioCalculatorBlocFields model,
  ) {
    return copyWith(
      netIncome: model.netIncome,
      totalDividend: model.totalDividend,
      delegate: model.delegate,
    );
  }

  @override
  List<Object?> get props => [
        netIncome,
        totalDividend,
        delegate,
      ];
}
