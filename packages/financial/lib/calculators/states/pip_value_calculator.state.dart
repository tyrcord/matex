import 'package:matex_core/core.dart';

class MatexPipValueCalculatorState extends MatexCalculatorState {
  final String? accountCurrency;
  final String? baseCurrency;
  final String? counterCurrency;
  final double? positionSize;
  final double? numberOfPips;
  final int? pipDecimalPlaces;

  const MatexPipValueCalculatorState({
    this.accountCurrency,
    this.baseCurrency,
    this.counterCurrency,
    this.positionSize,
    this.numberOfPips,
    this.pipDecimalPlaces,
  });

  @override
  MatexPipValueCalculatorState clone() => copyWith();

  @override
  MatexPipValueCalculatorState copyWith({
    String? accountCurrency,
    String? baseCurrency,
    String? counterCurrency,
    double? positionSize,
    double? numberOfPips,
    int? pipDecimalPlaces,
  }) {
    return MatexPipValueCalculatorState(
      accountCurrency: accountCurrency ?? this.accountCurrency,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      counterCurrency: counterCurrency ?? this.counterCurrency,
      positionSize: positionSize ?? this.positionSize,
      numberOfPips: numberOfPips ?? this.numberOfPips,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
    );
  }

  @override
  MatexPipValueCalculatorState merge(
    covariant MatexPipValueCalculatorState model,
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
  List<Object?> get props => [
        accountCurrency,
        baseCurrency,
        counterCurrency,
        positionSize,
        numberOfPips,
        pipDecimalPlaces,
      ];
}
