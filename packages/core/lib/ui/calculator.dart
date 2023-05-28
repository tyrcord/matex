// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';

// Project imports:
import 'package:matex_core/core.dart';

class MatexCalculatorWidget<B extends MatexCalculatorBloc,
    R extends FastCalculatorResults> extends StatefulWidget {
  final List<Widget>? calculatorActions;
  final List<Widget>? resultsActions;
  final WidgetBuilder? dividerBuilder;
  final WidgetBuilder? headerBuilder;
  final WidgetBuilder? footerBuilder;
  final WidgetBuilder resultsBuilder;
  final WidgetBuilder fieldsBuilder;
  final String? resultsTitleText;
  final String? fieldsTitleText;
  final String? pageTitleText;
  final bool showRefreshIcon;
  final bool requestFullApp;
  final Widget? refreshIcon;
  final bool showClearIcon;
  final Widget? backButton;
  final Widget? shareIcon;
  final Widget? clearIcon;
  final B calculatorBloc;
  final Widget? leading;

  const MatexCalculatorWidget({
    super.key,
    required this.calculatorBloc,
    required this.resultsBuilder,
    required this.fieldsBuilder,
    this.requestFullApp = false,
    this.showRefreshIcon = true,
    this.showClearIcon = true,
    this.calculatorActions,
    this.resultsTitleText,
    this.fieldsTitleText,
    this.resultsActions,
    this.dividerBuilder,
    this.footerBuilder,
    this.headerBuilder,
    this.pageTitleText,
    this.refreshIcon,
    this.backButton,
    this.shareIcon,
    this.clearIcon,
    this.leading,
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

    final bloc = widget.calculatorBloc;
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return FastCalculatorPageLayout(
      calculatorBloc: widget.calculatorBloc,
      calculatorActions: widget.calculatorActions,
      resultsActions: widget.resultsActions,
      dividerBuilder: widget.dividerBuilder,
      headerBuilder: widget.headerBuilder,
      footerBuilder: widget.footerBuilder,
      resultsBuilder: widget.resultsBuilder,
      fieldsBuilder: widget.fieldsBuilder,
      resultsTitleText: widget.resultsTitleText,
      fieldsTitleText: widget.fieldsTitleText,
      pageTitleText: widget.pageTitleText,
      showRefreshIcon: widget.showRefreshIcon,
      requestFullApp: widget.requestFullApp,
      refreshIcon: widget.refreshIcon,
      showClearIcon: widget.showClearIcon,
      backButton: widget.backButton,
      shareIcon: widget.shareIcon,
      clearIcon: widget.clearIcon,
      leading: widget.leading,
    );
  }
}
