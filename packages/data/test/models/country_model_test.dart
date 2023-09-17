import 'package:flutter_test/flutter_test.dart';
import 'package:matex_data/matex_data.dart';

void main() {
  group('MatexCountryMetadata', () {
    test('fromJson() throws ArgumentError if currency is null', () {
      final json = {
        'vatRates': [0.2],
        'currency': null
      };

      expect(
        () => MatexCountryMetadata.fromJson('germany', json),
        throwsArgumentError,
      );
    });

    test('fromJson() throws ArgumentError if currency is not a string', () {
      final json = {
        'vatRates': [0.2],
        'currency': 123
      };

      expect(
        () => MatexCountryMetadata.fromJson('germany', json),
        throwsArgumentError,
      );
    });

    test('fromJson() throws ArgumentError if currency is empty', () {
      final json = {
        'vatRates': [0.2],
        'currency': ''
      };

      expect(
        () => MatexCountryMetadata.fromJson('germany', json),
        throwsArgumentError,
      );
    });

    test('fromJson() converts raw VAT rates into a list of doubles', () {
      final json = {
        'vatRates': [0.2, 0.1],
        'currency': 'USD'
      };
      final metadata = MatexCountryMetadata.fromJson('germany', json);

      expect(metadata.vatRates, equals([0.2, 0.1]));
    });

    test('copyWith() returns a copy with modified properties', () {
      const metadata = MatexCountryMetadata(
        id: 'germany',
        currency: 'USD',
        vatRates: [0.2],
      );
      final copy = metadata.copyWith(currency: 'EUR');

      expect(copy.currency, equals('EUR'));
      expect(copy.vatRates, equals([0.2]));
    });

    test('merge() returns a merged copy with prioritized properties', () {
      const metadata1 = MatexCountryMetadata(
        id: 'germany',
        currency: 'USD',
        vatRates: [0.2],
      );
      const metadata2 = MatexCountryMetadata(
        id: 'germany',
        currency: 'EUR',
        vatRates: [0.1],
      );

      final merged = metadata1.merge(metadata2);

      expect(merged.currency, equals('EUR'));
      expect(merged.vatRates, equals([0.1]));
    });

    test('props returns a list of identifying properties', () {
      const metadata = MatexCountryMetadata(
        id: 'germany',
        currency: 'USD',
        vatRates: [0.2],
      );

      expect(
          metadata.props,
          equals([
            'germany',
            'USD',
            [0.2]
          ]));
    });
  });
}
