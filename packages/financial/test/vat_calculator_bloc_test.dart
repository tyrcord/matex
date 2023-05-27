import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matex_financial/blocs/keys/keys.dart';
import 'package:matex_financial/blocs/vat_calculator.bloc.dart';
import 'package:tstore/tstore.dart';

void main() {
  setUpTStoreTesting();

  late MatexVatCalculatorBloc vatCalculatorBloc;

  Future<void> clearDocument() async {
    vatCalculatorBloc.addEvent(FastCalculatorBlocEvent.clear());
    await Future.delayed(const Duration(milliseconds: 100));
  }

  setUp(() async {
    vatCalculatorBloc = MatexVatCalculatorBloc();

    vatCalculatorBloc.addEvent(FastCalculatorBlocEvent.init());

    await Future.delayed(const Duration(milliseconds: 100));
  });

  test('patchPriceBeforeVat() should update the priceBeforeVat field',
      () async {
    await clearDocument();

    // Define a test value
    const testValue = '100';

    // Call the patchPriceBeforeVat() method
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.priceBeforeVat,
        value: testValue,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    // Verify that the priceBeforeVat field is updated
    expect(vatCalculatorBloc.currentState.fields.priceBeforeVat, testValue);
  });

  test('patchCustomVatRate() should update the customVatRate field', () async {
    await clearDocument();

    // Define a test value
    const testValue = '10';

    // Call the patchCustomVatRate() method
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.customVatRate,
        value: testValue,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    // Verify that the customVatRate field is updated
    expect(vatCalculatorBloc.currentState.fields.customVatRate, testValue);
  });

  test('patchDiscountAmount() should update the discountAmount field',
      () async {
    await clearDocument();

    // Define a test value
    const testValue = '20';

    // Call the patchDiscountAmount() method
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.discountAmount,
        value: testValue,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    // Verify that the discountAmount field is updated
    expect(vatCalculatorBloc.currentState.fields.discountAmount, testValue);
  });

  test('compute() should compute the VAT values correctly', () async {
    await clearDocument();

    // Set the initial state of the bloc with specific values
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.priceBeforeVat,
        value: '100',
      ),
    );
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.vatRate,
        value: '10',
      ),
    );
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.discountAmount,
        value: '20',
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    // Call the compute() method to calculate the VAT values
    final result = await vatCalculatorBloc.compute();

    await Future.delayed(const Duration(milliseconds: 100));

    // Verify the computed VAT values
    expect(result.totalTaxes, 8.0);
    expect(result.total, 88.0);
    expect(result.discountAmount, 20.0);
  });
}
