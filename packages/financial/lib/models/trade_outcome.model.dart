import 'package:tmodel/tmodel.dart';

class MatexForexTradeOutcome extends TModel {
  final double amount;
  final double pips;
  final double price;

  const MatexForexTradeOutcome({
    this.amount = 0.0,
    this.pips = 0.0,
    this.price = 0.0,
  });

  @override
  List<Object> get props => [
        amount,
        pips,
        price,
      ];

  @override
  TModel clone() {
    return MatexForexTradeOutcome(
      amount: amount,
      pips: pips,
      price: price,
    );
  }

  @override
  TModel copyWith() {
    return MatexForexTradeOutcome(
      amount: amount,
      pips: pips,
      price: price,
    );
  }

  @override
  TModel merge(covariant MatexForexTradeOutcome model) {
    return MatexForexTradeOutcome(
      amount: model.amount,
      pips: model.pips,
      price: model.price,
    );
  }
}
