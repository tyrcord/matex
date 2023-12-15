// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexVatCalculatorDataProvider
    extends FastCalculatorDataProvider<MatexVatCalculatorBlocDocument> {
  static const defaultStoreName = 'matexVatCalculatorDataProvider';

  MatexVatCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? defaultStoreName);

  @override
  Future<MatexVatCalculatorBlocDocument> retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexVatCalculatorBlocDocument.fromJson(json);
    }

    return MatexVatCalculatorBlocDocument();
  }
}
