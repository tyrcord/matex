import 'package:lingua_core/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

enum MatexFinancialFrequency {
  daily,
  weekly,
  monthly,
  quarterly,
  semiAnnually,
  annually,
}

extension MatexFinancialFrequencyX on MatexFinancialFrequency {
  static MatexFinancialFrequency fromName(String str) {
    switch (str.toLowerCase()) {
      case 'daily':
        return MatexFinancialFrequency.daily;
      case 'weekly':
        return MatexFinancialFrequency.weekly;
      case 'monthly':
        return MatexFinancialFrequency.monthly;
      case 'quarterly':
        return MatexFinancialFrequency.quarterly;
      case 'semi-annually':
        return MatexFinancialFrequency.semiAnnually;
      case 'annually':
        return MatexFinancialFrequency.annually;
      default:
        throw ArgumentError('Invalid value for MatexFinancialFrequency: $str');
    }
  }

  String get localizedName {
    switch (this) {
      case MatexFinancialFrequency.daily:
        return CoreLocaleKeys.core_label_daily.tr();
      case MatexFinancialFrequency.weekly:
        return CoreLocaleKeys.core_label_weekly.tr();
      case MatexFinancialFrequency.monthly:
        return CoreLocaleKeys.core_label_monthly.tr();
      case MatexFinancialFrequency.quarterly:
        return CoreLocaleKeys.core_label_quarterly.tr();
      case MatexFinancialFrequency.semiAnnually:
        return CoreLocaleKeys.core_label_semi_annually.tr();
      case MatexFinancialFrequency.annually:
        return CoreLocaleKeys.core_label_annually.tr();
      default:
        throw ArgumentError('Invalid value for MatexFinancialFrequency: $this');
    }
  }
}
