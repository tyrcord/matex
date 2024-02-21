// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_core/core.dart';

class MatexDividendPayoutRatioCalculatorBlocFields extends FastCalculatorFields
    with MatexCalculatorFormatterMixin {
  late final String? totalDividends;
  late final String? netIncome;

  String get formattedNetIncome {
    final value = parseStringToDouble(netIncome);

    return localizeCurrency(value: value);
  }

  String get formattedTotalDividends {
    final value = parseStringToDouble(totalDividends);

    return localizeNumber(value: value);
  }

  MatexDividendPayoutRatioCalculatorBlocFields({
    FastCalculatorBlocDelegate? delegate,
    String? totalDividends,
    String? netIncome,
  }) {
    this.totalDividends = assignValue(totalDividends);
    this.netIncome = assignValue(netIncome);
    this.delegate = delegate;
  }

  @override
  MatexDividendPayoutRatioCalculatorBlocFields clone() => copyWith();

  @override
  MatexDividendPayoutRatioCalculatorBlocFields copyWith({
    FastCalculatorBlocDelegate? delegate,
    String? totalDividends,
    String? netIncome,
  }) {
    return MatexDividendPayoutRatioCalculatorBlocFields(
      totalDividends: totalDividends ?? this.totalDividends,
      netIncome: netIncome ?? this.netIncome,
      delegate: delegate ?? this.delegate,
    );
  }

  @override
  MatexDividendPayoutRatioCalculatorBlocFields copyWithDefaults({
    bool resetTotalDividends = false,
    bool resetNetIncome = false,
  }) {
    return MatexDividendPayoutRatioCalculatorBlocFields(
      totalDividends: resetTotalDividends ? null : totalDividends,
      netIncome: resetNetIncome ? null : netIncome,
      delegate: delegate,
    );
  }

  @override
  MatexDividendPayoutRatioCalculatorBlocFields merge(
    covariant MatexDividendPayoutRatioCalculatorBlocFields model,
  ) {
    return copyWith(
      totalDividends: model.totalDividends,
      netIncome: model.netIncome,
      delegate: model.delegate,
    );
  }

  @override
  List<Object?> get props => [totalDividends, netIncome];

  @override
  Map<String, dynamic> toJson() {
    return {
      'totalDividends': totalDividends,
      'netIncome': netIncome,
    };
  }
}
