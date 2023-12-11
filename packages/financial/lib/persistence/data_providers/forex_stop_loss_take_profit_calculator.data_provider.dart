// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

const _kStoreName = 'matexForexStopLossTakeProfitCalculator';

class MatexForexStopLossTakeProfitCalculatorDataProvider
    extends FastCalculatorDataProvider<
        MatexForexStopLossTakeProfitCalculatorDocument> {
  MatexForexStopLossTakeProfitCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? _kStoreName);

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
