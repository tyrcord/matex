// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:fastyle_forms/fastyle_forms.dart';
import 'package:lingua_finance/generated/locale_keys.g.dart';
import 'package:lingua_finance_forex/generated/locale_keys.g.dart';
import 'package:lingua_units/generated/locale_keys.g.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexFinancialPositionSizeSwitchField extends StatelessWidget {
  /// A callback that is called when the user changes the field type.
  final Function(MatexPositionSizeType)? onFieldTypeChanged;

  final Function(String)? onValueChanged;

  final String value;

  /// The current field type.
  final MatexPositionSizeType fieldType;

  final String? unitLabelText;

  final String? standardLabelText;

  final String? miniLabelText;

  final String? microLabelText;

  /// Whether the field is enabled or not.
  final bool isEnabled;

  final String? unitCaptionText;

  final String? standardCaptionText;

  final String? miniCaptionText;

  final String? microCaptionText;

  /// The default field type.
  static const kDefaultFieldType = MatexPositionSizeType.unit;

  final String? unitPlaceholderText;

  final String? standardPlaceholderText;

  final String? miniPlaceholderText;

  final String? microPlaceholderText;

  final String? unitMenuText;

  final String? standardMenuText;

  final String? miniMenuText;

  final String? microMenuText;

  final bool transformInvalidNumber;

  const MatexFinancialPositionSizeSwitchField({
    super.key,
    this.onFieldTypeChanged,
    this.onValueChanged,
    this.unitLabelText,
    this.standardLabelText,
    this.miniLabelText,
    this.microLabelText,
    this.unitCaptionText,
    this.standardCaptionText,
    this.miniCaptionText,
    this.microCaptionText,
    this.unitPlaceholderText,
    this.standardPlaceholderText,
    this.miniPlaceholderText,
    this.microPlaceholderText,
    this.unitMenuText,
    this.standardMenuText,
    this.miniMenuText,
    this.microMenuText,
    MatexPositionSizeType? fieldType,
    String? value,
    bool? isEnabled,
    bool? transformInvalidNumber = true,
  })  : fieldType = fieldType ?? kDefaultFieldType,
        isEnabled = isEnabled ?? true,
        value = value ?? '',
        transformInvalidNumber = transformInvalidNumber ?? true;

  @override
  Widget build(BuildContext context) {
    return FastNumberField(
      transformInvalidNumber: transformInvalidNumber,
      suffixIcon: _buildSwitchFieldMenuButton(),
      placeholderText: _getPlaceholderText(),
      onValueChanged: onValueChanged,
      captionText: _getCaptionText(),
      labelText: _getLabelText(),
      isEnabled: isEnabled,
      valueText: value,
    );
  }

  /// Called when the user changes the field type.
  void _onInputTypeOptionChanged(MatexPositionSizeType option) {
    if (option != fieldType) {
      onFieldTypeChanged?.call(option);
    }
  }

  String _getCaptionText() {
    switch (fieldType) {
      case MatexPositionSizeType.unit:
        return unitCaptionText ?? UnitsLocaleKeys.units_label_unit.tr();
      case MatexPositionSizeType.standard:
        return standardCaptionText ??
            FinanceForexLocaleKeys.forex_label_lot_standard.tr();
      case MatexPositionSizeType.mini:
        return miniCaptionText ??
            FinanceForexLocaleKeys.forex_label_lot_mini.tr();
      case MatexPositionSizeType.micro:
        return microCaptionText ??
            FinanceForexLocaleKeys.forex_label_lot_micro.tr();
      default:
        return '';
    }
  }

  String _getPlaceholderText() {
    const defaultPlaceholderText = '0';

    switch (fieldType) {
      case MatexPositionSizeType.unit:
        return unitPlaceholderText ?? defaultPlaceholderText;
      case MatexPositionSizeType.standard:
        return standardPlaceholderText ?? defaultPlaceholderText;
      case MatexPositionSizeType.mini:
        return miniPlaceholderText ?? defaultPlaceholderText;
      case MatexPositionSizeType.micro:
        return microPlaceholderText ?? defaultPlaceholderText;
      default:
        return defaultPlaceholderText;
    }
  }

  /// Builds the switch field menu button.
  Widget _buildSwitchFieldMenuButton() {
    return FastSwitchFieldMenuButton(
      onOptionChanged: _onInputTypeOptionChanged,
      options: [
        PopupMenuItem(
          value: MatexPositionSizeType.unit,
          child: FastSecondaryBody(text: _getUnitMenuLabelText()),
        ),
        PopupMenuItem(
          value: MatexPositionSizeType.standard,
          child: FastSecondaryBody(text: _getStandardMenuLabelText()),
        ),
        PopupMenuItem(
          value: MatexPositionSizeType.mini,
          child: FastSecondaryBody(text: _getMiniMenuLabelText()),
        ),
        PopupMenuItem(
          value: MatexPositionSizeType.micro,
          child: FastSecondaryBody(text: _getMicroMenuLabelText()),
        ),
      ],
    );
  }

  String _getLabelText() {
    switch (fieldType) {
      case MatexPositionSizeType.unit:
        return unitLabelText ??
            FinanceLocaleKeys.finance_label_position_size.tr();
      case MatexPositionSizeType.standard:
        return standardLabelText ??
            FinanceLocaleKeys.finance_label_position_size.tr();
      case MatexPositionSizeType.mini:
        return miniLabelText ??
            FinanceLocaleKeys.finance_label_position_size.tr();
      case MatexPositionSizeType.micro:
        return microLabelText ??
            FinanceLocaleKeys.finance_label_position_size.tr();
      default:
        return '';
    }
  }

  String _getUnitMenuLabelText() {
    return unitMenuText ?? UnitsLocaleKeys.units_label_unit.tr();
  }

  String _getStandardMenuLabelText() {
    return standardMenuText ??
        FinanceForexLocaleKeys.forex_label_lot_standard.tr();
  }

  String _getMiniMenuLabelText() {
    return miniMenuText ?? FinanceForexLocaleKeys.forex_label_lot_mini.tr();
  }

  String _getMicroMenuLabelText() {
    return microMenuText ?? FinanceForexLocaleKeys.forex_label_lot_micro.tr();
  }
}
