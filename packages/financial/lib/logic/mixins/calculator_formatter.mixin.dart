import 'package:matex_core/core.dart';
import 'package:matex_dart/matex_dart.dart'
    show MatexPairMetadata, MatexPairPipMetadata;

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
      value: rate,
      locale: locale,
      minimumFractionDigits: minimumFractionDigits ?? round,
      maximumFractionDigits: maximumFractionDigits ?? round,
    );
  }
}