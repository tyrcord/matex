// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexProfitAndLossCalculatorDataProvider
    extends FastCalculatorDataProvider<MatexProfitAndLossCalculatorDocument> {
  static const defaultStoreName = 'matexProfitAndLossCalculator';

  MatexProfitAndLossCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? defaultStoreName);

  @override
  Future<MatexProfitAndLossCalculatorDocument>
      retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexProfitAndLossCalculatorDocument.fromJson(json);
    }

    return MatexProfitAndLossCalculatorDocument();
  }
}
