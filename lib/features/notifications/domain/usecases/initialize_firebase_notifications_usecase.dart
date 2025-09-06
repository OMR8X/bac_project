import 'package:dartz/dartz.dart';

import 'package:bac_project/core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class InitializeFirebaseNotificationsUsecase {
  final NotificationsRepository repository;

  InitializeFirebaseNotificationsUsecase({required this.repository});

  Future<Either<Failure, Unit>> call() async {
    return await repository.initializeFirebaseNotification();
  }
}
