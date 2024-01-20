// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:lingua_finance/generated/locale_keys.g.dart';

enum MatexTrend {
  up,
  down,
}

extension MatexTrendX on MatexTrend {
  static MatexTrend? fromName(String? str) {
    if (str == null) return null;

    switch (str.toLowerCase()) {
      case 'up':
        return MatexTrend.up;
      case 'down':
        return MatexTrend.down;
      default:
        return null;
    }
  }

  String get localizedName {
    switch (this) {
      case MatexTrend.up:
        return FinanceLocaleKeys.finance_label_trend_up.tr();
      case MatexTrend.down:
        return FinanceLocaleKeys.finance_label_trend_down.tr();
      default:
        throw ArgumentError('Invalid value for MatexPivotPointsMethods: $this');
    }
  }
}
