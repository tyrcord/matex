import 'package:flutter_test/flutter_test.dart';
import 'package:matex_data/matex_data.dart';

class Person {
  final String name;

  Person({
    required this.name,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'] as String,
    );
  }
}

class MockMatexDataProvider extends MatexDataProvider<Person> {
  MockMatexDataProvider({
    super.debugLabel = 'MockMatexDataProvider',
    super.ttl,
  });

  @override
  Future<String> fetchData() async {
    return '{"0": { "name": "Bob" }}';
  }

  @override
  Person? parse(String key, Map<String, dynamic> jsonData) {
    return Person.fromJson(jsonData);
  }
}

void main() {
  group('MatexDataProvider', () {
    late MatexDataProvider<Person> provider;

    setUp(() {
      provider = MockMatexDataProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    test('fetchData returns correct raw data', () async {
      final data = await provider.fetchData();
      expect(data, '{"0": { "name": "Bob" }}');
    });

    test('parse correctly parses raw JSON data to Person object', () {
      final jsonData = {"name": "Alice"};
      final person = provider.parse('0', jsonData);
      expect(person!.name, "Alice");
    });

    test('get retrieves model correctly based on key', () async {
      final person = await provider.get('0');
      expect(person!.name, "Bob");
    });

    test('get returns null for non-existent key', () async {
      final person = await provider.get('1');
      expect(person, null);
    });

    test('Data is cached correctly', () async {
      // This assumes that the cache behaves synchronously for simplicity,
      // in real-world scenarios you might need a more sophisticated setup.
      await provider.get('0');
      final cachedData = provider.modelCache.get('0');
      expect(cachedData!.name, 'Bob');
    });
  });
}
