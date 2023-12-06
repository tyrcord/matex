// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

const _kStoreName = 'matexFibonnaciLevelsCalculator';

class MatexFibonnaciLevelsCalculatorDataProvider
    extends FastCalculatorDataProvider<MatexFibonnaciLevelsCalculatorDocument> {
  MatexFibonnaciLevelsCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? _kStoreName);

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
