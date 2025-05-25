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
}
