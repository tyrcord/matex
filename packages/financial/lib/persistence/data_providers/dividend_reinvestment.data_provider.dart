import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

const _kStoreName = 'matexDividendReinvestmentCalculator';

class MatexDividendReinvestmentCalculatorDataProvider
    extends FastCalculatorDataProvider<
        MatexDividendReinvestmentCalculatorDocument> {
  MatexDividendReinvestmentCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? _kStoreName);

  @override
  Future<MatexDividendReinvestmentCalculatorDocument>
      retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexDividendReinvestmentCalculatorDocument.fromJson(json);
    }

    return MatexDividendReinvestmentCalculatorDocument();
  }
}
