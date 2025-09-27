import 'package:dartz/dartz.dart';

import 'package:bac_project/core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class SyncNotificationsUsecase {
  final NotificationsRepository repository;

  SyncNotificationsUsecase({required this.repository});

  Future<Either<Failure, Unit>> call() async {
    return await repository.syncNotifications();
  }
}
