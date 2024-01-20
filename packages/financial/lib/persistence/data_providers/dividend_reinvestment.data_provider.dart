// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexDividendReinvestmentCalculatorDataProvider
    extends FastCalculatorDataProvider<
        MatexDividendReinvestmentCalculatorDocument> {
  static const defaultStoreName = 'matexDividendReinvestmentCalculator';

  MatexDividendReinvestmentCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? defaultStoreName);

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
