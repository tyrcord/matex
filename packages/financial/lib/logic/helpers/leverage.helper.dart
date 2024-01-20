// Package imports:
import 'package:t_helpers/helpers.dart';

String formatLeverage(
  num leverage, {
  String? locale,
  int? maximumFractionDigits = 2,
  int? minimumFractionDigits,
}) {
  if (leverage <= 0) {
    throw ArgumentError.value(
      leverage,
      'leverageRatio',
      'The leverage ratio must be greater than 0',
    );
  }

  final value = formatDecimal(
    maximumFractionDigits: maximumFractionDigits,
    minimumFractionDigits: minimumFractionDigits,
    locale: locale,
    value: leverage,
  );

  return "$value:1";
}
