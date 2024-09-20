// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Package imports:
import 'package:collection/collection.dart' show IterableExtension;
import 'package:easy_localization/easy_localization.dart';
import 'package:fastyle_buttons/fastyle_buttons.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:fastyle_images/fastyle_images.dart';
import 'package:lingua_core/generated/locale_keys.g.dart';
import 'package:lingua_core/lingua_core.dart';
import 'package:lingua_finance/generated/locale_keys.g.dart';
import 'package:lingua_finance_instrument/generated/locale_keys.g.dart';
import 'package:lingua_finance_instrument/lingua_finance_instrument.dart';
import 'package:tbloc/tbloc.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

typedef MatexFinancialCurrencytItem = FastItem<MatexInstrumentMetadata>;

/// A Flutter widget for displaying a selectable list of currencies.
class MatexFinancialSelectCurrencyField extends StatefulWidget {
  /// A callback function that takes a [MatexInstrumentMetadata] object and
  /// returns a string description for the item.
  final String Function(MatexInstrumentMetadata)? itemDescriptionBuilder;

  final String Function(MatexInstrumentMetadata)? itemLabelBuilder;

  /// A callback function that will be called when the selection changes.
  /// It takes a [FastItem<String>] object representing the selected item.
  final Function(MatexFinancialCurrencytItem?)? onSelectionChanged;

  /// A list of [MatexInstrumentMetadata] objects representing the financial
  /// instruments.
  final List<MatexInstrumentMetadata>? currencies;

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

  /// Creates a [MatexFinancialSelectCurrencyField].
  const MatexFinancialSelectCurrencyField({
    super.key,
    this.onSelectionChanged,
    this.itemDescriptionBuilder,
    this.itemLabelBuilder,
    this.placeholderText,
    this.flagIconBuilder,
    this.captionText,
    this.selection,
    this.currencies,
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
  State<MatexFinancialSelectCurrencyField> createState() =>
      _MatexFinancialSelectCurrencyFieldState();
}

class _MatexFinancialSelectCurrencyFieldState
    extends State<MatexFinancialSelectCurrencyField>
    implements
        FastFastSelectFieldDelegate<MatexFinancialCurrencytItem>,
        FastListViewLayoutDelegate<MatexFinancialCurrencytItem> {
  static const FastButtonSize _favoriteButtonSize = FastButtonSize.small;
  final _favoriteBloc = MatexCurrencyFavoriteBloc();
  String get maleGender => LinguaLocalizationGender.male;
  late List<MatexFinancialCurrencytItem> _items;
  static const _kFavoritesTabValue = 'favorites';
  MatexFinancialCurrencytItem? _selection;
  late MatexCurrencyBloc _currencyBloc;

  @override
  void initState() {
    super.initState();

    _currencyBloc = MatexCurrencyBloc();
    _loadFinancialInstruments();
  }

  @override
  void didUpdateWidget(MatexFinancialSelectCurrencyField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selection != widget.selection) {
      setState(() => _selection = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MatexFinancialCurrencyBuilder(
      bloc: _currencyBloc,
      builder: (context, state) {
        final spacing = ThemeHelper.spacing.getSpacing(context);
        final currencies = widget.currencies ?? state.currencies;
        _items = _buildSelectOptions(context, currencies);
        _selection = _findSelection();

        return FastSelectField<MatexInstrumentMetadata>(
          allCategoryText: CoreLocaleKeys.core_label_all.tr(gender: maleGender),
          onSelectionChanged: (s) => widget.onSelectionChanged?.call(s),
          searchPlaceholderText: widget.searchPlaceholderText,
          listViewEmptyContentBuilder: _buildEmptyContent,
          extraTabBuilder: () => [_buildFavoritesTab()],
          canClearSelection: widget.canClearSelection,
          itemContentPadding: EdgeInsets.only(
            left: spacing - _favoriteButtonSize.iconSpec.iconMinPadding,
            right: spacing,
          ),
          placeholderText: widget.placeholderText,
          captionText: widget.captionText,
          isReadOnly: !widget.isEnabled,
          noneTextGender: maleGender,
          searchPageDelegate: this,
          selection: _selection,
          groupByCategory: true,
          useFuzzySearch: true,
          delegate: this,
          items: _items,
          searchTitleText: widget.searchTitleText ??
              FinanceInstrumentLocaleKeys.instrument_message_search_instrument
                  .tr(),
          labelText: widget.labelText ??
              FinanceLocaleKeys.finance_label_financial_instrument.tr(),
          leading: _selection != null
              ? _buildFlagIcon(_selection!.value!, hasShadow: false)
              : null,
        );
      },
    );
  }

  Widget? _buildEmptyContent(
    BuildContext context,
    FastListItemCategory<MatexFinancialCurrencytItem> category,
  ) {
    if (category.valueText == _kFavoritesTabValue) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FastNoFavoriteIcon(size: kFastImageSizeXl),
            kFastVerticalSizedBox12,
            FastBody(text: CoreLocaleKeys.core_message_no_favorites.tr()),
          ],
        ),
      );
    }

