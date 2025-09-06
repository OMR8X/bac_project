import 'package:dartz/dartz.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/notifications/domain/repositories/notifications_repository.dart';

class DeleteDeviceTokenUsecase {
  final NotificationsRepository repository;

  DeleteDeviceTokenUsecase({required this.repository});

  Future<Either<Failure, Unit>> call() async {
    return await repository.deleteDeviceToken();
  }
}
