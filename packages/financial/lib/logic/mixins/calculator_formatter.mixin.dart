// Package imports:
import 'package:matex_core/core.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

mixin MatexFinancialCalculatorFormatterMixin on MatexCalculatorFormatterMixin {
  String localizeQuote({
    num? rate,
    String? locale,
    int? minimumFractionDigits,
    int? maximumFractionDigits,
    MatexPairMetadata? metadata,
  }) {
    // FIXME: refactor matex dart
    final round =
        metadata?.pip.round ?? MatexPairPipMetadata.defaultMetatada().round;

    return localizeNumber(
      minimumFractionDigits: minimumFractionDigits ?? round,
      maximumFractionDigits: maximumFractionDigits ?? round,
      locale: locale ?? getUserLocaleCode(),
      value: rate,
    );
  }

  String localizeLeverage(
    num leverage, {
    String? locale,
    int? minimumFractionDigits,
    int? maximumFractionDigits,
  }) {
    return formatLeverage(
      leverage,
      minimumFractionDigits: minimumFractionDigits,
      maximumFractionDigits: maximumFractionDigits,
      locale: locale ?? getUserLocaleCode(),
    );
  }

  String localizeRiskRewardRatio(double? reward) {
    if (reward == null) return '0';

    const int risk = 1;
    final formattedRatio = localizeNumber(
      minimumFractionDigits: 2,
      value: reward,
    );

    return '$risk:$formattedRatio';
  }
}
