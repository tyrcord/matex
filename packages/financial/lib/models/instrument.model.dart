import 'package:tmodel/tmodel.dart';

class MatexFinancialInstrument extends TModel {
  final String? counterCode;
  final String? baseCode;

  const MatexFinancialInstrument({this.counterCode, this.baseCode});

  bool isValid() {
    return counterCode != null &&
        baseCode != null &&
        counterCode!.isNotEmpty &&
        baseCode!.isNotEmpty;
  }

  @override
  MatexFinancialInstrument clone() => copyWith();

  @override
  MatexFinancialInstrument copyWith({
    String? counterCode,
    String? baseCode,
  }) {
    return MatexFinancialInstrument(
      counterCode: counterCode ?? this.counterCode,
      baseCode: baseCode ?? this.baseCode,
    );
  }

  @override
  MatexFinancialInstrument merge(covariant MatexFinancialInstrument model) {
    return copyWith(
      counterCode: model.counterCode,
      baseCode: model.baseCode,
    );
  }

  @override
  List<Object?> get props => [baseCode, counterCode];
}
