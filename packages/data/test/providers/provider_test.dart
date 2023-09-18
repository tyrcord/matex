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

  static String jsonString =
      '{"0": { "name": "Bob" }, "1": { "name": "Alice" }}';

  @override
  Future<String> fetchData() async {
    return jsonString;
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
      expect(data, MockMatexDataProvider.jsonString);
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
      final person = await provider.get('2');
      expect(person, null);
    });

    test('getAll returns list of models when data is available', () async {
      final models = await provider.list();

      expect(models, hasLength(2));
      expect(models[0].name, 'Bob');
      expect(models[1].name, 'Alice');
    });

    test('Data is cached correctly', () async {
      await provider.get('0');
      final cachedData = provider.modelCache.get('0');
      expect(cachedData!.name, 'Bob');
    });
  });
}
