// Flutter packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive_ce.dart';

/// Lightweight wrapper around the app's Hive box for non-sensitive local
/// cache (preferences, cached lists, offline data). The box is opened once in
/// `main()` — see [appBoxName].
const appBoxName = 'airsoftCascavelBox';

class HiveStorage {
  final box = Hive.lazyBox(appBoxName);

  Future<bool> save(String key, dynamic value) async {
    try {
      await box.put(key, value);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<T?> read<T>(String key) async => await box.get(key) as T?;

  Future<void> deleteKey(String key) async => box.delete(key);

  Future<void> clear() async => box.clear();
}

final hiveStorageProvider = Provider<HiveStorage>((ref) => HiveStorage());
