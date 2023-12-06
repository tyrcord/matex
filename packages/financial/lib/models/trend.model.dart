import 'package:lingua_finance/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

enum MatexTrend {
  up,
  down,
}

extension MatexTrendX on MatexTrend {
  static MatexTrend fromString(String str) {
    switch (str.toLowerCase()) {
      case 'up':
        return MatexTrend.up;
      case 'down':
        return MatexTrend.down;
      default:
        throw ArgumentError('Invalid value for MatexTrend: $str');
    }
  }

  static String toLocalizedString(MatexTrend trend) {
    switch (trend) {
      case MatexTrend.up:
        return FinanceLocaleKeys.finance_label_trend_up.tr();
      case MatexTrend.down:
        return FinanceLocaleKeys.finance_label_trend_down.tr();
    }
  }
}
