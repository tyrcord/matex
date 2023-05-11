import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';

const _kStoreName = 'matexVatCalculatorDataProvider';

class MatexVatCalculatorDataProvider
    extends FastCalculatorDataProvider<MatexVatCalculatorBlocDocument> {
  MatexVatCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? _kStoreName);

  @override
  Future<MatexVatCalculatorBlocDocument> retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexVatCalculatorBlocDocument.fromJson(json);
    }

    return const MatexVatCalculatorBlocDocument();
  }
}
