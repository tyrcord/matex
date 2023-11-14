import 'package:tmodel/tmodel.dart';

class MatexFinancialInstrument extends TModel {
  final String? counter;
  final String? base;

  const MatexFinancialInstrument({this.counter, this.base});

  factory MatexFinancialInstrument.fromJson(Map<dynamic, dynamic> json) {
    return MatexFinancialInstrument(
      counter: json['counter'] as String?,
      base: json['base'] as String?,
    );
  }

  bool isValid() {
    return counter != null &&
        base != null &&
        counter!.isNotEmpty &&
        base!.isNotEmpty;
  }

  @override
  MatexFinancialInstrument clone() => copyWith();

  @override
  MatexFinancialInstrument copyWith({
    String? counter,
    String? base,
  }) {
    return MatexFinancialInstrument(
      counter: counter ?? this.counter,
      base: base ?? this.base,
    );
  }

  @override
  MatexFinancialInstrument merge(covariant MatexFinancialInstrument model) {
    return copyWith(counter: model.counter, base: model.base);
  }

  Map<String, String?> toJson() {
    return {'counter': counter, 'base': base};
  }

  @override
  List<Object?> get props => [base, counter];
}
