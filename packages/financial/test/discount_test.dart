import 'package:flutter_test/flutter_test.dart';

import 'package:matex_financial/financial.dart';

void main() {
  test('applyDiscount returns correct value', () {
    expect(applyDiscount(100.0, 10.0, 0.0), equals(90.0));
    expect(applyDiscount(100.0, 0.0, 0.1), equals(90.0));
    expect(applyDiscount(100.0, 5.0, 0.5), equals(95.0));
    expect(applyDiscount(100.0, 0.0, 0.0), equals(100.0));
  });
}
