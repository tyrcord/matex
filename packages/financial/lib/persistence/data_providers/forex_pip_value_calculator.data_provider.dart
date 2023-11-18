// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

const _kStoreName = 'matexForexPipValueCalculator';

class MatexForexPipValueCalculatorDataProvider
    extends FastCalculatorDataProvider<MatexForexPipValueCalculatorDocument> {
  MatexForexPipValueCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? _kStoreName);

  @override
  Future<MatexForexPipValueCalculatorDocument>
      retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexForexPipValueCalculatorDocument.fromJson(json);
    }

    return MatexForexPipValueCalculatorDocument();
  }
}
