// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:lingua_core/generated/locale_keys.g.dart';

enum MatexVatCalculationStrategy {
  excluded,
  included,
}

extension MatexVatCalculationStrategyX on MatexVatCalculationStrategy {
  static MatexVatCalculationStrategy? fromName(String? str) {
    if (str == null) return null;

    switch (str.toLowerCase()) {
      case 'excluded':
        return MatexVatCalculationStrategy.excluded;
      case 'included':
        return MatexVatCalculationStrategy.included;
      default:
        return null;
    }
  }

  String get localizedName {
    switch (this) {
      case MatexVatCalculationStrategy.excluded:
        return CoreLocaleKeys.core_label_excluded.tr();
      case MatexVatCalculationStrategy.included:
        return CoreLocaleKeys.core_label_included.tr();
    }
  }
}
