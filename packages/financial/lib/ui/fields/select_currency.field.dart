import 'package:flutter/material.dart';
import 'package:fastyle_dart/fastyle_dart.dart';
import 'package:fastyle_financial/fastyle_financial.dart';
import 'package:matex_financial/financial.dart';
import 'package:flutter/scheduler.dart';
import 'package:matex_dart/matex_dart.dart';
import 'package:tbloc/tbloc.dart';

class MatexSelectCurrencyField extends StatefulWidget {
  /// A callback function that takes a [MatexInstrumentMetadata] object and
  /// returns a string label for the item.
  final String Function(MatexInstrumentMetadata)? itemLabelBuilder;

  /// A callback function that will be called when the selection changes.
  /// It takes a [FastItem<String>] object representing the selected item.
  final Function(FastItem<String>?)? onSelectionChanged;

  /// The width of the flag icon displayed in each item.
  final double? flagIconWidth;

  /// The title text displayed in the search field.
  final String? searchTitleText;

  /// The optional text displayed below the selection.
  final String? captionText;

  /// The initial selected item value.
  final String? selection;

  /// The label text displayed above the selection.
  final String? labelText;

  /// Specifies whether the field is enabled or disabled.
  final bool? isEnabled;

  /// The placeholder text displayed in the search field.
  final String? searchPlaceholderText;

  /// The placeholder text displayed in the selection field.
  final String? placeholderText;

  /// A callback function that builds the flag icon for each item.
  final Widget Function(MatexInstrumentMetadata)? flagIconBuilder;

  /// Specifies whether the selection can be cleared.
  final bool? canClearSelection;

  const MatexSelectCurrencyField({
    super.key,
    this.onSelectionChanged,
    this.itemLabelBuilder,
    this.placeholderText,
    this.flagIconBuilder,
    this.captionText,
    this.selection,
    this.searchPlaceholderText,
    this.searchTitleText,
    this.isEnabled,
    this.flagIconWidth,
    this.labelText,
    this.canClearSelection,
  });

  @override
  State<MatexSelectCurrencyField> createState() =>
      _MatexSelectCurrencyFieldState();
}

class _MatexSelectCurrencyFieldState extends State<MatexSelectCurrencyField> {
  late MatexCurrencyBloc _currencyBloc;

  @override
  void initState() {
    super.initState();

    // Initialize the calculator bloc.
    _currencyBloc = MatexCurrencyBloc();

    // Show the splash ad after the first frame is rendered.
    SchedulerBinding.instance.addPostFrameCallback(_loadFinancialInstruments);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilderWidget(
      buildWhen: (previous, next) => previous.currencies != next.currencies,
      bloc: _currencyBloc,
      builder: (context, instrumentBlocState) {
        return FastSelectCurrencyField(
          onSelectionChanged: widget.onSelectionChanged,
          searchTitleText: widget.searchTitleText,
          captionText: widget.captionText,
          labelText: widget.labelText,
          isEnabled: widget.isEnabled,
          itemLabelBuilder: widget.itemLabelBuilder,
          currencies: instrumentBlocState.currencies,
          flagIconBuilder: widget.flagIconBuilder,
          flagIconWidth: widget.flagIconWidth,
          placeholderText: widget.placeholderText,
          searchPlaceholderText: widget.searchPlaceholderText,
          canClearSelection: widget.canClearSelection,
          selection: widget.selection,
        );
      },
    );
  }

  _loadFinancialInstruments(_) {
    _currencyBloc.addEvent(const MatexCurrencyBlocEvent.init());
  }
}
