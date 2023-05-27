import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_forms/fastyle_forms.dart';
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

  test('patchVatRate() should update the vatRate field', () async {
    await clearDocument();

    // Define a test value
    const testValue = '7.5';

    // Call the patchVatRate() method
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.vatRate,
        value: testValue,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    // Verify that the vatRate field is updated
    expect(vatCalculatorBloc.currentState.fields.vatRate, testValue);
  });

  test('patchFederalVatRate() should update the federalVatRate field',
      () async {
    await clearDocument();

    // Define a test value
    const testValue = '5';

    // Call the patchFederalVatRate() method
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.federalVatRate,
        value: testValue,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    // Verify that the federalVatRate field is updated
    expect(vatCalculatorBloc.currentState.fields.federalVatRate, testValue);
  });

  test('patchRegionalVatRate() should update the regionalVatRate field',
      () async {
    await clearDocument();

    // Define a test value
    const testValue = '2.5';

    // Call the patchRegionalVatRate() method
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.regionalVatRate,
        value: testValue,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    // Verify that the regionalVatRate field is updated
    expect(vatCalculatorBloc.currentState.fields.regionalVatRate, testValue);
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

  test('patchDiscountRate() should update the discountRate field', () async {
    await clearDocument();

    // Define a test value
    const testValue = '15';

    // Call the patchDiscountRate() method
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.discountRate,
        value: testValue,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    // Verify that the discountRate field is updated
    expect(vatCalculatorBloc.currentState.fields.discountRate, testValue);
  });

  test('patchTipRate() should update the tipRate field', () async {
    await clearDocument();

    // Define a test value
    const testValue = '10';

    // Call the patchTipRate() method
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.tipRate,
        value: testValue,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    // Verify that the tipRate field is updated
    expect(vatCalculatorBloc.currentState.fields.tipRate, testValue);
  });

  test('patchTipAmount() should update the tipAmount field', () async {
    await clearDocument();

    // Define a test value
    const testValue = '5';

    // Call the patchTipAmount() method
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.tipAmount,
        value: testValue,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    // Verify that the tipAmount field is updated
    expect(vatCalculatorBloc.currentState.fields.tipAmount, testValue);
  });

  test('patchTipFieldType() should update the tipFieldType field', () async {
    await clearDocument();

    // Define a test value
    const testValue = 'amount';

    // Call the patchTipFieldType() method
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.tipFieldType,
        value: testValue,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 300));

    // Verify that the tipFieldType field is updated
    expect(vatCalculatorBloc.currentState.fields.tipFieldType, testValue);
  });

  test('patchDiscountFieldType() should update the discountFieldType field',
      () async {
    await clearDocument();

    // Define a test value
    const testValue = FastAmountSwitchFieldType.percent;

    // Call the patchDiscountFieldType() method
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.discountFieldType,
        value: testValue,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 300));

    // Verify that the discountFieldType field is updated
    expect(vatCalculatorBloc.currentState.fields.discountFieldType, 'percent');
  });

  test('patchTipFieldType, patchTipAmount, patchTipRate ', () async {
    await clearDocument();

    // Define test values
    const fieldType = FastAmountSwitchFieldType.amount;
    const amountValue = '10';
    const rateValue = '15';

    // Patch the tipAmount
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.tipAmount,
        value: amountValue,
      ),
    );

    // Set the tipFieldType to percentage initially
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.tipFieldType,
        value: FastAmountSwitchFieldType.percent,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    // Verify that the tipFieldType is initially set to percentage
    expect(
      vatCalculatorBloc.currentState.fields.tipFieldType,
      'percent',
    );
    // Verify that the tipAmount field is empty
    expect(vatCalculatorBloc.currentState.fields.tipAmount, '');

    // Patch the tipFieldType to amount
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.tipFieldType,
        value: fieldType,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    // Verify that the tipFieldType is updated to amount
    expect(vatCalculatorBloc.currentState.fields.tipFieldType, 'amount');
    // Verify that the tipAmount field is empty
    expect(vatCalculatorBloc.currentState.fields.tipAmount, '');
    expect(vatCalculatorBloc.currentState.fields.tipRate, '');

    // Patch the tipRate
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.tipRate,
        value: rateValue,
      ),
    );

    // Patch the tipAmount
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.tipAmount,
        value: amountValue,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    // Verify that the tipAmount field is updated
    expect(vatCalculatorBloc.currentState.fields.tipAmount, amountValue);
    // Verify that the tipRate field is empty
    expect(vatCalculatorBloc.currentState.fields.tipRate, '');

    // Patch the tipRate
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.tipRate,
        value: rateValue,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 100));

    // Verify that the tipRate field is updated
    expect(vatCalculatorBloc.currentState.fields.tipRate, rateValue);
    // Verify that the tipAmount field is empty
    expect(vatCalculatorBloc.currentState.fields.tipAmount, '');
  });

  test('patchDiscountFieldType, patchDiscountAmount, patchDiscountRate',
      () async {
    await clearDocument();

    // Define test values
    const fieldType = FastAmountSwitchFieldType.amount;
    const amountValue = '10';
    const rateValue = '15';

    // Patch the discountAmount
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.discountAmount,
        value: amountValue,
      ),
    );

    // Set the discountFieldType to percentage initially
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.discountFieldType,
        value: FastAmountSwitchFieldType.percent,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    // Verify that the discountFieldType is initially set to percentage
    expect(
      vatCalculatorBloc.currentState.fields.discountFieldType,
      'percent',
    );
    // Verify that the discountAmount field is empty
    expect(vatCalculatorBloc.currentState.fields.discountAmount, '');

    // Patch the discountFieldType to amount
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.discountFieldType,
        value: fieldType,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    // Verify that the discountFieldType is updated to amount
    expect(vatCalculatorBloc.currentState.fields.discountFieldType, 'amount');
    // Verify that the discountAmount field is empty
    expect(vatCalculatorBloc.currentState.fields.discountAmount, '');
    expect(vatCalculatorBloc.currentState.fields.discountRate, '');

    // Patch the discountRate
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.discountRate,
        value: rateValue,
      ),
    );

    // Patch the discountAmount
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.discountAmount,
        value: amountValue,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    // Verify that the discountAmount field is updated
    expect(vatCalculatorBloc.currentState.fields.discountAmount, amountValue);
    // Verify that the discountRate field is empty
    expect(vatCalculatorBloc.currentState.fields.discountRate, '');

    // Patch the discountRate
    vatCalculatorBloc.addEvent(
      FastCalculatorBlocEvent.patchValue(
        key: MatexVatCalculatorBlocKey.discountRate,
        value: rateValue,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 100));

    // Verify that the discountRate field is updated
    expect(vatCalculatorBloc.currentState.fields.discountRate, rateValue);
    // Verify that the discountAmount field is empty
    expect(vatCalculatorBloc.currentState.fields.discountAmount, '');
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
