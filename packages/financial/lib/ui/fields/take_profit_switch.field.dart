// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fastyle_core/fastyle_core.dart';
import 'package:fastyle_forms/fastyle_forms.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class FusexTakeProfitSwitchField extends StatelessWidget {
  static const kDefaultFieldType = MatexTakeProfitSwitchFieldType.price;
  static const kDefaultPriceCaptionText = '\$';
  static const kDefaultRiskRewardCaptionText = 'R:R';
  static const kDefaultPlaceholderText = '0';
  static const kDefaultMenuOptions = [
    MatexTakeProfitSwitchMenuOption.riskReward,
    MatexTakeProfitSwitchMenuOption.price,
  ];

  final Function(MatexTakeProfitSwitchFieldType) onFieldTypeChanged;
  final Function(String)? onPriceValueChanged;
  final Function(String)? onRiskRewardValueChanged;
  final MatexTakeProfitSwitchFieldType fieldType;
  final String? priceLabelText;
  final String? riskRewardLabelText;
  final String priceValue;
  final String riskRewardValue;
  final bool isEnabled;
  final String? priceCaptionText;
  final String? riskRewardCaptionText;
  final String pricePlaceholderText;
  final String riskRewardPlaceholderText;
  final String? priceMenuText;
  final String? riskRewardMenuText;
  final List<MatexTakeProfitSwitchMenuOption> availableMenuOptions;
  final bool transformInvalidNumber;

  const FusexTakeProfitSwitchField({
    super.key,
    required this.onFieldTypeChanged,
    this.onPriceValueChanged,
    this.onRiskRewardValueChanged,
    this.priceCaptionText,
    this.riskRewardCaptionText,
    this.priceLabelText,
    this.riskRewardLabelText,
    this.priceMenuText,
    this.riskRewardMenuText,
    String? pricePlaceholderText,
    String? riskRewardPlaceholderText,
    String? priceValue,
    String? riskRewardValue,
    MatexTakeProfitSwitchFieldType? fieldType,
    List<MatexTakeProfitSwitchMenuOption>? availableMenuOptions =
        kDefaultMenuOptions,
    bool? isEnabled,
    bool? transformInvalidNumber = true,
  })  : availableMenuOptions = availableMenuOptions ?? kDefaultMenuOptions,
        fieldType = fieldType ?? kDefaultFieldType,
        priceValue = priceValue ?? '',
        riskRewardValue = riskRewardValue ?? '',
        isEnabled = isEnabled ?? true,
        pricePlaceholderText = pricePlaceholderText ?? kDefaultPlaceholderText,
        riskRewardPlaceholderText =
            riskRewardPlaceholderText ?? kDefaultPlaceholderText,
        transformInvalidNumber = transformInvalidNumber ?? true;

  @override
  Widget build(BuildContext context) {
    switch (fieldType) {
      case MatexTakeProfitSwitchFieldType.price:
        return buildPriceField();
      default:
        return buildRiskRewardField();
    }
  }

  Widget buildPriceField() {
    return FastNumberField(
      captionText: priceCaptionText ?? kDefaultPriceCaptionText,
      transformInvalidNumber: transformInvalidNumber,
      suffixIcon: buildSwitchFieldMenuButton(),
      placeholderText: pricePlaceholderText,
      onValueChanged: onPriceValueChanged,
      labelText: _getPriceLabel(),
      valueText: priceValue,
      isEnabled: isEnabled,
    );
  }

  Widget buildRiskRewardField() {
    return FastNumberField(
      captionText: riskRewardCaptionText ?? kDefaultRiskRewardCaptionText,
      transformInvalidNumber: transformInvalidNumber,
      suffixIcon: buildSwitchFieldMenuButton(),
      placeholderText: riskRewardPlaceholderText,
      onValueChanged: onRiskRewardValueChanged,
      labelText: _getRiskRewardLabel(),
      valueText: riskRewardValue,
      isEnabled: isEnabled,
    );
  }

  Widget buildSwitchFieldMenuButton() {
    return FastSwitchFieldMenuButton(
      onOptionChanged: onInputTypeOptionChanged,
      options: buildSwitchFieldMenuOptions(),
    );
  }

  List<PopupMenuItem<MatexTakeProfitSwitchFieldType>>
      buildSwitchFieldMenuOptions() {
    final options = <PopupMenuItem<MatexTakeProfitSwitchFieldType>>[];

    if (availableMenuOptions
        .contains(MatexTakeProfitSwitchMenuOption.riskReward)) {
      options.add(PopupMenuItem(
        value: MatexTakeProfitSwitchFieldType.riskReward,
        child: FastSecondaryBody(text: _getRiskRewardMenuLabel()),
      ));
    }

    if (availableMenuOptions.contains(MatexTakeProfitSwitchMenuOption.price)) {
      options.add(PopupMenuItem(
        value: MatexTakeProfitSwitchFieldType.price,
        child: FastSecondaryBody(text: _getPriceMenuLabel()),
      ));
    }

    return options;
  }

  void onInputTypeOptionChanged(MatexTakeProfitSwitchFieldType option) {
    if (option != fieldType) onFieldTypeChanged(option);
  }

  String _getPriceLabel() {
    return priceLabelText ?? 'Take profit at';
  }

  String _getRiskRewardLabel() {
    return riskRewardLabelText ?? 'Risk/Reward';
  }

  String _getPriceMenuLabel() => priceMenuText ?? _getPriceLabel();

  String _getRiskRewardMenuLabel() =>
      riskRewardMenuText ?? _getRiskRewardLabel();
}
