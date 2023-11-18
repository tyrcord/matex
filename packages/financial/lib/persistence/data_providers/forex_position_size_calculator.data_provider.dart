// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

const _kStoreName = 'matexForexPositionSizeCalculator';

class MatexForexPositionSizeCalculatorDataProvider
    extends FastCalculatorDataProvider<
        MatexForexPositionSizeCalculatorDocument> {
  MatexForexPositionSizeCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? _kStoreName);

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
