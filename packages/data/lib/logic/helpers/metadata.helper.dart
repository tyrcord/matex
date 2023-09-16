import 'dart:convert';

/// Parse the provided metadata JSON string into a map.
///
/// This function attempts to decode the provided JSON string into a map.
/// If the decoding fails, an exception is thrown.
///
/// - Parameters:
///   - jsonString: The JSON string to parse.
///
/// - Returns: A Map representation of the JSON string.
///
/// - Throws: An exception if JSON parsing fails.
Map<String, dynamic> parseMetadataJson(String jsonString) {
  try {
    return jsonDecode(jsonString) as Map<String, dynamic>;
  } catch (error) {
    throw Exception('Failed to parse JSON data: $error');
  }
}
