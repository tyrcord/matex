// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexPipValueCalculatorDataProvider
    extends FastCalculatorDataProvider<MatexForexPipValueCalculatorDocument> {
  static const defaultStoreName = 'matexForexPipValueCalculator';

  MatexForexPipValueCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? defaultStoreName);

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
