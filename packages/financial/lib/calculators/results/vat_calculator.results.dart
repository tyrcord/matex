import 'package:tmodel_dart/tmodel_dart.dart';

// TODO: add total discount amount and rate
class MatexVatCalculatorResults extends TModel {
  final double? totalTaxes;
  final double? total;
  final double? tipAmount;
  final double? grandTotal;
  final double? subTotal;
  final double? federalVatAmount;
  final double? regionalVatAmount;
  final double? vatAmount;
  final double? customVatAmount;
  final double? tipRate;

  const MatexVatCalculatorResults({
    this.totalTaxes,
    this.total,
    this.tipAmount,
    this.grandTotal,
    this.subTotal,
    this.federalVatAmount,
    this.regionalVatAmount,
    this.vatAmount,
    this.customVatAmount,
    this.tipRate,
  });

  @override
  MatexVatCalculatorResults clone() {
    return MatexVatCalculatorResults(
      totalTaxes: totalTaxes,
      total: total,
      tipAmount: tipAmount,
      grandTotal: grandTotal,
      subTotal: subTotal,
      federalVatAmount: federalVatAmount,
      regionalVatAmount: regionalVatAmount,
      vatAmount: vatAmount,
      customVatAmount: customVatAmount,
      tipRate: tipRate,
    );
  }

  @override
  MatexVatCalculatorResults copyWith({
    double? totalTaxes,
    double? total,
    double? tipAmount,
    double? grandTotal,
    double? subTotal,
    double? federalVatAmount,
    double? regionalVatAmount,
    double? vatAmount,
    double? customVatAmount,
    double? tipRate,
  }) {
    return MatexVatCalculatorResults(
      totalTaxes: totalTaxes ?? this.totalTaxes,
      total: total ?? this.total,
      tipAmount: tipAmount ?? this.tipAmount,
      grandTotal: grandTotal ?? this.grandTotal,
      subTotal: subTotal ?? this.subTotal,
      federalVatAmount: federalVatAmount ?? this.federalVatAmount,
      regionalVatAmount: regionalVatAmount ?? this.regionalVatAmount,
      vatAmount: vatAmount ?? this.vatAmount,
      customVatAmount: customVatAmount ?? this.customVatAmount,
      tipRate: tipRate ?? this.tipRate,
    );
  }

  @override
  MatexVatCalculatorResults merge(covariant MatexVatCalculatorResults model) {
    return copyWith(
      totalTaxes: model.totalTaxes,
      total: model.total,
      tipAmount: model.tipAmount,
      grandTotal: model.grandTotal,
      subTotal: model.subTotal,
      federalVatAmount: model.federalVatAmount,
      regionalVatAmount: model.regionalVatAmount,
      vatAmount: model.vatAmount,
      customVatAmount: model.customVatAmount,
      tipRate: model.tipRate,
    );
  }

  @override
  List<Object?> get props => [
        totalTaxes,
        total,
        tipAmount,
        grandTotal,
        subTotal,
        federalVatAmount,
        regionalVatAmount,
        vatAmount,
        customVatAmount,
        tipRate,
      ];
}
