// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexDividendPayoutRatioCalculatorDocument
    extends FastCalculatorDocument {
  late final String? totalDividends;
  late final String? netIncome;

  /// The version of the document.
  @override
  int get version => 1;

  MatexDividendPayoutRatioCalculatorDocument({
    String? totalDividends,
    String? netIncome,
  }) {
    this.totalDividends = assignValue(totalDividends);
    this.netIncome = assignValue(netIncome);
  }

  @override
  MatexDividendPayoutRatioCalculatorDocument clone() => copyWith();

  factory MatexDividendPayoutRatioCalculatorDocument.fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexDividendPayoutRatioCalculatorDocument(
      totalDividends: json['totalDividends'] as String?,
      netIncome: json['netIncome'] as String?,
    );
  }

  @override
  MatexDividendPayoutRatioCalculatorDocument copyWith({
    String? totalDividends,
    String? netIncome,
  }) {
    return MatexDividendPayoutRatioCalculatorDocument(
      totalDividends: totalDividends ?? this.totalDividends,
      netIncome: netIncome ?? this.netIncome,
    );
  }

  @override
  MatexDividendPayoutRatioCalculatorDocument copyWithDefaults({
    bool resetTotalDividends = false,
    bool resetNetIncome = false,
  }) {
    return MatexDividendPayoutRatioCalculatorDocument(
      totalDividends: resetTotalDividends ? null : totalDividends,
      netIncome: resetNetIncome ? null : netIncome,
    );
  }

  @override
  MatexDividendPayoutRatioCalculatorDocument merge(
    covariant MatexDividendPayoutRatioCalculatorDocument model,
  ) {
    return copyWith(
      totalDividends: model.totalDividends,
      netIncome: model.netIncome,
    );
  }

  @override
  List<Object?> get props => [netIncome, totalDividends];

  @override
  MatexDividendPayoutRatioCalculatorBlocFields toFields() {
    return MatexDividendPayoutRatioCalculatorBlocFields(
      totalDividends: totalDividends,
      netIncome: netIncome,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'totalDividends': totalDividends,
      'netIncome': netIncome,
      ...super.toJson(),
    };
  }
}
