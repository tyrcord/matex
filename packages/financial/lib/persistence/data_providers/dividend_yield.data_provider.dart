import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

const _kStoreName = 'matexDividendYieldCalculator';

class MatexDividendYieldCalculatorDataProvider
    extends FastCalculatorDataProvider<MatexDividendYieldCalculatorDocument> {
  MatexDividendYieldCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? _kStoreName);

  @override
  Future<MatexDividendYieldCalculatorDocument>
      retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexDividendYieldCalculatorDocument.fromJson(json);
    }

    return MatexDividendYieldCalculatorDocument();
  }
}
