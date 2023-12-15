// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexPipDeltaCalculatorDataProvider
    extends FastCalculatorDataProvider<MatexForexPipDeltaCalculatorDocument> {
  static const defaultStoreName = 'matexForexPipDeltaCalculator';

  MatexForexPipDeltaCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? defaultStoreName);

  @override
  Future<MatexForexPipDeltaCalculatorDocument>
      retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexForexPipDeltaCalculatorDocument.fromJson(json);
    }

    return MatexForexPipDeltaCalculatorDocument();
  }
}
