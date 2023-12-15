// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexDividendPayoutRatioCalculatorDataProvider
    extends FastCalculatorDataProvider<
        MatexDividendPayoutRatioCalculatorDocument> {
  static const defaultStoreName = 'matexDividendPayoutRatioCalculator';

  MatexDividendPayoutRatioCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? defaultStoreName);

  @override
  Future<MatexDividendPayoutRatioCalculatorDocument>
      retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexDividendPayoutRatioCalculatorDocument.fromJson(json);
    }

    return MatexDividendPayoutRatioCalculatorDocument();
  }
}
