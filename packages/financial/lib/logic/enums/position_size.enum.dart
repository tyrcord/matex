enum MatexPositionSizeType {
  standard,
  mini,
  micro,
  nano,
  unit,
}

MatexPositionSizeType getPositionSizeTypeFromString(String? size) {
  switch (size) {
    case 'standard':
      return MatexPositionSizeType.standard;
    case 'mini':
      return MatexPositionSizeType.mini;
    case 'micro':
      return MatexPositionSizeType.micro;
    case 'nano':
      return MatexPositionSizeType.nano;
    default:
      return MatexPositionSizeType.unit;
  }
}
