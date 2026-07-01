//
int betterParseInt(dynamic value, {int defaultValue = 0}) {
  if (value is int) return value;

  if (value is String) {
    final firstTry = int.tryParse(value);
    if (firstTry != null) return firstTry;

    final secondTry = double.tryParse(value);
    if ((secondTry?.isNaN ?? false) || (secondTry?.isInfinite ?? false)) return defaultValue;

    return secondTry?.toInt() ?? defaultValue;
  }

  if (value is double) return value.toInt();

  return defaultValue;
}
