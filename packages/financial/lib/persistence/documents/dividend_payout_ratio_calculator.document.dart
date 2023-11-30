import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexDividendPayoutRatioCalculatorDocument
    extends FastCalculatorDocument {
  late final String? netIncome;
  late final String? totalDividends;

  /// The version of the document.
  @override
  int get version => 1;

  MatexDividendPayoutRatioCalculatorDocument({
    String? netIncome,
    String? totalDividends,
  }) {
    this.netIncome = assignValue(netIncome);
    this.totalDividends = assignValue(totalDividends);
  }

  @override
  MatexDividendPayoutRatioCalculatorDocument clone() => copyWith();

  factory MatexDividendPayoutRatioCalculatorDocument.fromJson(
      Map<String, dynamic> json) {
    return MatexDividendPayoutRatioCalculatorDocument(
      netIncome: json['netIncome'] as String?,
      totalDividends: json['totalDividends'] as String?,
    );
  }

  @override
  MatexDividendPayoutRatioCalculatorDocument copyWith({
    String? netIncome,
    String? totalDividends,
  }) {
    return MatexDividendPayoutRatioCalculatorDocument(
      netIncome: netIncome ?? this.netIncome,
      totalDividends: totalDividends ?? this.totalDividends,
    );
  }

  @override
  MatexDividendPayoutRatioCalculatorDocument merge(
    covariant MatexDividendPayoutRatioCalculatorDocument model,
  ) {
    return copyWith(
      netIncome: model.netIncome,
      totalDividends: model.totalDividends,
    );
  }

  @override
  List<Object?> get props => [netIncome, totalDividends];

  // [toFields Method]
  @override
  MatexDividendPayoutRatioCalculatorBlocFields toFields() {
    return MatexDividendPayoutRatioCalculatorBlocFields(
      netIncome: netIncome,
      totalDividends: totalDividends,
    );
  }

// [Copy With Defaults Method]
  @override
  MatexDividendPayoutRatioCalculatorDocument copyWithDefaults({
    bool resetNetIncome = false,
    bool resetTotalDividends = false,
  }) {
    return MatexDividendPayoutRatioCalculatorDocument(
      netIncome: resetNetIncome ? null : netIncome,
      totalDividends: resetTotalDividends ? null : totalDividends,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'netIncome': netIncome,
      'totalDividends': totalDividends,
      ...super.toJson(),
    };
  }
}
