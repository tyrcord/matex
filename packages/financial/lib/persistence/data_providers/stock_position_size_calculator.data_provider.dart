// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

const _kStoreName = 'matexStockPositionSizeCalculatorDataProvider';

class MatexStockPositionSizeCalculatorDataProvider
    extends FastCalculatorDataProvider<
        MatexStockPositionSizeCalculatorBlocDocument> {
  MatexStockPositionSizeCalculatorDataProvider({
    String? storeName,
  }) : super(storeName: storeName ?? _kStoreName);

  @override
  Future<MatexStockPositionSizeCalculatorBlocDocument>
      retrieveCalculatorDocument() async {
    final json = await store.toMap();

    if (json.isNotEmpty) {
      return MatexStockPositionSizeCalculatorBlocDocument.fromJson(json);
    }

    return const MatexStockPositionSizeCalculatorBlocDocument();
  }
}
