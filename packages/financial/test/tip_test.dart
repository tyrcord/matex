import 'package:flutter_test/flutter_test.dart';

import 'package:matex_financial/financial.dart';

void main() {
  test('calculateTip calculates tip on price before VAT', () {
    expect(calculateTip(100, 15), equals(15));
    expect(calculateTip(50, 20), equals(10));
    expect(calculateTip(52, 20), equals(10.40));
  });
}
