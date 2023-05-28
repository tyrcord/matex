// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

void main() {
  group('MatexVatCalculator', () {
    late MatexVatCalculator calculator;

    setUp(() {
      calculator = MatexVatCalculator();
    });

    test('value() returns correct results with no taxes or discounts', () {
      calculator.priceBeforeVat = 100.0;
      final results = calculator.value();

      expect(results.subTotal, equals(0.0));
      expect(results.totalTaxes, equals(0.0));
      expect(results.total, equals(100.0));
      expect(results.grandTotal, equals(0.0));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, equals(0.0));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(0.0));
      expect(results.discountRate, equals(0.0));
      expect(results.tipAmount, equals(0.0));
      expect(results.tipRate, equals(0.0));
    });

    test('value() returns correct results with federal VAT', () {
      calculator.priceBeforeVat = 100.0;
      calculator.federalVatRate = 0.05;
      final results = calculator.value();

      expect(results.subTotal, equals(0.0));
      expect(results.totalTaxes, equals(5.0));
      expect(results.total, equals(105.0));
      expect(results.grandTotal, equals(0.0));
      expect(results.federalVatAmount, equals(5.0));
      expect(results.regionalVatAmount, equals(0.0));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(0.0));
      expect(results.discountRate, equals(0.0));
      expect(results.tipAmount, equals(0.0));
      expect(results.tipRate, equals(0.0));
    });

    test('value() returns correct results with regional VAT', () {
      calculator.priceBeforeVat = 100.0;
      calculator.regionalVatRate = 0.07;
      final results = calculator.value();

      expect(results.subTotal, equals(0.0));
      expect(results.totalTaxes, equals(7.0));
      expect(results.total, equals(107.0));
      expect(results.grandTotal, equals(0.0));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, equals(7.0));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(0.0));
      expect(results.discountRate, equals(0.0));
      expect(results.tipAmount, equals(0.0));
      expect(results.tipRate, equals(0.0));
    });

    test('value() returns correct results with custom VAT', () {
      calculator.priceBeforeVat = 100.0;
      calculator.customVatRate = 0.10;
      final results = calculator.value();

      expect(results.subTotal, equals(0.0));
      expect(results.totalTaxes, equals(10.0));
      expect(results.total, equals(110.0));
      expect(results.grandTotal, equals(0.0));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, equals(0.0));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(10.0));
      expect(results.discountAmount, equals(0.0));
      expect(results.discountRate, equals(0.0));
      expect(results.tipAmount, equals(0.0));
      expect(results.tipRate, equals(0.0));
    });

    test('value() returns correct results with discount amount', () {
      calculator.priceBeforeVat = 100.0;
      calculator.discountAmount = 10.0;
      final results = calculator.value();

      expect(results.subTotal, equals(90.0));
      expect(results.totalTaxes, equals(0.0));
      expect(results.total, equals(90.0));
      expect(results.grandTotal, equals(0.0));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, equals(0.0));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(10.0));
      expect(results.discountRate, equals(0.10));
      expect(results.tipAmount, equals(0.0));
      expect(results.tipRate, equals(0.0));
    });

    test('value() returns correct results with tip rate', () {
      calculator.priceBeforeVat = 100.0;
      calculator.tipRate = 0.10;
      final results = calculator.value();

      expect(results.subTotal, equals(0.0));
      expect(results.totalTaxes, equals(0.0));
      expect(results.total, equals(100.0));
      expect(results.grandTotal, equals(110.0));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, equals(0.0));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(0.0));
      expect(results.discountRate, equals(0.0));
      expect(results.tipAmount, equals(10.0));
      expect(results.tipRate, equals(0.10));
    });

    test('value() returns correct results with discount amount and tip rate',
        () {
      calculator.priceBeforeVat = 100.0;
      calculator.discountAmount = 10.0;
      calculator.tipRate = 0.10;
      final results = calculator.value();

      expect(results.subTotal, equals(90.0));
      expect(results.totalTaxes, equals(0.0));
      expect(results.total, equals(90.0));
      expect(results.grandTotal, equals(99.0));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, equals(0.0));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(10.0));
      expect(results.discountRate, equals(0.10));
      expect(results.tipAmount, equals(9.0));
      expect(results.tipRate, equals(0.10));
    });

    test('value() returns correct results with federal and regional VAT', () {
      calculator.priceBeforeVat = 100.0;
      calculator.federalVatRate = 0.05;
      calculator.regionalVatRate = 0.07;
      final results = calculator.value();

      expect(results.subTotal, equals(0.0));
      expect(results.totalTaxes, equals(12.0));
      expect(results.total, equals(112.0));
      expect(results.grandTotal, equals(0.0));
      expect(results.federalVatAmount, equals(5.0));
      expect(results.regionalVatAmount, equals(7.0));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(0.0));
      expect(results.discountRate, equals(0.0));
      expect(results.tipAmount, equals(0.0));
      expect(results.tipRate, equals(0.0));
    });

    test('value() returns correct results with federal and custom VAT', () {
      calculator.priceBeforeVat = 100.0;
      calculator.federalVatRate = 0.05;
      calculator.customVatRate = 0.10;
      final results = calculator.value();

      expect(results.subTotal, equals(0.0));
      expect(results.totalTaxes, equals(15.0));
      expect(results.total, equals(115.0));
      expect(results.grandTotal, equals(0.0));
      expect(results.federalVatAmount, equals(5.0));
      expect(results.regionalVatAmount, equals(0.0));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(10.0));
      expect(results.discountAmount, equals(0.0));
      expect(results.discountRate, equals(0.0));
      expect(results.tipAmount, equals(0.0));
      expect(results.tipRate, equals(0.0));
    });

    test('value() returns correct results with regional and custom VAT', () {
      calculator.priceBeforeVat = 100.0;
      calculator.regionalVatRate = 0.07;
      calculator.customVatRate = 0.10;
      final results = calculator.value();

      expect(results.subTotal, equals(0.0));
      expect(results.totalTaxes, equals(17.0));
      expect(results.total, equals(117.0));
      expect(results.grandTotal, equals(0.0));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, equals(7.0));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(10.0));
      expect(results.discountAmount, equals(0.0));
      expect(results.discountRate, equals(0.0));
      expect(results.tipAmount, equals(0.0));
      expect(results.tipRate, equals(0.0));
    });

    test(
        'value() returns correct results with federal, regional, '
        'and custom VAT', () {
      calculator.priceBeforeVat = 100.0;
      calculator.federalVatRate = 0.05;
      calculator.regionalVatRate = 0.07;
      calculator.customVatRate = 0.10;
      final results = calculator.value();

      expect(results.subTotal, equals(0.0));
      expect(results.totalTaxes, equals(22.0));
      expect(results.total, equals(122.0));
      expect(results.grandTotal, equals(0.0));
      expect(results.federalVatAmount, equals(5.0));
      expect(results.regionalVatAmount, equals(7.0));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(10.0));
      expect(results.discountAmount, equals(0.0));
      expect(results.discountRate, equals(0.0));
      expect(results.tipAmount, equals(0.0));
      expect(results.tipRate, equals(0.0));
    });

    test('value() returns correct results with discount rate', () {
      calculator.priceBeforeVat = 100.0;
      calculator.discountRate = 0.15;
      final results = calculator.value();

      expect(results.subTotal, equals(85.0));
      expect(results.totalTaxes, equals(0.0));
      expect(results.total, equals(85.0));
      expect(results.grandTotal, equals(0.0));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, equals(0.0));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(15.0));
      expect(results.discountRate, equals(0.15));
      expect(results.tipAmount, equals(0.0));
      expect(results.tipRate, equals(0.0));
    });

    test('value() returns correct results with tip amount', () {
      calculator.priceBeforeVat = 100.0;
      calculator.tipAmount = 10.0;
      final results = calculator.value();

      expect(results.subTotal, equals(0.0));
      expect(results.totalTaxes, equals(0.0));
      expect(results.total, equals(100.0));
      expect(results.grandTotal, equals(110.0));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, equals(0.0));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(0.0));
      expect(results.discountRate, equals(0.0));
      expect(results.tipAmount, equals(10.0));
      expect(results.tipRate, equals(0.10));
    });

    test('value() returns correct results with discount rate and tip rate', () {
      calculator.priceBeforeVat = 100.0;
      calculator.discountRate = 0.10;
      calculator.tipRate = 0.15;
      final results = calculator.value();

      expect(results.subTotal, equals(90.0));
      expect(results.totalTaxes, equals(0.0));
      expect(results.total, equals(90.0));
      expect(results.grandTotal, equals(103.5));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, equals(0.0));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(10.0));
      expect(results.discountRate, equals(0.10));
      expect(results.tipAmount, equals(13.5));
      expect(results.tipRate, equals(0.15));
    });

    test('value() returns correct results with all options applied', () {
      calculator.priceBeforeVat = 100.0;
      calculator.federalVatRate = 0.05;
      calculator.regionalVatRate = 0.07;
      calculator.customVatRate = 0.10;
      calculator.discountAmount = 10.0;
      calculator.tipRate = 0.05;
      final results = calculator.value();

      expect(results.subTotal, equals(90));
      expect(results.totalTaxes, equals(19.8));
      expect(results.total, equals(109.8));
      expect(results.grandTotal, equals(114.3));
      expect(results.federalVatAmount, equals(4.5));
      expect(results.regionalVatAmount, equals(6.3));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(9.0));
      expect(results.discountAmount, equals(10.0));
      expect(results.discountRate, equals(0.10));
      expect(results.tipAmount, equals(4.5));
      expect(results.tipRate, equals(0.05));
    });
  });
}
