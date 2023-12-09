// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

const _kStoreName = 'matexForexProfitLossCalculator';

class MatexForexProfitLossCalculatorDataProvider
    extends FastCalculatorDataProvider<MatexForexProfitLossCalculatorDocument> {
  MatexForexProfitLossCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? _kStoreName);

  @override
  Future<MatexForexProfitLossCalculatorDocument>
      retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexForexProfitLossCalculatorDocument.fromJson(json);
    }

    return MatexForexProfitLossCalculatorDocument();
  }
}
