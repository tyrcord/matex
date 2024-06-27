// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fastyle_core/fastyle_core.dart';

typedef MatexPdfDialogCallback = void Function({
  required BuildContext context,
  required FutureBoolCallback onCreateOperation,
  WidgetBuilder? intialBuilder,
  String? Function(FastOperationStatus)? onGetValidText,
  String? Function(FastOperationStatus)? onGetCancelText,
  String? Function(FastOperationStatus)? onGetTitleText,
  Widget Function(BuildContext context, dynamic error)? errorBuilder,
  bool barrierDismissible,
  FastOperationStatusChanged? onOperationStatusChanged,
  FutureBoolCallback? onVerifyRights,
  FutureBoolCallback? onGrantRights,
  WidgetBuilder? verifyingRightsBuilder,
  WidgetBuilder? grantingRightsBuilder,
  WidgetBuilder? rightsDeniedBuillder,
  WidgetBuilder? operationInProgressBuilder,
  WidgetBuilder? operationSucceededBuilder,
  WidgetBuilder? operationFailedBuilder,
  WidgetBuilder? missingRightsBuilder,
  FastOperationStatusChanged? onCancel,
  FastOperationStatusChanged? onValid,
  FastOperationStatusChanged? onAlternativeAction,
  String? Function(FastOperationStatus)? onGetAlternativeText,
});
