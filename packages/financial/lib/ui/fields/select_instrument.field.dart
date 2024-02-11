// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart' show IterableExtension;
import 'package:easy_localization/easy_localization.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:fastyle_images/fastyle_images.dart';
import 'package:lingua_core/generated/locale_keys.g.dart';
import 'package:lingua_core/lingua_core.dart';
import 'package:lingua_finance/generated/locale_keys.g.dart';
import 'package:lingua_finance_instrument/generated/locale_keys.g.dart';
import 'package:lingua_finance_instrument/lingua_finance_instrument.dart';
import 'package:matex_financial/financial.dart';
import 'package:tbloc/tbloc.dart';

const _kLeadingWidth = 40.0;
const _kLeadingHeight = 32.0;
const _kFavoritesTabValue = 'favorites';

typedef MatexFinancialInstrumentItem = FastItem<MatexFinancialInstrument>;

class MatexFinancialSelectInstrumentField extends StatefulWidget {
  /// A callback function that builds the flag icon for each item.
  final Widget Function(String)? flagIconBuilder;

  final ValueChanged<FastItem<MatexFinancialInstrument>?> onSelectionChanged;
  final MatexFinancialInstrument? selection;
  final String? captionText;
  final bool isEnabled;
  final bool showHelperBoundaries;

  const MatexFinancialSelectInstrumentField({
    super.key,
    required this.onSelectionChanged,
    this.showHelperBoundaries = true,
    this.isEnabled = true,
    this.flagIconBuilder,
    this.captionText,
    this.selection,
  });

  @override
  MatexFinancialSelectInstrumentFieldState createState() =>
      MatexFinancialSelectInstrumentFieldState();
}

