// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

const _kStoreName = 'matexForexPipDeltaCalculator';

class MatexForexPipDeltaCalculatorDataProvider
    extends FastCalculatorDataProvider<MatexForexPipDeltaCalculatorDocument> {
  MatexForexPipDeltaCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? _kStoreName);

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
