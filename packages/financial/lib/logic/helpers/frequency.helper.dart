// Package imports:
import 'package:lingua_core/generated/locale_keys.g.dart';
import 'package:matex_financial/financial.dart';

/// Gets the locale key for a given financial frequency.
String getLocaleKeyForFinancialFrequency(MatexFinancialFrequency frequency) {
  switch (frequency) {
    case MatexFinancialFrequency.annually:
      return CoreLocaleKeys.core_label_annually;
    case MatexFinancialFrequency.semiAnnually:
      return CoreLocaleKeys.core_label_semi_annually;
    case MatexFinancialFrequency.quarterly:
      return CoreLocaleKeys.core_label_quarterly;
    case MatexFinancialFrequency.monthly:
      return CoreLocaleKeys.core_label_monthly;
    case MatexFinancialFrequency.weekly:
      return CoreLocaleKeys.core_label_weekly;
    default:
      return CoreLocaleKeys.core_label_daily;
  }
}

/// Converts a string representation of a frequency to its corresponding
/// enum value.
MatexFinancialFrequency parseFinancialFrequencyFromString(String key) {
  try {
    return MatexFinancialFrequency.values.firstWhere(
      (value) => value.name == key,
      orElse: () => MatexFinancialFrequency.annually,
    );
  } catch (e) {
    return MatexFinancialFrequency.annually;
  }
}
