import 'package:lingua_finance/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

enum MatexPivotPointsMethods {
  camarilla,
  deMark,
  fibonacci,
  standard,
  woodie,
}

extension MatexPivotPointsMethodsX on MatexPivotPointsMethods {
  static MatexPivotPointsMethods fromName(String str) {
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
        throw ArgumentError('Invalid value for MatexPivotPointsMethods: $str');
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
      default:
        throw ArgumentError('Invalid value for MatexPivotPointsMethods: $this');
    }
  }
}
