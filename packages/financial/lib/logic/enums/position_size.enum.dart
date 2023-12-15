enum MatexPositionSizeType {
  standard,
  mini,
  micro,
  nano,
  unit,
}

extension MatexPositionSizeTypeX on MatexPositionSizeType {
  static MatexPositionSizeType? fromName(String? str) {
    if (str == null) return null;

    switch (str.toLowerCase()) {
      case 'standard':
        return MatexPositionSizeType.standard;
      case 'mini':
        return MatexPositionSizeType.mini;
      case 'micro':
        return MatexPositionSizeType.micro;
      case 'nano':
        return MatexPositionSizeType.nano;
      case 'unit':
        return MatexPositionSizeType.unit;
      default:
        return null;
    }
  }
}
