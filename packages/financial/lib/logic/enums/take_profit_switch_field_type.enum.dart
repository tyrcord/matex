enum MatexTakeProfitSwitchFieldType { riskReward, price, amount }

MatexTakeProfitSwitchFieldType? takeProfitSwitchFieldTypeFromString(
  String? string,
) {
  switch (string) {
    case 'riskReward':
      return MatexTakeProfitSwitchFieldType.riskReward;
    case 'price':
      return MatexTakeProfitSwitchFieldType.price;
    default:
      return null;
  }
}
