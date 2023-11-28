// Package imports:
import 'package:lingua_core/generated/locale_keys.g.dart';
import 'package:matex_financial/financial.dart';

/// Gets the locale key for a given financial frequency.
///
/// [frequency] - The financial frequency for which the locale key is needed.
/// Returns the corresponding locale key.
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

/// Converts a string representation of a frequency to its corresponding enum
/// value.
///
/// [key] - The string representation of a frequency.
/// Returns the corresponding MatexFinancialFrequency enum value.
/// Defaults to 'MatexFinancialFrequency.annually' if the key is not valid.
MatexFinancialFrequency parseFinancialFrequencyFromString(String? key) {
  if (key == null) return MatexFinancialFrequency.annually;

  try {
    return MatexFinancialFrequency.values.firstWhere(
      (value) => value.name == key,
      orElse: () => MatexFinancialFrequency.annually,
    );
  } on Exception {
    // Handle specific exceptions if necessary
    return MatexFinancialFrequency.annually;
  }
}

/// Determines the number of payments per year based on the frequency.
///
/// [frequency] - The financial frequency.
/// Returns the number of payments per year.
int getPaymentFrequency(MatexFinancialFrequency frequency) {
  switch (frequency) {
    case MatexFinancialFrequency.semiAnnually:
      return 2;
    case MatexFinancialFrequency.quarterly:
      return 4;
    case MatexFinancialFrequency.monthly:
      return 12;
    case MatexFinancialFrequency.weekly:
      return 52;
    case MatexFinancialFrequency.daily:
      return 365;
    default:
      return 1;
  }
}
