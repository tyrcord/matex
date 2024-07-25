// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:lingua_calculator/generated/locale_keys.g.dart';
import 'package:lingua_core/generated/locale_keys.g.dart';

// Project imports:
import 'package:matex_core/core.dart';

class MatexCalculatorWidget<B extends MatexCalculatorBloc,
    R extends FastCalculatorResults> extends StatefulWidget {
  final bool Function(FastCalculatorBlocState state)?
      canEnableExportToPdfInteractions;
  final List<Widget>? calculatorActions;
  final List<Widget>? resultsActions;
  final WidgetBuilder? dividerBuilder;
  final WidgetBuilder? headerBuilder;
  final WidgetBuilder? footerBuilder;
  final WidgetBuilder resultsBuilder;
  final List<Widget> Function(BuildContext context)? actionsBuilder;
  final WidgetBuilder fieldsBuilder;
  final String? resultsTitleText;
  final String? fieldsTitleText;
  final String? pageTitleText;
  final bool showRefreshIcon;
  final bool requestFullApp;
  final Widget? refreshIcon;
  final bool showClearIcon;
  final Widget? backButton;
  final Widget? exportToPdfIcon;
  final Widget? clearIcon;
  final bool showInfoIcon;
  final Widget? infoIcon;
  final VoidCallback? onInfo;
  final B calculatorBloc;
  final Widget? leading;
  final VoidCallback? onClear;

  /// A builder method used to build the UI for displaying the breakdown of
  /// the calculations.
  final WidgetBuilder? breakdownBuilder;

  /// A string that represents the title text for the breakdown section.
  /// If null, the default value is used.
  final String? breakdownTitleText;

  /// A list of actions that can be performed on the breakdown section.
  final List<Widget>? breakdownActions;

  final ValueNotifier<bool>? breadownViewNotifier;

  const MatexCalculatorWidget({
    super.key,
    required this.calculatorBloc,
    required this.resultsBuilder,
    required this.fieldsBuilder,
    this.canEnableExportToPdfInteractions,
    this.requestFullApp = false,
    this.showRefreshIcon = true,
    this.showClearIcon = true,
    this.showInfoIcon = true,
    this.calculatorActions,
    this.resultsTitleText,
    this.fieldsTitleText,
    this.resultsActions,
    this.dividerBuilder,
    this.footerBuilder,
    this.headerBuilder,
    this.actionsBuilder,
    this.pageTitleText,
    this.refreshIcon,
    this.backButton,
    this.breakdownBuilder,
    this.breakdownTitleText,
    this.breakdownActions,
    this.exportToPdfIcon,
    this.clearIcon,
    this.infoIcon,
    this.leading,
    this.onInfo,
    this.breadownViewNotifier,
    this.onClear,
  });

  @override
  MatexCalculatorWidgetState createState() => MatexCalculatorWidgetState();
}

class MatexCalculatorWidgetState extends State<MatexCalculatorWidget> {
  @override
  void initState() {
    super.initState();

    final bloc = widget.calculatorBloc;
    bloc.addEvent(FastCalculatorBlocEvent.init());
  }

  @override
  void dispose() {
    super.dispose();

    widget.calculatorBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return FastAppSettingsLanguageBuilder(
      builder: (context, state) {
        return FastCalculatorPageLayout(
          calculatorBloc: widget.calculatorBloc,
          calculatorActions: widget.calculatorActions,
          resultsActions: widget.resultsActions,
          dividerBuilder: widget.dividerBuilder,
          headerBuilder: widget.headerBuilder,
          footerBuilder: widget.footerBuilder,
          resultsBuilder: widget.resultsBuilder,
          fieldsBuilder: widget.fieldsBuilder,
          actionsBuilder: widget.actionsBuilder,
          resultsTitleText:
              widget.resultsTitleText ?? CoreLocaleKeys.core_label_results.tr(),
          fieldsTitleText: widget.fieldsTitleText ??
              CalculatorLocaleKeys.calculator_label_calculator.tr(),
          pageTitleText: !widget.requestFullApp ? widget.pageTitleText : null,
          showRefreshIcon: widget.showRefreshIcon,
          requestFullApp: widget.requestFullApp,
          refreshIcon: widget.refreshIcon,
          showClearIcon: widget.showClearIcon,
          backButton: widget.backButton,
          clearIcon: widget.clearIcon,
          showInfoIcon: widget.showInfoIcon,
          infoIcon: widget.infoIcon,
          onInfo: widget.onInfo,
          leading: widget.leading,
          breakdownBuilder: widget.breakdownBuilder,
          breakdownTitleText: widget.breakdownTitleText,
          breakdownActions: widget.breakdownActions,
          breadownViewNotifier: widget.breadownViewNotifier,
          onClear: widget.onClear,
        );
      },
    );
  }
}
