// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexForexCompoundCalculatorBlocDataProvider
    extends FastCalculatorDataProvider<
        MatexForexCompoundCalculatorBlocDocument> {
  static const defaultStoreName =
      'matexForexCompoundCalculatorBlocDataProvider';

  MatexForexCompoundCalculatorBlocDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? defaultStoreName);

  @override
  Future<MatexForexCompoundCalculatorBlocDocument>
      retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexForexCompoundCalculatorBlocDocument.fromJson(json);
    }

    return MatexForexCompoundCalculatorBlocDocument();
  }
}
