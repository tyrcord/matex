// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

const _kStoreName = 'matexForexRequiredMarginCalculator';

class MatexForexRequiredMarginCalculatorDataProvider
    extends FastCalculatorDataProvider<
        MatexForexRequiredMarginCalculatorDocument> {
  MatexForexRequiredMarginCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? _kStoreName);

  @override
  Future<MatexForexRequiredMarginCalculatorDocument>
      retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexForexRequiredMarginCalculatorDocument.fromJson(json);
    }

    return MatexForexRequiredMarginCalculatorDocument();
  }
}
