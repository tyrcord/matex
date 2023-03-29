import 'package:flutter_test/flutter_test.dart';

import 'package:matex_financial/financial.dart';

void main() {
  test('calculateTip calculates tip on price before VAT', () {
    expect(calculateTip(100, 0.15), equals(15));
    expect(calculateTip(50, 0.2), equals(10));
    expect(calculateTip(52, 0.2), equals(10.40));
  });

  test('getTipAmount returns correct value', () {
    expect(getTipAmount(100.0, 0.15), equals(15.0));
    expect(getTipAmount(50.0, 0.2), equals(10.0));
    expect(getTipAmount(200.0, 0.1), equals(20.0));
  });
}
