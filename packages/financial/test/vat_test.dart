import 'package:flutter_test/flutter_test.dart';

import 'package:financial/financial.dart';

void main() {
  test('addVAT adds VAT to price', () {
    expect(addVAT(100, 20), equals(120));
    expect(addVAT(50, 10), equals(55));
  });

  test('removeVAT removes VAT from price', () {
    expect(removeVAT(120, 20), equals(100));
    expect(removeVAT(55, 10), equals(50));
  });

  test('getVATAmount calculates VAT amount between two prices', () {
    expect(getVATAmount(120, 100), equals(20));
    expect(getVATAmount(55, 50), equals(5));
  });
}
