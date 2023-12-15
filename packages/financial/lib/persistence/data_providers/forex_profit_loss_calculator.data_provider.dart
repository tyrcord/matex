// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexProfitLossCalculatorDataProvider
    extends FastCalculatorDataProvider<MatexForexProfitLossCalculatorDocument> {
  static const defaultStoreName = 'matexForexProfitLossCalculator';

  MatexForexProfitLossCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? defaultStoreName);

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
