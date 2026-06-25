import 'package:hive/hive.dart';

/// Thin wrapper around a Hive box used to cache raw JSON lists/maps for
/// offline fallback when a network request fails.
class CacheService {
  Box get _box => Hive.box('cacheBox');

  void saveList(String key, List<dynamic> data) {
    _box.put(key, data);
  }

  List<dynamic>? getList(String key) {
    final cached = _box.get(key);
    return cached is List ? cached : null;
  }
}
