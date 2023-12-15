// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexPositionSizeCalculatorDataProvider
    extends FastCalculatorDataProvider<
        MatexForexPositionSizeCalculatorDocument> {
  static const defaultStoreName = 'matexForexPositionSizeCalculator';

  MatexForexPositionSizeCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? defaultStoreName);

  @override
  Future<MatexForexPositionSizeCalculatorDocument>
      retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexForexPositionSizeCalculatorDocument.fromJson(json);
    }

    return MatexForexPositionSizeCalculatorDocument();
  }
}
