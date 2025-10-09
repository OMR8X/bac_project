import 'package:bac_project/core/services/cache/cache_manager.dart';
import 'package:bac_project/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:bac_project/features/auth/data/responses/get_user_data_response.dart';
import 'package:bac_project/features/auth/domain/requests/get_user_data_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AuthLocalDataSourceImplements dataSource;
  late CacheManager cacheManager;

  setUp(() {
    cacheManager = CacheManager();
    dataSource = AuthLocalDataSourceImplements(cacheManager: cacheManager);
  });

  group('AuthLocalDataSourceImplements', () {
    group('getUserData', () {
      test('should return GetUserDataResponse when data exists in cache', () async {
        // Arrange
        final request = GetUserDataRequest();

        // Act

        // Assert
      });

      test('should throw CacheEmptyException when no data exists in cache', () async {
        // Arrange
        final request = GetUserDataRequest();

        // Act

        // Assert
      });
    });
  });
}
