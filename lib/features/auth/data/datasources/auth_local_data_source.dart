import 'package:bac_project/core/resources/errors/exceptions.dart';
import 'package:bac_project/core/services/cache/cache_constant.dart';
import 'package:bac_project/core/services/cache/cache_manager.dart';
import 'package:bac_project/features/auth/data/responses/get_user_data_response.dart';
import 'package:bac_project/features/auth/domain/requests/get_user_data_request.dart';

abstract class AuthLocalDataSource {
  // update user data
  Future<GetUserDataResponse> getUserData({required GetUserDataRequest request});
}

class AuthLocalDataSourceImplements implements AuthLocalDataSource {
  final CacheManager _cacheManager;

  AuthLocalDataSourceImplements({required CacheManager cacheManager})
    : _cacheManager = cacheManager;

  @override
  Future<GetUserDataResponse> getUserData({required GetUserDataRequest request}) async {
    //
    await _cacheManager.checkIsValid(CacheConstant.userDataCreatedKey);
    //
    final data = await _cacheManager().read(CacheConstant.userDataDataKey);
    //
    if (data == null) {
      throw const CacheEmptyException();
    }
    //
    return GetUserDataResponse.fromCache(data);
  }
}
