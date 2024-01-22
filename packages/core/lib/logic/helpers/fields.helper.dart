/// Parses a string value to a double, returning 0.0 if the parsing fails.
double parseFieldValueToDouble(String? value) {
  final parsedValue = tryParseStringToDouble(value);

  return parsedValue ?? 0.0;
}

/// Parses a string to a double.
///
/// The `value` parameter is the string to parse.
///
/// Returns the parsed double, or `null` if the string could not be parsed.
/// TODO: move to t_helpers
double? tryParseStringToDouble(String? value) {
  if (value is String && value.isNotEmpty) {
    final dValue = double.tryParse(value);

    if (dValue is double) return dValue;
  }

  return null;
}

int? tryParseStringToInt(String? value) {
  final dValue = tryParseStringToDouble(value);

  if (dValue is double) return dValue.toInt();

  return null;
}
