// Package imports:
import 'package:lingua_core/generated/locale_keys.g.dart';

// Project imports:
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
