
import 'package:dartz/dartz.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:bac_project/features/notifications/domain/requests/register_device_token_request.dart';

class RegisterDeviceTokenUsecase {
  final NotificationsRepository repository;

  RegisterDeviceTokenUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(
    RegisterDeviceTokenRequest request,
  ) async {
    return await repository.registerDeviceToken(request);
  }
}
