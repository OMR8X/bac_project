import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:path_provider/path_provider.dart';
import 'cache_client.dart';

/// callable class
class CacheManager {
  ///
  final CacheClient _cacheClient;

  CacheManager(this._cacheClient);

  ///
  Future<void> init() async {
    await _cacheClient.init(await getApplicationDocumentsDirectory());
    return;
  }

  Future<void> refresh() async {
    await _cacheClient.refresh(await getApplicationDocumentsDirectory());
    return;
  }

  ///
  CacheClient call() {
    return _cacheClient;
  }

  ///
  Future<void> close() async {
    return await _cacheClient.close();
  }

  ///
  Future<void> checkIsValid(String createdKey) async {
    if (1 == 2) {
      throw const CacheFailure();
    }
    return;
  }

  // Enhanced methods for notifications list management
  Future<List<Map<String, dynamic>>> readList(String key) async {
    try {
      final data = await _cacheClient.read(key);
      if (data == null) return [];
      if (data is List) {
        return List<Map<String, dynamic>>.from(data);
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<void> writeList(String key, List<Map<String, dynamic>> data) async {
    await _cacheClient.write(key, data);
  }

  Future<int> addToList(String key, Map<String, dynamic> item) async {
    final currentList = await readList(key);

    // Generate ID for the item if not present
    if (!item.containsKey('id')) {
      item['id'] = DateTime.now().millisecondsSinceEpoch;
    }

    currentList.insert(0, item); // Add to beginning (newest first)
    await writeList(key, currentList);
    return item['id'] as int;
  }

  Future<int> removeFromList(String key, int itemId) async {
    final currentList = await readList(key);
    final initialLength = currentList.length;

    currentList.removeWhere((item) => item['id'] == itemId);
    await writeList(key, currentList);

    return initialLength - currentList.length; // Return number of items removed
  }

  Future<void> clearList(String key) async {
    await _cacheClient.write(key, <Map<String, dynamic>>[]);
  }
}
