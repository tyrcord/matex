// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fastyle_core/fastyle_core.dart';

Color? getRiskRewardRatioColorForValue(BuildContext context, double? reward) {
  final palette = ThemeHelper.getPaletteColors(context);
  final redColor = palette.red.mid;

  if (reward == null || reward == 0) return palette.red.mid;
  if (reward >= 3) return palette.green.mid;
  if (reward >= 2) return palette.mint.mid;
  if (reward >= 1) return palette.orange.mid;

  return redColor;
}
