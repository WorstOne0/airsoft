//
bool betterParseBoolean(dynamic value, {bool defaultValue = false}) {
  if (value is bool) return value;

  if (value is String) {
    final lower = value.trim().toLowerCase();

    if (lower == 'true' || lower == '1' || lower == 'yes') return true;
    if (lower == 'false' || lower == '0' || lower == 'no') return false;

    return defaultValue;
  }

  if (value is int) return value != 0;

  if (value is double) return value != 0.0;

  return defaultValue;
}
