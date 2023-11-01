// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

const _kStoreName = 'matexProfitAndLossCalculator';

class MatexProfitAndLossCalculatorDataProvider
    extends FastCalculatorDataProvider<MatexProfitAndLossCalculatorDocument> {
  MatexProfitAndLossCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? _kStoreName);

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