    return null;
  }

  FastListItemCategory<MatexFinancialCurrencytItem> _buildFavoritesTab() {
    return FastListItemCategory(
      labelText: CoreLocaleKeys.core_label_favorites.tr(),
      items: findFavoriteCurrencies(_items),
      valueText: _kFavoritesTabValue,
      weight: 999,
    );
  }

  MatexFinancialCurrencytItem? _findSelection() {
    if (widget.selection == null) return null;

    final currency = widget.selection!.toLowerCase();

    return _items.where((element) {
      return element.value != null && element.value!.code != null;
    }).firstWhereOrNull((item) => item.value!.code!.toLowerCase() == currency);
  }

  List<MatexFinancialCurrencytItem> _buildSelectOptions(
    BuildContext context,
    List<MatexInstrumentMetadata> currencies,
  ) {
    return currencies
        .where((MatexInstrumentMetadata instrument) => instrument.code != null)
        .map((MatexInstrumentMetadata instrument) {
      return _buildItem(context, instrument);
    }).toList();
  }

  MatexFinancialCurrencytItem _buildItem(
    BuildContext context,
    MatexInstrumentMetadata instrument,
  ) {
    final spacing = ThemeHelper.spacing.getSpacing(context);
    final flagIcon = _buildFlagIcon(instrument);
    String code = instrument.code!;
    var description = code;

    if (widget.itemLabelBuilder != null) {
      code = widget.itemLabelBuilder!(instrument);
    }

    if (widget.itemDescriptionBuilder != null) {
      description = widget.itemDescriptionBuilder!(instrument);
    } else {
      description = itemDescriptionBuilder(instrument);
    }

    return FastItem(
      descriptor: FastListItemDescriptor(
        leading: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: spacing - _favoriteButtonSize.iconSpec.iconMinPadding,
              ),
              child: MatexFinancialCurrencyFavoriteIcon(
                favoriteBloc: _favoriteBloc,
                size: FastButtonSize.small,
                currencyCode: code,
              ),
            ),
            if (flagIcon != null) flagIcon,
          ],
        ),
      ),
      descriptionText: description,
      value: instrument,
      labelText: code,
    );
  }

  Widget? _buildFlagIcon(
    MatexInstrumentMetadata instrument, {
    bool hasShadow = true,
  }) {
    return buildFlagIconForCountry(
      instrument.icon!,
      width: widget.flagIconWidth,
      hasShadow: hasShadow,
    );
  }

  @override
  Widget? willBuildListViewForCategory(
    FastListViewLayout<FastItem> listViewLayout,
    FastListItemCategory<MatexFinancialCurrencytItem> category,
  ) {
    if (category.valueText == _kFavoritesTabValue) {
      return BlocBuilderWidget(
        bloc: _favoriteBloc,
        builder: (context, state) {
          return listViewLayout.buildListView(
            context,
            category.copyWith(items: findFavoriteCurrencies(_items)),
          );
        },
      );
    }

    return null;
  }

  @override
  int willUseCategoryIndex(
    FastSelectField selectField,
    int categoryCategoryIndex,
  ) {
    return _favoriteBloc.hasFavorites ? 1 : 0;
  }

  void _loadFinancialInstruments() {
    SchedulerBinding.instance.scheduleFrameCallback((_) {
      _currencyBloc.addEvent(const MatexCurrencyBlocEvent.init());
    });
  }

  String itemDescriptionBuilder(dynamic metadata) {
    if (metadata is MatexInstrumentMetadata && metadata.name != null) {
      final key = metadata.name!.key;

      return buildLocaleCurrencyKey(key).tr();
    }

    return '';
  }
}
