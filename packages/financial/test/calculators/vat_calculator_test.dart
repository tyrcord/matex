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

      expect(results.subTotal, isNull);
      expect(results.totalTaxes, isNull);
      expect(results.total, 0);
      expect(results.grandTotal, isNull);
      expect(results.federalVatAmount, isNull);
      expect(results.regionalVatAmount, isNull);
      expect(results.vatAmount, isNull);
      expect(results.customVatAmount, isNull);
      expect(results.discountAmount, isNull);
      expect(results.discountRate, isNull);
      expect(results.tipAmount, isNull);
      expect(results.tipRate, isNull);
    });

    test('value() returns correct results with federal VAT', () {
      calculator
        ..priceBeforeVat = 100.0
        ..federalVatRate = 0.05;

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
      calculator
        ..priceBeforeVat = 100.0
        ..regionalVatRate = 0.07;

      final results = calculator.value();

      expect(results.subTotal, equals(0.0));
      expect(results.totalTaxes, closeTo(7.0, 1));
      expect(results.total, equals(107.0));
      expect(results.grandTotal, equals(0.0));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, closeTo(7.0, 1));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(0.0));
      expect(results.discountRate, equals(0.0));
      expect(results.tipAmount, equals(0.0));
      expect(results.tipRate, equals(0.0));
    });

    test('value() returns correct results with custom VAT', () {
      calculator
        ..priceBeforeVat = 100.0
        ..vatRate = 0.10
        ..customVatRate = 0.10;

      final results = calculator.value();

      expect(results.subTotal, equals(0.0));
      expect(results.totalTaxes, equals(20.0));
      expect(results.total, equals(120.0));
      expect(results.grandTotal, equals(0.0));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, equals(0.0));
      expect(results.vatAmount, equals(10.0));
      expect(results.customVatAmount, equals(10.0));
      expect(results.discountAmount, equals(0.0));
      expect(results.discountRate, equals(0.0));
      expect(results.tipAmount, equals(0.0));
      expect(results.tipRate, equals(0.0));
    });

    test('value() returns correct results with discount amount', () {
      calculator
        ..priceBeforeVat = 100.0
        ..vatRate = 0.10
        ..discountAmount = 10.0;

      final results = calculator.value();

      expect(results.subTotal, equals(90.0));
      expect(results.totalTaxes, equals(9.0));
      expect(results.total, equals(99.0));
      expect(results.grandTotal, equals(0.0));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, equals(0.0));
      expect(results.vatAmount, equals(9.0));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(10.0));
      expect(results.discountRate, equals(0.10));
      expect(results.tipAmount, equals(0.0));
      expect(results.tipRate, equals(0.0));
    });

    test('value() returns correct results with tip rate', () {
      calculator
        ..priceBeforeVat = 100.0
        ..vatRate = 0.10
        ..tipRate = 0.10;

      final results = calculator.value();

      expect(results.subTotal, equals(0.0));
      expect(results.totalTaxes, equals(10.0));
      expect(results.total, equals(110.0));
      expect(results.grandTotal, equals(120.0));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, equals(0.0));
      expect(results.vatAmount, equals(10.0));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(0.0));
      expect(results.discountRate, equals(0.0));
      expect(results.tipAmount, equals(10.0));
      expect(results.tipRate, equals(0.10));
    });

    test('value() returns correct results with discount amount and tip rate',
        () {
      calculator
        ..priceBeforeVat = 100.0
        ..vatRate = 0.10
        ..discountAmount = 10.0
        ..tipRate = 0.10;

      final results = calculator.value();

      expect(results.subTotal, equals(90.0));
      expect(results.totalTaxes, equals(9.0));
      expect(results.total, equals(99.0));
      expect(results.grandTotal, equals(108.0));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, equals(0.0));
      expect(results.vatAmount, equals(9.0));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(10.0));
      expect(results.discountRate, equals(0.10));
      expect(results.tipAmount, equals(9.0));
      expect(results.tipRate, equals(0.10));
    });

    test('value() returns correct results with federal and regional VAT', () {
      calculator
        ..priceBeforeVat = 100.0
        ..federalVatRate = 0.05
        ..regionalVatRate = 0.07;

      final results = calculator.value();

      expect(results.subTotal, equals(0.0));
      expect(results.totalTaxes, closeTo(12.0, 1));
      expect(results.total, equals(112.0));
      expect(results.grandTotal, equals(0.0));
      expect(results.federalVatAmount, equals(5.0));
      expect(results.regionalVatAmount, closeTo(7.0, 1));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(0.0));
      expect(results.discountRate, equals(0.0));
      expect(results.tipAmount, equals(0.0));
      expect(results.tipRate, equals(0.0));
    });

    test('value() returns correct results with federal and custom VAT', () {
      calculator
        ..priceBeforeVat = 100.0
        ..federalVatRate = 0.05
        ..customVatRate = 0.10;

      final results = calculator.value();

      expect(results.subTotal, equals(0.0));
      expect(results.totalTaxes, closeTo(15.0, 1));
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
      calculator
        ..priceBeforeVat = 100.0
        ..regionalVatRate = 0.07
        ..customVatRate = 0.10;

      final results = calculator.value();

      expect(results.subTotal, equals(0.0));
      expect(results.totalTaxes, equals(17.0));
      expect(results.total, equals(117.0));
      expect(results.grandTotal, equals(0.0));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, closeTo(7.0, 1));
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
      calculator
        ..priceBeforeVat = 100.0
        ..federalVatRate = 0.05
        ..regionalVatRate = 0.07
        ..customVatRate = 0.10;

      final results = calculator.value();

      expect(results.subTotal, equals(0.0));
      expect(results.totalTaxes, closeTo(22.0, 1));
      expect(results.total, equals(122.0));
      expect(results.grandTotal, equals(0.0));
      expect(results.federalVatAmount, equals(5.0));
      expect(results.regionalVatAmount, closeTo(7.0, 1));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(10.0));
      expect(results.discountAmount, equals(0.0));
      expect(results.discountRate, equals(0.0));
      expect(results.tipAmount, equals(0.0));
      expect(results.tipRate, equals(0.0));
    });

    test('value() returns correct results with discount rate', () {
      calculator
        ..priceBeforeVat = 100.0
        ..vatRate = 0.10
        ..discountRate = 0.15;

      final results = calculator.value();

      expect(results.subTotal, equals(85.0));
      expect(results.totalTaxes, equals(8.5));
      expect(results.total, equals(93.5));
      expect(results.grandTotal, equals(0.0));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, equals(0.0));
      expect(results.vatAmount, equals(8.5));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(15.0));
      expect(results.discountRate, equals(0.15));
      expect(results.tipAmount, equals(0.0));
      expect(results.tipRate, equals(0.0));
    });

    test('value() returns correct results with tip amount', () {
      calculator
        ..priceBeforeVat = 100.0
        ..vatRate = 0.10
        ..tipAmount = 10.0;

      final results = calculator.value();

      expect(results.subTotal, equals(0.0));
      expect(results.totalTaxes, equals(10.0));
      expect(results.total, equals(110.0));
      expect(results.grandTotal, equals(120.0));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, equals(0.0));
      expect(results.vatAmount, equals(10.0));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(0.0));
      expect(results.discountRate, equals(0.0));
      expect(results.tipAmount, equals(10.0));
      expect(results.tipRate, equals(0.10));
    });

    test('value() returns correct results with discount rate and tip rate', () {
      calculator
        ..priceBeforeVat = 100.0
        ..discountRate = 0.10
        ..vatRate = 0.10
        ..tipRate = 0.15;

      final results = calculator.value();

      expect(results.subTotal, equals(90.0));
      expect(results.totalTaxes, equals(9.0));
      expect(results.total, equals(99.0));
      expect(results.grandTotal, equals(112.5));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, equals(0.0));
      expect(results.vatAmount, equals(9.0));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(10.0));
      expect(results.discountRate, equals(0.10));
      expect(results.tipAmount, equals(13.5));
      expect(results.tipRate, equals(0.15));
    });

    test('value() returns correct results with all options applied', () {
      calculator
        ..priceBeforeVat = 100.0
        ..federalVatRate = 0.05
        ..regionalVatRate = 0.07
        ..customVatRate = 0.10
        ..discountAmount = 10.0
        ..tipRate = 0.05;
      final results = calculator.value();

      expect(results.subTotal, equals(90));
      expect(results.totalTaxes, closeTo(19.8, 0.1));
      expect(results.total, closeTo(109.8, 0.1));
      expect(results.grandTotal, closeTo(114.3, 0.1));
      expect(results.federalVatAmount, equals(4.5));
      expect(results.regionalVatAmount, closeTo(6.3, 0.1));
      expect(results.vatAmount, equals(0.0));
      expect(results.customVatAmount, equals(9.0));
      expect(results.discountAmount, equals(10.0));
      expect(results.discountRate, equals(0.10));
      expect(results.tipAmount, equals(4.5));
      expect(results.tipRate, equals(0.05));
    });

    test('value() handles negative priceBeforeVat', () {
      calculator.priceBeforeVat = -50.0;
      final results = calculator.value();

      expect(results.subTotal, equals(isNull));
      expect(results.totalTaxes, equals(isNull));
      expect(results.total, equals(0.0));
      expect(results.grandTotal, equals(isNull));
      expect(results.federalVatAmount, equals(isNull));
      expect(results.regionalVatAmount, equals(isNull));
      expect(results.vatAmount, equals(isNull));
      expect(results.customVatAmount, equals(isNull));
      expect(results.discountAmount, equals(isNull));
      expect(results.discountRate, equals(isNull));
      expect(results.tipAmount, equals(isNull));
      expect(results.tipRate, equals(isNull));
    });

    test('value() handles all zero VAT rates', () {
      calculator
        ..priceBeforeVat = 100.0
        ..federalVatRate = 0.0
        ..regionalVatRate = 0.0
        ..vatRate = 0.0
        ..customVatRate = 0.0;

      final results = calculator.value();

      expect(results.subTotal, equals(isNull));
      expect(results.totalTaxes, equals(isNull));
      expect(results.total, equals(0.0));
      expect(results.grandTotal, equals(isNull));
      expect(results.federalVatAmount, equals(isNull));
      expect(results.regionalVatAmount, equals(isNull));
      expect(results.vatAmount, equals(isNull));
      expect(results.customVatAmount, equals(isNull));
      expect(results.discountAmount, equals(isNull));
      expect(results.discountRate, equals(isNull));
      expect(results.tipAmount, equals(isNull));
      expect(results.tipRate, equals(isNull));
    });

    test('value() handles discount amount greater than priceBeforeVat', () {
      calculator
        ..priceBeforeVat = 100.0
        ..discountAmount = 110.0; // Greater than priceBeforeVat

      final results = calculator.value();

      expect(results.subTotal, equals(isNull));
      expect(results.totalTaxes, equals(isNull));
      expect(results.total, equals(0.0));
      expect(results.grandTotal, equals(isNull));
      expect(results.federalVatAmount, equals(isNull));
      expect(results.regionalVatAmount, equals(isNull));
      expect(results.vatAmount, equals(isNull));
      expect(results.customVatAmount, equals(isNull));
      expect(results.discountAmount, equals(isNull));
      expect(results.discountRate, equals(isNull));
      expect(results.tipAmount, equals(isNull));
      expect(results.tipRate, equals(isNull));
    });

    test('value() handles maximum values', () {
      calculator
        ..priceBeforeVat = double.maxFinite
        ..customVatRate = 1.0
        ..discountRate = 1.0
        ..tipRate = 1.0;

      final results = calculator.value();

      expect(results.subTotal, equals(isNull));
      expect(results.totalTaxes, equals(isNull));
      expect(results.total, equals(0.0));
      expect(results.grandTotal, equals(isNull));
      expect(results.federalVatAmount, equals(isNull));
      expect(results.regionalVatAmount, equals(isNull));
      expect(results.vatAmount, equals(isNull));
      expect(results.customVatAmount, equals(isNull));
      expect(results.discountAmount, equals(isNull));
      expect(results.discountRate, equals(isNull));
      expect(results.tipAmount, equals(isNull));
      expect(results.tipRate, equals(isNull));
    });

    test('value() handles combinations of discounts and tips', () {
      calculator
        ..priceBeforeVat = 100.0
        ..vatRate = 0.10
        ..discountAmount = 10.0
        ..tipRate = 0.05;
      final results = calculator.value();

      expect(results.subTotal, equals(90.0));
      expect(results.totalTaxes, equals(9.0));
      expect(results.total, equals(99.0));
      expect(results.grandTotal, equals(103.50));
      expect(results.federalVatAmount, equals(0.0));
      expect(results.regionalVatAmount, equals(0.0));
      expect(results.vatAmount, equals(9.0));
      expect(results.customVatAmount, equals(0.0));
      expect(results.discountAmount, equals(10.0));
      expect(results.discountRate, equals(0.10));
      expect(results.tipAmount, equals(4.5));
      expect(results.tipRate, equals(0.05));
    });

    test('Calculates price before VAT correctly with only federal VAT rate',
        () {
      calculator
        ..priceAfterVat = 121 // Price including 21% VAT
        ..federalVatRate = 0.21; // 21% VAT rate

      final results = calculator.value();

      expect(results.priceBeforeVat, closeTo(100, 0.01));
    });

    test('Calculates price before VAT correctly with federal and regional VAT',
        () {
      calculator
        ..priceAfterVat = 100 // Price including federal and regional VAT
        ..federalVatRate = 0.05 // 5% federal VAT
        ..regionalVatRate = 0.07; // 7% regional VAT

      final results = calculator.value();

      expect(results.priceBeforeVat, closeTo(89.29, 0.01));
    });

    test('Calculates price before VAT correctly with discount rate', () {
      calculator
        ..priceAfterVat = 100 // Price after 5% VAT and 10% discount
        ..federalVatRate = 0.13 // 5% federal VAT
        ..discountRate = 0.10; // 10% discount rate

      final results = calculator.value();

      expect(results.priceBeforeVat, closeTo(98.33, 0.01));
      expect(results.totalTaxes, closeTo(11.50, 0.01));
      expect(results.discountAmount, closeTo(9.83, 0.01));
      expect(results.subTotal, closeTo(88.5, 0.01));
    });

    test('Calculates price before VAT correctly with discount amount', () {
      calculator
        ..priceAfterVat = 110 // Price after 20% VAT and $10 discount
        ..vatRate = 0.20 // 20% VAT rate
        ..discountAmount = 10; // $10 discount

      final results = calculator.value();

      expect(results.priceBeforeVat, closeTo(101.67, 0.01));
    });

    test(
        'Calculates price before VAT and discounts correctly with custom '
        'VAT rate', () {
      calculator
        ..priceAfterVat = 100 // Price after 5% VAT and 10% discount
        ..vatRate = 0.1 // 10% VAT rate
        ..customVatRate = 0.05 // 5% custom VAT rate
        ..discountRate = 0.10; // 10% discount rate

      final results = calculator.value();

      expect(results.priceBeforeVat, closeTo(96.62, 0.01));
    });
  });
}
