// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:lingua_finance/generated/locale_keys.g.dart';

enum MatexPivotPointsMethods {
  camarilla,
  deMark,
  fibonacci,
  standard,
  woodie,
}

extension MatexPivotPointsMethodsX on MatexPivotPointsMethods {
  static bool hasName(String? str) {
    if (str == null) return false;

    switch (str.toLowerCase()) {
      case 'camarilla':
      case 'demark':
      case 'fibonacci':
      case 'standard':
      case 'woodie':
        return true;
      default:
        return false;
    }
  }

  static MatexPivotPointsMethods? fromName(String? str) {
    if (str == null) return null;

    switch (str.toLowerCase()) {
      case 'camarilla':
        return MatexPivotPointsMethods.camarilla;
      case 'demark':
        return MatexPivotPointsMethods.deMark;
      case 'fibonacci':
        return MatexPivotPointsMethods.fibonacci;
      case 'standard':
        return MatexPivotPointsMethods.standard;
      case 'woodie':
        return MatexPivotPointsMethods.woodie;
      default:
        return null;
    }
  }

  String get localizedName {
    switch (this) {
      case MatexPivotPointsMethods.camarilla:
        return FinanceLocaleKeys.finance_label_pivot_point_camarilla.tr();
      case MatexPivotPointsMethods.deMark:
        return FinanceLocaleKeys.finance_label_pivot_point_demark.tr();
      case MatexPivotPointsMethods.fibonacci:
        return FinanceLocaleKeys.finance_label_pivot_point_fibonacci.tr();
      case MatexPivotPointsMethods.standard:
        return FinanceLocaleKeys.finance_label_pivot_point_standard.tr();
      case MatexPivotPointsMethods.woodie:
        return FinanceLocaleKeys.finance_label_pivot_point_woodie.tr();
    }
  }
}
