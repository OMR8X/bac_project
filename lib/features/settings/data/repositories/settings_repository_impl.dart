import 'package:bac_project/core/resources/errors/error_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import '../../domain/requests/get_app_settings_request.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_remote_datasource.dart';
import '../responses/get_app_settings_response.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsRemoteDatasource remoteDataSource;

  SettingsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, GetAppSettingsResponse>> getAppSettings({
    required GetAppSettingsRequest request,
  }) async {
    try {
      final response = await remoteDataSource.getAppSettings(request: request);
      return right(response);
    } catch (e) {
      return left(errorToFailure(e));
    }
  }
}
