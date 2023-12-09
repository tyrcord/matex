// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

const _kStoreName = 'matexPivotPointsCalculator';

class MatexPivotPointsCalculatorDataProvider
    extends FastCalculatorDataProvider<MatexPivotPointsCalculatorDocument> {
  MatexPivotPointsCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? _kStoreName);

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
