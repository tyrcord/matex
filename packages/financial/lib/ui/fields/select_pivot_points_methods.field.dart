// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart' show IterableExtension;
import 'package:easy_localization/easy_localization.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:lingua_finance/generated/locale_keys.g.dart';
import 'package:matex_financial/financial.dart';

class MatexFinancialSelectPivotPointsMethodsField extends StatefulWidget {
  final ValueChanged<FastItem<MatexPivotPointsMethods>?> onSelectionChanged;
  final MatexPivotPointsMethods? selection;
  final bool canClearSelection;
  final bool isEnabled;

  const MatexFinancialSelectPivotPointsMethodsField({
    super.key,
    required this.onSelectionChanged,
    this.canClearSelection = true,
    this.isEnabled = true,
    this.selection,
  });

  @override
  MatexFinancialSelectPivotPointsMethodsFieldState createState() =>
      MatexFinancialSelectPivotPointsMethodsFieldState();
}

class MatexFinancialSelectPivotPointsMethodsFieldState
    extends State<MatexFinancialSelectPivotPointsMethodsField> {
  @override
  Widget build(BuildContext context) {
    final items = _buildItems();

    return FastSelectField<MatexPivotPointsMethods>(
      searchTitleText: FinanceLocaleKeys.finance_select_pivot_point_method.tr(),
      labelText: FinanceLocaleKeys.finance_label_pivot_points.tr(),
      selection: _findSelection(items, widget.selection),
      onSelectionChanged: widget.onSelectionChanged,
      canClearSelection: widget.canClearSelection,
      isReadOnly: !widget.isEnabled,
      sortItems: false,
      items: items,
    );
  }

  List<FastItem<MatexPivotPointsMethods>> _buildItems() {
    return MatexPivotPointsMethods.values.map((method) {
      return FastItem<MatexPivotPointsMethods>(
        labelText: method.localizedName,
        value: method,
      );
    }).toList();
  }

  FastItem<MatexPivotPointsMethods>? _findSelection(
    List<FastItem<MatexPivotPointsMethods>> items,
    MatexPivotPointsMethods? method,
  ) {
    if (method != null) {
      return items.firstWhereOrNull((item) => item.value == method);
    }

    return null;
  }
}
