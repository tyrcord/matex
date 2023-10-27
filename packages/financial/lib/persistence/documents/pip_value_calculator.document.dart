import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:matex_financial/financial.dart';
// import other necessary packages

class MatexPipValueCalculatorDocument extends FastCalculatorDocument {
  late final String? accountCurrency;
  late final String? baseCurrency;
  late final String? counterCurrency;
  late final String? positionSize;
  late final String? numberOfPips;
  late final String? pipDecimalPlaces;

  MatexPipValueCalculatorDocument({
    String? accountCurrency,
    String? baseCurrency,
    String? counterCurrency,
    String? positionSize,
    String? numberOfPips,
    String? pipDecimalPlaces,
  }) {
    this.accountCurrency = assignValue(accountCurrency);
    this.baseCurrency = assignValue(baseCurrency);
    this.counterCurrency = assignValue(counterCurrency);
    this.positionSize = assignValue(positionSize);
    this.numberOfPips = assignValue(numberOfPips);
    this.pipDecimalPlaces = assignValue(pipDecimalPlaces);
  }

  @override
  MatexPipValueCalculatorDocument clone() => copyWith();

  @override
  MatexPipValueCalculatorDocument copyWith({
    String? accountCurrency,
    String? baseCurrency,
    String? counterCurrency,
    String? positionSize,
    String? numberOfPips,
    String? pipDecimalPlaces,
  }) {
    return MatexPipValueCalculatorDocument(
      accountCurrency: accountCurrency ?? this.accountCurrency,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      counterCurrency: counterCurrency ?? this.counterCurrency,
      positionSize: positionSize ?? this.positionSize,
      numberOfPips: numberOfPips ?? this.numberOfPips,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
    );
  }

  @override
  MatexPipValueCalculatorDocument merge(
    covariant MatexPipValueCalculatorDocument model,
  ) {
    return copyWith(
      accountCurrency: model.accountCurrency,
      baseCurrency: model.baseCurrency,
      counterCurrency: model.counterCurrency,
      positionSize: model.positionSize,
      numberOfPips: model.numberOfPips,
      pipDecimalPlaces: model.pipDecimalPlaces,
    );
  }

  @override
  MatexPipValueCalculatorBlocFields toFields() {
    return MatexPipValueCalculatorBlocFields(
      accountCurrency: accountCurrency,
      baseCurrency: baseCurrency,
      counterCurrency: counterCurrency,
      positionSize: positionSize,
      numberOfPips: numberOfPips,
      pipDecimalPlaces: pipDecimalPlaces,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'accountCurrency': accountCurrency,
      'baseCurrency': baseCurrency,
      'counterCurrency': counterCurrency,
      'positionSize': positionSize,
      'numberOfPips': numberOfPips,
      'pipDecimalPlaces': pipDecimalPlaces,
      ...super.toJson(),
    };
  }

  static MatexPipValueCalculatorDocument fromJson(
    Map<String, dynamic> json,
  ) {
    return MatexPipValueCalculatorDocument(
      accountCurrency: json['accountCurrency'] as String?,
      baseCurrency: json['baseCurrency'] as String?,
      counterCurrency: json['counterCurrency'] as String?,
      positionSize: json['positionSize'] as String?,
      numberOfPips: json['numberOfPips'] as String?,
      pipDecimalPlaces: json['pipDecimalPlaces'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        accountCurrency,
        baseCurrency,
        counterCurrency,
        positionSize,
        numberOfPips,
        pipDecimalPlaces,
      ];
}
