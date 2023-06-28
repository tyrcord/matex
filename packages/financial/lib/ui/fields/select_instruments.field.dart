import 'package:flutter/material.dart';
import 'package:fastyle_dart/fastyle_dart.dart';
import 'package:fastyle_financial/fastyle_financial.dart';
import 'package:matex_financial/financial.dart';
import 'package:flutter/scheduler.dart';
import 'package:matex_dart/matex_dart.dart';
import 'package:tbloc/tbloc.dart';

class MatexSelectInstrumentField extends StatefulWidget {
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

  const MatexSelectInstrumentField({
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
  });

  @override
  State<MatexSelectInstrumentField> createState() =>
      _MatexSelectInstrumentFieldState();
}

class _MatexSelectInstrumentFieldState
    extends State<MatexSelectInstrumentField> {
  late MatexInstrumentBloc _instrumentBloc;

  @override
  void initState() {
    super.initState();

    // Initialize the calculator bloc.
    _instrumentBloc = MatexInstrumentBloc();

    // Show the splash ad after the first frame is rendered.
    SchedulerBinding.instance.addPostFrameCallback(_loadFinancialInstruments);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilderWidget(
      bloc: _instrumentBloc,
      builder: (context, instrumentBlocState) {
        return FastSelectInstrumentField(
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
          selection: widget.selection,
        );
      },
    );
  }

  _loadFinancialInstruments(_) {
    _instrumentBloc.addEvent(const MatexInstrumentBlocEvent.init());
  }
}
