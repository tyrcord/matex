// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:lingua_finance/generated/locale_keys.g.dart';
import 'package:lingua_finance_forex/generated/locale_keys.g.dart';
import 'package:lingua_number/generated/locale_keys.g.dart';

enum FastFinancialAmountSwitchFieldType {
  percent,
  amount,
  pip,
  price,
}

extension FastFinancialAmountSwitchFieldTypeX
    on FastFinancialAmountSwitchFieldType {
  static FastFinancialAmountSwitchFieldType? fromName(String? str) {
    if (str == null) return null;

    switch (str.toLowerCase()) {
      case 'percent':
        return FastFinancialAmountSwitchFieldType.percent;
      case 'amount':
        return FastFinancialAmountSwitchFieldType.amount;
      case 'pip':
        return FastFinancialAmountSwitchFieldType.pip;
      case 'price':
        return FastFinancialAmountSwitchFieldType.price;
      default:
        return null;
    }
  }

  String get localizedName {
    switch (this) {
      case FastFinancialAmountSwitchFieldType.percent:
        return NumberLocaleKeys.number_label_percentage.tr();
      case FastFinancialAmountSwitchFieldType.amount:
        return FinanceLocaleKeys.finance_label_amount_text.tr();
      case FastFinancialAmountSwitchFieldType.pip:
        return FinanceForexLocaleKeys.forex_label_pips_text.tr();
      case FastFinancialAmountSwitchFieldType.price:
        return FinanceLocaleKeys.finance_label_price_text.tr();
      default:
        throw ArgumentError(
          'Invalid value for FastFinancialAmountSwitchFieldType: $this',
        );
    }
  }
}
