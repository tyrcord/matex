// Package imports:
import 'package:decimal/decimal.dart';
import 'package:tenhance/tenhance.dart';

/// Parses a string value to a double, returning 0.0 if the parsing fails.
double parseFieldValueToDouble(String? value) {
  final parsedValue = parseStringToDouble(value);

  return parsedValue ?? 0.0;
}

/// Parses a string to a double.
///
/// The `value` parameter is the string to parse.
///
/// Returns the parsed double, or `null` if the string could not be parsed.
/// TODO: move to t_helpers
double? parseStringToDouble(String? value) {
  if (value is String && value.isNotEmpty) {
    final dValue = Decimal.tryParse(value);

    return dValue?.toSafeDouble();
  }

  return null;
}

int? parseStringToInt(String? value) {
  if (value is String && value.isNotEmpty) {
    final dValue = Decimal.tryParse(value);

    return dValue?.toSafeDouble().toInt();
  }

  return null;
}
