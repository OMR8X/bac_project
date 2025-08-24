import 'package:dartz/dartz.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import '../../data/responses/get_app_settings_response.dart';
import '../requests/get_app_settings_request.dart';

abstract class SettingsRepository {
  Future<Either<Failure, GetAppSettingsResponse>> getAppSettings({
    required GetAppSettingsRequest request,
  });
}
