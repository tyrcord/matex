// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

const _kStoreName = 'matexDividendPayoutRatioCalculatorDataProvider';

class MatexDividendPayoutRatioCalculatorDataProvider
    extends FastCalculatorDataProvider<
        MatexDividendPayoutRatioCalculatorDocument> {
  MatexDividendPayoutRatioCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? _kStoreName);

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
