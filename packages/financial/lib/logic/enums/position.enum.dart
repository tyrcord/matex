// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:lingua_finance/generated/locale_keys.g.dart';

enum MatexPosition {
  long,
  short,
}

extension MatexPositionX on MatexPosition {
  static MatexPosition? fromName(String? str) {
    if (str == null) return null;

    switch (str.toLowerCase()) {
      case 'long':
        return MatexPosition.long;
      case 'short':
        return MatexPosition.short;
      default:
        return null;
    }
  }

  String get localizedName {
    switch (this) {
      case MatexPosition.long:
        return FinanceLocaleKeys.finance_label_position_long.tr();
      case MatexPosition.short:
        return FinanceLocaleKeys.finance_label_position_short.tr();
    }
  }
}
