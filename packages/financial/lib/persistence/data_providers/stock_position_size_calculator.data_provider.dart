// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexStockPositionSizeCalculatorDataProvider
    extends FastCalculatorDataProvider<
        MatexStockPositionSizeCalculatorBlocDocument> {
  static const defaultStoreName =
      'matexStockPositionSizeCalculatorDataProvider';

  MatexStockPositionSizeCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? defaultStoreName);

  @override
  Future<MatexStockPositionSizeCalculatorBlocDocument>
      retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexStockPositionSizeCalculatorBlocDocument.fromJson(json);
    }

    return MatexStockPositionSizeCalculatorBlocDocument();
  }
}