class MatexFinancialSelectInstrumentFieldState
    extends State<MatexFinancialSelectInstrumentField>
    implements
        FastFastSelectFieldDelegate<FastItem<MatexFinancialInstrument>>,
        FastListViewLayoutDelegate<FastItem<MatexFinancialInstrument>> {
  final _instrumentsBloc = MatexFinancialInstrumentsBloc();
  final _favoriteBloc = MatexInstrumentFavoriteBloc();

  late List<FastItem<MatexFinancialInstrument>> _items;
  FastItem<MatexFinancialInstrument>? _selection;

  String get searchPlaceholderText {
    const k = FinanceInstrumentLocaleKeys.instrument_message_search_instrument;

    return k.tr();
  }

  String get searchTitleText {
    return FinanceInstrumentLocaleKeys.instrument_select_instrument.tr();
  }

  String get maleGender => LinguaLocalizationGender.male;

  @override
  void didUpdateWidget(MatexFinancialSelectInstrumentField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selection != widget.selection) {
      setState(() => _selection = _findSelection());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilderWidget(
      bloc: FastAppSettingsBloc.instance,
      buildWhen: (previous, current) {
        return previous.languageCode != current.languageCode;
      },
      builder: (context, state) {
        final instruments = _instrumentsBloc.currentState.instruments;
        _items = _buildItems(instruments);
        _selection = _findSelection();

        return FastSelectField<MatexFinancialInstrument>(
          allCategoryText: CoreLocaleKeys.core_label_all.tr(gender: maleGender),
          labelText: FinanceLocaleKeys.finance_label_financial_instrument.tr(),
          showHelperBoundaries: widget.showHelperBoundaries,
          listViewEmptyContentBuilder: _buildEmptyContent,
          extraTabBuilder: () => [_buildFavoritesTab()],
          onSelectionChanged: widget.onSelectionChanged,
          searchPlaceholderText: searchPlaceholderText,
          listViewContentPadding: EdgeInsets.zero,
          searchTitleText: searchTitleText,
          captionText: widget.captionText,
          isReadOnly: !widget.isEnabled,
          noneTextGender: maleGender,
          searchPageDelegate: this,
          selection: _selection,
          groupByCategory: true,
          useFuzzySearch: true,
          delegate: this,
          items: _items,
        );
      },
    );
  }

  Widget? _buildEmptyContent(
    BuildContext context,
    FastListItemCategory<FastItem<MatexFinancialInstrument>> category,
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

  FastListItemCategory<MatexFinancialInstrumentItem> _buildFavoritesTab() {
    return FastListItemCategory(
      labelText: CoreLocaleKeys.core_label_favorites.tr(),
      items: findFavoriteInstuments(_items),
      valueText: _kFavoritesTabValue,
      weight: 999,
    );
  }

  List<MatexFinancialInstrumentItem> _buildItems(
    List<MatexPairMetadata> instrumentsMetadata,
  ) {
    return instrumentsMetadata.where((element) {
      return element.counterInstrumentMetadata != null &&
          element.baseInstrumentMetadata != null;
    }).map((MatexPairMetadata pair) {
      final counterMeta = pair.counterInstrumentMetadata;
      final baseMeta = pair.baseInstrumentMetadata;
      final hasExtraMeta = baseMeta != null && counterMeta != null;
      final value = MatexFinancialInstrument(
        base: pair.baseCode,
        counter: pair.counterCode,
      );

      if (hasExtraMeta && baseMeta.type.main == 'index') {
        return FastItem(
          descriptor: FastListItemDescriptor(
            padding: const EdgeInsets.only(right: 16),
            leading: _buildLeadingLayout(
              counterMeta: counterMeta,
              baseMeta: baseMeta,
              child: _buildFlagIcon(baseMeta, width: _kLeadingWidth)!,
            ),
          ),
          labelText: baseMeta.name!.localized,
          descriptionText: baseMeta.symbol?.ticker ?? baseMeta.code,
          categories: [_buildFastCategoryForPair(pair)],
          value: value,
        );
      }

      return FastItem(
        descriptor: hasExtraMeta
            ? _buildInstrumentPairLeading(baseMeta, counterMeta)
            : null,
        labelText: '${pair.baseCode}/${pair.counterCode}',
        descriptionText: hasExtraMeta
            ? _buildPairDescriptionText(baseMeta, counterMeta)
            : null,
        categories: [_buildFastCategoryForPair(pair)],
        value: value,
      );
    }).toList();
  }

  FastItem<MatexFinancialInstrument>? _findSelection() {
    return _items.firstWhereOrNull((item) => item.value == widget.selection);
  }

  FastCategory _buildFastCategoryForPair(MatexPairMetadata pair) {
    return FastCategory(
      labelText: getLabelTextForInstrumentType(pair.type.key),
      valueText: pair.type.main,
      weight: pair.type.weight,
    );
  }

  Widget _buildLeadingLayout({
    required Widget child,
    required MatexInstrumentMetadata baseMeta,
    required MatexInstrumentMetadata counterMeta,
  }) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        MatexFinancialInstrumentFavoriteIcon(
          baseMeta: baseMeta,
          counterMeta: counterMeta,
          favoriteBloc: _favoriteBloc,
        ),
        child,
      ],
    );
  }

  FastListItemDescriptor _buildInstrumentPairLeading(
    MatexInstrumentMetadata baseMeta,
    MatexInstrumentMetadata counterMeta,
  ) {
    return FastListItemDescriptor(
      padding: const EdgeInsets.only(right: 16),
      leading: _buildLeadingLayout(
        counterMeta: counterMeta,
        baseMeta: baseMeta,
        child: SizedBox(
          height: _kLeadingHeight,
          width: _kLeadingWidth,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: buildFlagIconForFinancialInstrument(
                  counterMeta.icon!,
                  width: 32,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: buildFlagIconForFinancialInstrument(
                  baseMeta.icon!,
                  width: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _buildPairDescriptionText(
    MatexInstrumentMetadata baseMeta,
    MatexInstrumentMetadata counterMeta,
  ) {
    final baseLabel = buildLocaleCurrencyKey(baseMeta.name!.key).tr();
    final counterLabel = buildLocaleCurrencyKey(counterMeta.name!.key).tr();

    return '$baseLabel / $counterLabel';
  }

  Widget? _buildFlagIcon(
    MatexInstrumentMetadata instrument, {
    bool hasShadow = true,
    double width = 20,
    double? height,
  }) {
    return buildFlagIconForFinancialInstrument(
      instrument.icon!,
      hasShadow: hasShadow,
      height: height,
      width: width,
    );
  }

  @override
  Widget? willBuildListViewForCategory(
    FastListViewLayout<FastItem> listViewLayout,
    FastListItemCategory<FastItem<MatexFinancialInstrument>> category,
  ) {
    if (category.valueText == _kFavoritesTabValue) {
      return BlocBuilderWidget(
        bloc: _favoriteBloc,
        builder: (context, state) {
          return listViewLayout.buildListView(
            context,
            category.copyWith(items: findFavoriteInstuments(_items)),
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
    return _favoriteBloc.hasFavorites ? 1 : 2;
  }
}
