// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexRequiredMarginCalculatorDataProvider
    extends FastCalculatorDataProvider<
        MatexForexRequiredMarginCalculatorDocument> {
  static const defaultStoreName = 'matexForexRequiredMarginCalculator';

  MatexForexRequiredMarginCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? defaultStoreName);

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
