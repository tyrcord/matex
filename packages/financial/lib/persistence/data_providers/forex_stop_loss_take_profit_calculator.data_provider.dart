// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexStopLossTakeProfitCalculatorDataProvider
    extends FastCalculatorDataProvider<
        MatexForexStopLossTakeProfitCalculatorDocument> {
  static const defaultStoreName = 'matexForexStopLossTakeProfitCalculator';

  MatexForexStopLossTakeProfitCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? defaultStoreName);

  @override
  Future<MatexForexStopLossTakeProfitCalculatorDocument>
      retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexForexStopLossTakeProfitCalculatorDocument.fromJson(json);
    }

    return MatexForexStopLossTakeProfitCalculatorDocument();
  }
}
