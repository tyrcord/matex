// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexPivotPointsCalculatorDataProvider
    extends FastCalculatorDataProvider<MatexPivotPointsCalculatorDocument> {
  static const defaultStoreName = 'matexPivotPointsCalculator';

  MatexPivotPointsCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? defaultStoreName);

  @override
  Future<MatexPivotPointsCalculatorDocument>
      retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexPivotPointsCalculatorDocument.fromJson(json);
    }

    return MatexPivotPointsCalculatorDocument();
  }
}
