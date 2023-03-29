import 'package:flutter_test/flutter_test.dart';

import 'package:matex_financial/financial.dart';

void main() {
  test('addVAT adds VAT to price', () {
    expect(addVAT(100, 0.2), equals(120));
    expect(addVAT(50, 0.1), equals(55));
  });

  test('removeVAT removes VAT from price', () {
    expect(removeVAT(120, 0.2), equals(100));
    expect(removeVAT(55, 0.1), equals(50));
  });

  test('getVATAmount returns correct value', () {
    expect(getVATAmount(100.0, 0.2), equals(20.0));
    expect(getVATAmount(50.0, 0.1), equals(5.0));
    expect(getVATAmount(200.0, 0.05), equals(10.0));
  });
}
