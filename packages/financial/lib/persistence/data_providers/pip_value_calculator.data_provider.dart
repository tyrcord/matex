// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

const _kStoreName = 'matexPipValueCalculator';

class MatexPipValueCalculatorDataProvider
    extends FastCalculatorDataProvider<MatexPipValueCalculatorDocument> {
  MatexPipValueCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? _kStoreName);

  @override
  Future<MatexPipValueCalculatorDocument> retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexPipValueCalculatorDocument.fromJson(json);
    }

    return MatexPipValueCalculatorDocument();
  }
}
