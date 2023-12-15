import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

class MatexDividendYieldCalculatorDataProvider
    extends FastCalculatorDataProvider<MatexDividendYieldCalculatorDocument> {
  static const defaultStoreName = 'matexDividendYieldCalculator';

  MatexDividendYieldCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? defaultStoreName);

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
