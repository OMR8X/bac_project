
import 'package:dartz/dartz.dart';
import 'package:neuro_app/core/resources/errors/failures.dart';
import 'package:neuro_app/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:neuro_app/features/notifications/domain/requests/register_device_token_request.dart';

class RegisterDeviceTokenUsecase {
  final NotificationsRepository repository;

  RegisterDeviceTokenUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(
    RegisterDeviceTokenRequest request,
  ) async {
    return await repository.registerDeviceToken(request);
  }
}
