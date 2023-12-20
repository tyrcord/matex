import 'dart:async';
import 'dart:convert' show jsonDecode;

import 'package:flutter/services.dart';
import 'package:matex_financial/financial.dart';

const _kAssetPath = 'packages/matex_data/assets/meta/pairs.json';

const _kPairKeyMetadata = {
  'default_pip': 'default_pip',
  'pair_types': 'pair_types',
  'default_forex_lots': 'default_forex_lots',
  'lot_units': 'lot_units',
};

// TODO: needs review from matex_dart
// FIXME: need to find another name
// need to review when we will take of the stock market
class MatexFinancialInstrumentPairMetadataService
    extends MatexFiancialMetadataProvider<MatexPairMetadata> {
  static final MatexFinancialInstrumentPairMetadataService _singleton =
      MatexFinancialInstrumentPairMetadataService._();

  factory MatexFinancialInstrumentPairMetadataService() => _singleton;

  MatexFinancialInstrumentPairMetadataService._();

  @override
  Future<Map<String, MatexPairMetadata>> init() async {
    final json = await rootBundle.loadString(_kAssetPath);
    final pairs = jsonDecode(json) as Map<String, dynamic>;

    _removeExtraMetadata(pairs);

    return pairs.map<String, MatexPairMetadata>((key, value) {
      return MapEntry(
        key,
        MatexPairMetadata.fromJson(value as Map<String, dynamic>),
      );
    });
  }

  void _removeExtraMetadata(Map<String, dynamic> metadata) {
    metadata.removeWhere((String key, dynamic json) {
      final shouldRemoveExtraMetadata = _shouldRemoveExtraMetadata(key);

      if (shouldRemoveExtraMetadata) {
        _extractExtraMetadata(key, json as Map<String, dynamic>);
      }

      return shouldRemoveExtraMetadata;
    });
  }

  bool _shouldRemoveExtraMetadata(String key) {
    return _kPairKeyMetadata.containsKey(key);
  }

  void _extractExtraMetadata(String key, Map<String, dynamic> json) {
    if (key == _kPairKeyMetadata['pair_types']) {
      json.forEach((String key, dynamic value) {
        MatexPairTypeMetadata.addToCache(
          key,
          value as Map<String, dynamic>,
        );
      });
    }
  }
}
