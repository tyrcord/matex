import 'dart:async';
import 'dart:convert' show jsonDecode;

import 'package:flutter/services.dart';
import 'package:matex_financial/financial.dart';

const _kAssetPath = 'packages/matex_data/assets/meta/instruments.json';

const _kInstrumentKeyMetadata = {
  'instrument_types': 'instrument_types',
};

// TODO: needs review from matex_dart
class MatexFinancialInstrumentMedatataService
    extends MatexFiancialMetadataProvider<MatexInstrumentMetadata> {
  static final MatexFinancialInstrumentMedatataService _singleton =
      MatexFinancialInstrumentMedatataService._();

  factory MatexFinancialInstrumentMedatataService() => _singleton;

  MatexFinancialInstrumentMedatataService._();

  @override
  Future<Map<String, MatexInstrumentMetadata>> init() async {
    final json = await rootBundle.loadString(_kAssetPath);
    final instruments = jsonDecode(json) as Map<String, dynamic>;

    _removeExtraMetadata(instruments);

    return instruments.map<String, MatexInstrumentMetadata>((key, json) {
      return MapEntry(
        key,
        MatexInstrumentMetadata.fromJson(json as Map<String, dynamic>),
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
    return _kInstrumentKeyMetadata.containsKey(key);
  }

  void _extractExtraMetadata(String key, Map<String, dynamic> json) {
    if (key == 'instrument_types') {
      json.forEach((String key, dynamic value) {
        MatexInstrumentTypeMetadata.addToCache(
          key,
          value as Map<String, dynamic>,
        );
      });
    }
  }
}
