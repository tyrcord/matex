// Package imports:
import 'package:matex_core/core.dart';

class MatexForexPositionSizeCalculatorState extends MatexCalculatorState {
  final double? positionSize;
  final int? pipDecimalPlaces;
  final bool isAccountCurrencyCounter;
  final double counterToAccountCurrencyRate;
  final double instrumentPairRate;
  final double? stopLossPrice;
  final double? riskAmount;
  final double? riskPercent;
  final double? stopLossPips;
  final double? entryPrice;
  final double? accountSize;

  const MatexForexPositionSizeCalculatorState({
    this.positionSize,
    this.pipDecimalPlaces,
    this.isAccountCurrencyCounter = false,
    this.counterToAccountCurrencyRate = 0,
    this.instrumentPairRate = 0,
    this.stopLossPrice,
    this.riskAmount,
    this.riskPercent,
    this.stopLossPips,
    this.entryPrice,
    this.accountSize,
  });

  @override
  MatexForexPositionSizeCalculatorState clone() => copyWith();

  @override
  MatexForexPositionSizeCalculatorState copyWith({
    double? positionSize,
    int? pipDecimalPlaces,
    bool? isAccountCurrencyCounter,
    double? counterToAccountCurrencyRate,
    double? instrumentPairRate,
    double? stopLossPrice,
    double? riskAmount,
    double? riskPercent,
    double? stopLossPips,
    double? entryPrice,
    double? accountSize,
  }) {
    return MatexForexPositionSizeCalculatorState(
      positionSize: positionSize ?? this.positionSize,
      pipDecimalPlaces: pipDecimalPlaces ?? this.pipDecimalPlaces,
      isAccountCurrencyCounter:
          isAccountCurrencyCounter ?? this.isAccountCurrencyCounter,
      counterToAccountCurrencyRate:
          counterToAccountCurrencyRate ?? this.counterToAccountCurrencyRate,
      instrumentPairRate: instrumentPairRate ?? this.instrumentPairRate,
      stopLossPrice: stopLossPrice ?? this.stopLossPrice,
      riskAmount: riskAmount ?? this.riskAmount,
      riskPercent: riskPercent ?? this.riskPercent,
      stopLossPips: stopLossPips ?? this.stopLossPips,
      entryPrice: entryPrice ?? this.entryPrice,
      accountSize: accountSize ?? this.accountSize,
    );
  }

  @override
  MatexForexPositionSizeCalculatorState merge(
    covariant MatexForexPositionSizeCalculatorState model,
  ) {
    return copyWith(
      positionSize: model.positionSize,
      pipDecimalPlaces: model.pipDecimalPlaces,
      isAccountCurrencyCounter: model.isAccountCurrencyCounter,
      counterToAccountCurrencyRate: model.counterToAccountCurrencyRate,
      instrumentPairRate: model.instrumentPairRate,
      stopLossPrice: model.stopLossPrice,
      riskAmount: model.riskAmount,
      riskPercent: model.riskPercent,
      stopLossPips: model.stopLossPips,
      entryPrice: model.entryPrice,
      accountSize: model.accountSize,
    );
  }

  @override
  List<Object?> get props => [
        positionSize,
        pipDecimalPlaces,
        isAccountCurrencyCounter,
        counterToAccountCurrencyRate,
        instrumentPairRate,
        stopLossPrice,
        riskAmount,
        riskPercent,
        stopLossPips,
        entryPrice,
        accountSize,
      ];
}
