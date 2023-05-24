import 'package:flutter_test/flutter_test.dart';
import 'package:matex_financial/financial.dart';

void main() {
  group('VatCalculator', () {
    test('default values', () {
      final calculator = MatexVatCalculator(
          defaultState: const MatexVatCalculatorState(),
          state: const MatexVatCalculatorState());
      final result = calculator.value();

      expect(result.totalTaxes, 0.0);
      expect(result.total, 0.0);
      expect(result.tipAmount, 0.0);
      expect(result.grandTotal, 0.0);
    });

    test('price before VAT', () {
      final calculator = MatexVatCalculator(
          defaultState: const MatexVatCalculatorState(),
          state: const MatexVatCalculatorState(priceBeforeVat: 100));
      final result = calculator.value();

      expect(result.totalTaxes, 0.0);
      expect(result.tipAmount, 0.0);
      expect(result.grandTotal, 0.0);
      expect(result.subTotal, 0.0);
      expect(result.total, 100.0);
    });

    test('federal VAT rate', () {
      final calculator = MatexVatCalculator(
          defaultState: const MatexVatCalculatorState(),
          state: const MatexVatCalculatorState(
            priceBeforeVat: 100,
            federalVatRate: 0.1,
          ));
      final result = calculator.value();

      expect(result.totalTaxes, 10.0);
      expect(result.total, 110.0);
      expect(result.tipAmount, 0.0);
      expect(result.grandTotal, 0.0);
    });

    test('regional VAT rate', () {
      final calculator = MatexVatCalculator(
          defaultState: const MatexVatCalculatorState(),
          state: const MatexVatCalculatorState(
            priceBeforeVat: 100,
            regionalVatRate: 0.05,
          ));

      final result = calculator.value();

      expect(result.totalTaxes, 5.0);
      expect(result.total, 105.0);
      expect(result.tipAmount, 0.0);
      expect(result.grandTotal, 0.0);
    });

    test('discount amount', () {
      final calculator = MatexVatCalculator(
          defaultState: const MatexVatCalculatorState(),
          state: const MatexVatCalculatorState(
            priceBeforeVat: 100,
            discountAmount: 10,
          ));

      final result = calculator.value();

      expect(result.totalTaxes, 0.0);
      expect(result.tipAmount, 0.0);
      expect(result.subTotal, 90.0);
      expect(result.total, 90.0);
      expect(result.grandTotal, 0.0);
    });

    test('discount rate', () {
      final calculator = MatexVatCalculator(
          defaultState: const MatexVatCalculatorState(),
          state: const MatexVatCalculatorState(
            priceBeforeVat: 100,
            discountRate: 0.1,
          ));

      final result = calculator.value();

      expect(result.totalTaxes, 0.0);
      expect(result.total, 90.0);
      expect(result.tipAmount, 0.0);
      expect(result.grandTotal, 0.0);
    });

    test('tip rate', () {
      final calculator = MatexVatCalculator(
          defaultState: const MatexVatCalculatorState(),
          state: const MatexVatCalculatorState(
            priceBeforeVat: 100,
            tipRate: 0.1,
          ));

      final result = calculator.value();

      expect(result.totalTaxes, 0.0);
      expect(result.total, 100.0);
      expect(result.tipAmount, 10.0);
      expect(result.grandTotal, 110.0);
    });

    test('should calculate the correct VAT with no discount or tip', () {
      // Arrange
      final calculator = MatexVatCalculator(
        defaultState: const MatexVatCalculatorState(),
        state: const MatexVatCalculatorState(
          priceBeforeVat: 100,
          federalVatRate: 0.05,
          regionalVatRate: 0.1,
        ),
      );

      // Act
      final result = calculator.value();

      // Assert
      expect(result.total, equals(115));
      expect(result.grandTotal, equals(0));
      expect(result.totalTaxes, equals(15));
      expect(result.federalVatAmount, equals(5));
      expect(result.regionalVatAmount, equals(10));
    });

    test('vatRate, priceBeforeVat, and tipRate', () {
      final calculator = MatexVatCalculator(
        defaultState: const MatexVatCalculatorState(),
        state: const MatexVatCalculatorState(
          priceBeforeVat: 100,
          vatRate: 0.1,
          tipRate: 0.1,
        ),
      );
      final result = calculator.value();

      expect(result.totalTaxes, 10.0);
      expect(result.total, 110.0);
      expect(result.tipAmount, 10.0);
      expect(result.grandTotal, 120.0);
      expect(result.vatAmount, 10.0);
    });

    test('calculates the correct total amount without any discounts or tips',
        () {
      final calculator = MatexVatCalculator(
        defaultState: const MatexVatCalculatorState(),
        state: const MatexVatCalculatorState(
          priceBeforeVat: 100,
          federalVatRate: 0.05,
          regionalVatRate: 0.1,
          vatRate: 0.2,
        ),
      );

      // Act
      final result = calculator.value();

      expect(result.total, equals(135));
      expect(result.grandTotal, equals(0));
      expect(result.totalTaxes, equals(35));
    });
  });

  test('vatRate, priceBeforeVat, tipRate, and discountAmount', () {
    final calculator = MatexVatCalculator(
      defaultState: const MatexVatCalculatorState(),
      state: const MatexVatCalculatorState(
        priceBeforeVat: 100,
        vatRate: 0.1,
        tipRate: 0.1,
        discountAmount: 10,
      ),
    );
    final result = calculator.value();

    expect(result.totalTaxes, 9.0);
    expect(result.total, 99.0);
    expect(result.tipAmount, 9.0);
    expect(result.grandTotal, 108.0);
  });

  test('vatRate, priceBeforeVat, tipRate, and discountRate', () {
    final calculator = MatexVatCalculator(
      defaultState: const MatexVatCalculatorState(),
      state: const MatexVatCalculatorState(
        priceBeforeVat: 100,
        vatRate: 0.1,
        tipRate: 0.1,
        discountRate: 0.1,
      ),
    );
    final result = calculator.value();

    expect(result.totalTaxes, 9.0);
    expect(result.total, 99.0);
    expect(result.tipAmount, 9.0);
    expect(result.grandTotal, 108.0);
  });

  test(
      'federalVatRate, regionalVatRate, priceBeforeVat, tipRate,'
      ' and discountRate', () {
    final calculator = MatexVatCalculator(
      defaultState: const MatexVatCalculatorState(),
      state: const MatexVatCalculatorState(
        priceBeforeVat: 100,
        federalVatRate: 0.05,
        regionalVatRate: 0.07,
        tipRate: 0.1,
        discountRate: 0.1,
      ),
    );
    final result = calculator.value();

    expect(result.totalTaxes, 10.80);
    expect(result.subTotal, 90);
    expect(result.total, 100.80);
    expect(result.tipAmount, 9);
    expect(result.grandTotal, 109.80);
    expect(result.federalVatAmount, equals(4.5));
    expect(result.regionalVatAmount, equals(6.3));
  });

  test(
      'federalVatRate, regionalVatRate, customVatRate, priceBeforeVat, tipRate,'
      ' and discountRate', () {
    final calculator = MatexVatCalculator(
      defaultState: const MatexVatCalculatorState(),
      state: const MatexVatCalculatorState(
        priceBeforeVat: 100,
        federalVatRate: 0.05,
        regionalVatRate: 0.07,
        tipRate: 0.1,
        discountRate: 0.1,
        customVatRate: 0.25,
      ),
    );
    final result = calculator.value();

    expect(result.totalTaxes, 33.30);
    expect(result.subTotal, 90);
    expect(result.total, 123.3);
    expect(result.tipAmount, 9);
    expect(result.federalVatAmount, 4.5);
    expect(result.regionalVatAmount, 6.3);
    expect(result.customVatAmount, 22.5);
    expect(result.grandTotal, 132.30);
    expect(result.subTotal, 90);
  });
}
