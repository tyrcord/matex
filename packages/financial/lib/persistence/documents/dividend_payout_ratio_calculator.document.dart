import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexDividendPayoutRatioCalculatorDocument
    extends FastCalculatorDocument {
  late final String? netIncome;
  late final String? totalDividend;

  MatexDividendPayoutRatioCalculatorDocument({
    String? netIncome,
    String? totalDividend,
  }) {
    this.netIncome = assignValue(netIncome);
    this.totalDividend = assignValue(totalDividend);
  }

  @override
  MatexDividendPayoutRatioCalculatorDocument clone() => copyWith();

  factory MatexDividendPayoutRatioCalculatorDocument.fromJson(
      Map<String, dynamic> json) {
    return MatexDividendPayoutRatioCalculatorDocument(
      netIncome: json['netIncome'] as String?,
      totalDividend: json['totalDividend'] as String?,
    );
  }

  @override
  MatexDividendPayoutRatioCalculatorDocument copyWith({
    String? netIncome,
    String? totalDividends,
  }) {
    return MatexDividendPayoutRatioCalculatorDocument(
      netIncome: netIncome ?? this.netIncome,
      totalDividend: totalDividends ?? this.totalDividend,
    );
  }

  @override
  MatexDividendPayoutRatioCalculatorDocument merge(
    covariant MatexDividendPayoutRatioCalculatorDocument model,
  ) {
    return copyWith(
      netIncome: model.netIncome,
      totalDividends: model.totalDividend,
    );
  }

  @override
  List<Object?> get props => [netIncome, totalDividend];

  // [toFields Method]
  @override
  MatexDividendPayoutRatioCalculatorBlocFields toFields() {
    return MatexDividendPayoutRatioCalculatorBlocFields(
      netIncome: netIncome,
      totalDividend: totalDividend,
    );
  }

// [Copy With Defaults Method]
  @override
  MatexDividendPayoutRatioCalculatorDocument copyWithDefaults({
    bool resetNetIncome = false,
    bool resetTotalDividend = false,
  }) {
    return MatexDividendPayoutRatioCalculatorDocument(
      netIncome: resetNetIncome ? null : netIncome,
      totalDividend: resetTotalDividend ? null : totalDividend,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'netIncome': netIncome,
      'totalDividend': totalDividend,
      ...super.toJson(),
    };
  }
}
