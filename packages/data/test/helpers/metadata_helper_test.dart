// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:matex_data/matex_data.dart';

void main() {
  group('parseMetadataJson', () {
    test('should parse valid JSON string', () {
      const jsonString = '{"name": "John", "age": 30}';
      final expected = {'name': 'John', 'age': 30};
      final result = parseMetadataJson(jsonString);

      expect(result, equals(expected));
    });

    test('should throw exception for invalid JSON string', () {
      const jsonString = '{"name": "John", "age": 30,}';

      expect(() => parseMetadataJson(jsonString), throwsException);
    });
  });
}
