// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexFibonacciLevelsCalculatorDataProvider
    extends FastCalculatorDataProvider<MatexFibonacciLevelsCalculatorDocument> {
  static const defaultStoreName = 'matexFibonacciLevelsCalculator';

  MatexFibonacciLevelsCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? defaultStoreName);

  @override
  Future<MatexFibonacciLevelsCalculatorDocument>
      retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexFibonacciLevelsCalculatorDocument.fromJson(json);
    }

    return MatexFibonacciLevelsCalculatorDocument();
  }
}
