// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexFibonnaciLevelsCalculatorDataProvider
    extends FastCalculatorDataProvider<MatexFibonnaciLevelsCalculatorDocument> {
  static const defaultStoreName = 'matexFibonnaciLevelsCalculator';

  MatexFibonnaciLevelsCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? defaultStoreName);

  @override
  Future<MatexFibonnaciLevelsCalculatorDocument>
      retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexFibonnaciLevelsCalculatorDocument.fromJson(json);
    }

    return MatexFibonnaciLevelsCalculatorDocument();
  }
}
