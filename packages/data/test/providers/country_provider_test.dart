import 'package:flutter_test/flutter_test.dart';
import 'package:matex_data/matex_data.dart';

void main() {
  group('MatexCountryDataProvider', () {
    const sampleCountryKey = 'germany';
    const sampleJson =
        '{"germany": { "vatRates": [7, 19], "currency": "EUR", "code": "DE" }}';

    late MatexDataProvider<MatexCountryMetadata> providerWithJsonData;
    late MatexDataProvider<MatexCountryMetadata> providerWithAsset;

    setUp(() {
      providerWithJsonData = MatexCountryDataProvider(jsonData: sampleJson);
      providerWithAsset = MatexCountryDataProvider();
    });

    tearDown(() {
      providerWithJsonData.dispose();
      providerWithAsset.dispose();
    });

    test('fetchData returns correct raw data when provided jsonData', () async {
      final data = await providerWithJsonData.fetchData();
      expect(data, sampleJson);
    });

    test('parse correctly parses raw JSON data to MatexCountryMetadata object',
        () {
      final jsonData = {
        "vatRates": [7, 19],
        "currency": "EUR",
        "code": "DE",
      };
      final metadata = providerWithJsonData.parse('germany', jsonData);

      expect(metadata, isNotNull);
      expect(metadata!.vatRates, [7, 19]);
      expect(metadata.currency, "EUR");
      expect(metadata.code, 'DE');
    });

    test('get retrieves metadata correctly based on country key', () async {
      final metadata = await providerWithJsonData.get(sampleCountryKey);

      expect(metadata, isNotNull);
      expect(metadata!.vatRates, [7, 19]);
      expect(metadata.currency, "EUR");
      expect(metadata.code, 'DE');
    });
  });
}
