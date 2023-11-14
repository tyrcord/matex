import 'package:fastyle_core/fastyle_core.dart';
import 'package:matex_financial/financial.dart';

/// Determines whether the financial instrument is marked as favorite or not
/// based on the list of favorite instruments
bool isInstrumentFavorite(
  String base,
  String countrer, {
  List<MatexInstrumentFavorite>? favorites,
}) {
  favorites ??= MatexInstrumentFavoriteBloc.instance.favorites;

  return favorites.any((favorite) {
    return favorite.base == base && favorite.counter == countrer;
  });
}

/// Filters a list of `FastItem` objects to return only the items that
/// correspond to the currency pairs marked as "favorite" in
/// the `favorites` list.
///
/// Parameters:
/// - `items`: The list of `FastItem` objects to filter.
/// - `favorites`: The list of `MatexInstrumentFavorite` objects containing the
///   currency pairs marked as "favorite".
///
/// Returns:
/// A new list of `FastItem` objects that contain `MatexFinancialInstrument`
/// objects that match the "favorite" pairs specified in the `favorites` list.
List<FastItem<MatexFinancialInstrument>> findFavoriteInstuments(
  List<FastItem<MatexFinancialInstrument>> items,
) {
  return items.where((item) {
    final instrumentPair = item.value;

    if (item.value == null) return false;

    final base = instrumentPair!.base;
    final counter = instrumentPair.counter;

    if (base == null || counter == null) return false;

    return isInstrumentFavorite(base, counter);
  }).toList();
}
