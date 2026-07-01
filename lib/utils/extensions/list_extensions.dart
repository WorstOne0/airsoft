extension ListExtensions<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;

  List<T> splice(int start, int count, [List<T>? insert]) {
    try {
      final result = [...getRange(start, start + count)];
      replaceRange(start, start + count, insert ?? []);

      return result;
    } catch (e) {
      return [];
    }
  }
}

extension ListTransformExtensions<T> on Iterable<T> {
  List<R> whereTypeMap<R>(R? Function(T) f) => map(f) // Iterable<R?>
      .whereType<R>()
      .toList();
}
