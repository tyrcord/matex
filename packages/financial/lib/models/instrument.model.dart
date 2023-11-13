import 'package:tmodel/tmodel.dart';

class MatexFinancialInstrument extends TModel {
  final String? counterCode;
  final String? baseCode;

  const MatexFinancialInstrument({this.counterCode, this.baseCode});

  factory MatexFinancialInstrument.fromJson(Map<dynamic, dynamic> json) {
    return MatexFinancialInstrument(
      counterCode: json['counterCode'] as String?,
      baseCode: json['baseCode'] as String?,
    );
  }

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

  Map<String, String?> toJson() {
    return {
      'counterCode': counterCode,
      'baseCode': baseCode,
    };
  }

  @override
  List<Object?> get props => [baseCode, counterCode];
}
