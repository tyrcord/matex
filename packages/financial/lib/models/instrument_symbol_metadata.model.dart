import 'package:tmodel/tmodel.dart';

class MatexInstrumentSymbolMetadata extends TModel {
  final String ticker;
  final String long;
  final String short;

  const MatexInstrumentSymbolMetadata({
    required this.ticker,
    required this.long,
    required this.short,
  });

  static MatexInstrumentSymbolMetadata fromJson(Map<String, dynamic> json) {
    return MatexInstrumentSymbolMetadata(
      ticker: json['ticker'] as String,
      long: json['long'] as String,
      short: json['short'] as String,
    );
  }

  @override
  List<Object> get props => [ticker, long, short];

  @override
  TModel clone() => copyWith();

  @override
  MatexInstrumentSymbolMetadata copyWith(
      {String? ticker, String? long, String? short}) {
    return MatexInstrumentSymbolMetadata(
      ticker: ticker ?? this.ticker,
      long: long ?? this.long,
      short: short ?? this.short,
    );
  }

  @override
  MatexInstrumentSymbolMetadata merge(
    covariant MatexInstrumentSymbolMetadata model,
  ) {
    return MatexInstrumentSymbolMetadata(
      ticker: model.ticker,
      long: model.long,
      short: model.short,
    );
  }
}
