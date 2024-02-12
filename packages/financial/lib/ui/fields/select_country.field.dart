// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart' show IterableExtension;
import 'package:easy_localization/easy_localization.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:fastyle_images/fastyle_images.dart';
import 'package:flutter/scheduler.dart';
import 'package:lingua_core/generated/locale_keys.g.dart';
import 'package:lingua_core/lingua_core.dart';
import 'package:lingua_countries/countries.dart';
import 'package:matex_data/matex_data.dart';
import 'package:matex_financial/financial.dart';

/// A Flutter widget for displaying a selectable list of countries.
class MatexFinancialSelectCountryField extends StatefulWidget {
  /// A callback function that takes a [MatexCountryMetadata] object and
  /// returns a string description for the item.
  final String Function(MatexCountryMetadata)? itemDescriptionBuilder;

  final String Function(MatexCountryMetadata)? itemLabelBuilder;

  /// A callback function that will be called when the selection changes.
  /// It takes a [FastItem<String>] object representing the selected item.
  final Function(FastItem<MatexCountryMetadata>?)? onSelectionChanged;

  /// A list of [MatexCountryMetadata] objects representing the countries.
  final List<MatexCountryMetadata>? countries;

  /// The width of the flag icon displayed in each item.
  final double flagIconWidth;

  /// The title text displayed in the search field.
  final String? searchTitleText;

  /// The optional text displayed below the selection.
  final String? captionText;

  /// The initial selected item value.
  final String? selection;

  /// The label text displayed above the selection.
  final String? labelText;

  /// Specifies whether the field is enabled or disabled.
  final bool isEnabled;

  /// The placeholder text displayed in the search field.
  final String? searchPlaceholderText;

  /// The placeholder text displayed in the selection field.
  final String? placeholderText;

  /// A callback function that builds the flag icon for each item.
  final Widget Function(String)? flagIconBuilder;

  /// Specifies whether the selection can be cleared.
  final bool canClearSelection;

  /// Creates a [MatexFinancialSelectCountryField].
  const MatexFinancialSelectCountryField({
    super.key,
    this.onSelectionChanged,
    this.itemDescriptionBuilder,
    this.itemLabelBuilder,
    this.placeholderText,
    this.flagIconBuilder,
    this.captionText,
    this.selection,
    this.countries,
    this.searchPlaceholderText,
    this.searchTitleText,
    bool? isEnabled = true,
    double? flagIconWidth,
    this.labelText,
    bool? canClearSelection,
  })  : canClearSelection = canClearSelection ?? true,
        flagIconWidth = flagIconWidth ?? 40.0,
        isEnabled = isEnabled ?? true;

  @override
  State<MatexFinancialSelectCountryField> createState() =>
      _MatexFinancialSelectCountryFieldState();
}

class _MatexFinancialSelectCountryFieldState
    extends State<MatexFinancialSelectCountryField> {
  String get maleGender => LinguaLocalizationGender.male;
  FastItem<MatexCountryMetadata>? _selection;
  late MatexCountryBloc _countryBloc;

  @override
  void initState() {
    super.initState();

    _countryBloc = MatexCountryBloc();
    _loadCountries();
  }

  @override
  void didUpdateWidget(MatexFinancialSelectCountryField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selection != oldWidget.selection) {
      setState(() => _selection = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MatexFinancialCountryBuilder(
      bloc: _countryBloc,
      builder: (context, state) {
        final countries = widget.countries ?? state.countries;
        final options = _buildSelectOptions(countries);
        _selection = _findSelection(options);

        return FastSelectField<MatexCountryMetadata>(
          onSelectionChanged: (selection) =>
              widget.onSelectionChanged?.call(selection),
          labelText: widget.labelText ?? CoreLocaleKeys.core_label_country.tr(),
          searchPlaceholderText: widget.searchPlaceholderText,
          canClearSelection: widget.canClearSelection,
          placeholderText: widget.placeholderText,
          searchTitleText:
              widget.searchTitleText ?? CoreLocaleKeys.core_select_country.tr(),
          selection: _selection,
          captionText: widget.captionText,
          noneTextGender: maleGender,
          isReadOnly: !widget.isEnabled,
          useFuzzySearch: true,
          items: options,
          leading: _selection != null
              ? _buildFlagIcon(_selection!.value!, hasShadow: false)
              : null,
        );
      },
    );
  }

  FastItem<MatexCountryMetadata>? _findSelection(
    List<FastItem<MatexCountryMetadata>> options,
  ) {
    if (widget.selection == null) return null;

    final country = widget.selection!.toLowerCase();

    if (country.length < 4) {
      // Search by country code
      return options.where((element) => element.value != null).firstWhereOrNull(
          (item) => item.value!.code.toLowerCase() == country);
    }

    // Search by country id
    return options
        .where((element) => element.value != null)
        .firstWhereOrNull((item) => item.value!.id.toLowerCase() == country);
  }

  List<FastItem<MatexCountryMetadata>> _buildSelectOptions(
    List<MatexCountryMetadata> countries,
  ) {
    return countries.map(_buildItem).toList();
  }

  FastItem<MatexCountryMetadata> _buildItem(
    MatexCountryMetadata country,
  ) {
    final flagIcon = _buildFlagIcon(country);
    String? description;
    late String id;

    if (widget.itemLabelBuilder != null) {
      id = widget.itemLabelBuilder!(country);
    } else {
      id = _itemLabelBuilder(country);
    }

    if (widget.itemDescriptionBuilder != null) {
      description = widget.itemDescriptionBuilder!(country);
    }

    return FastItem(
      descriptor: FastListItemDescriptor(leading: flagIcon),
      descriptionText: description,
      value: country,
      labelText: id,
    );
  }

  String _itemLabelBuilder(MatexCountryMetadata metadata) {
    return buildLocaleCountryKey(metadata.id).tr();
  }

  Widget? _buildFlagIcon(
    MatexCountryMetadata country, {
    bool hasShadow = true,
  }) {
    return buildFlagIconForCountry(
      country.id,
      width: widget.flagIconWidth,
      hasShadow: hasShadow,
    );
  }

  void _loadCountries() {
    if (!_countryBloc.currentState.isInitialized) {
      SchedulerBinding.instance.scheduleFrameCallback((_) {
        _countryBloc.addEvent(MatexCountryBlocEvent.init());
      });
    }
  }
}
