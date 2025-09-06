import 'package:dartz/dartz.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import '../../data/responses/get_app_settings_response.dart';
import '../repositories/settings_repository.dart';
import '../requests/get_app_settings_request.dart';

class GetAppSettingsUsecase {
  final SettingsRepository repository;

  GetAppSettingsUsecase({required this.repository});

  Future<Either<Failure, GetAppSettingsResponse>> call({
    required GetAppSettingsRequest request,
  }) async {
    return await repository.getAppSettings(request: request);
  }
}
